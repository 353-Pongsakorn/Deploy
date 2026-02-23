# 🌐 Deployment Guide: Netlify (Frontend) & Render (Backend)

เมื่อต้องการนำโปรเจกต์ขึ้น Cloud โดยใช้ Netlify และ Render เราจะไม่ได้ใช้ Nginx Proxy ที่เราตั้งค่าไว้ (เพราะทั้งสองบริการมี Proxy/Load Balancer ของตัวเอง) แต่จะแยกส่วนกันดังนี้:

---

## 1. Deploy Backend (ที่ Render.com)

Render เหมาะสำหรับรัน Node.js API และรองรับ Docker

### ขั้นตอน:
1. **GitHub**: Push โค้ดทั้งหมดขึ้น GitHub (Private หรือ Public ก็ได้)
2. **Create Web Service**: ใน Render.com เลือก + New > Web Service
3. **Connect Repository**: เลือก repo ของคุณ
4. **Settings**:
   - **Name**: `my-api-backend`
   - **Environment**: `Docker`
   - **Docker Command**: (ปล่อยว่าง ถ้าใน Dockerfile มี CMD อยู่แล้ว)
   - **Docker Context**: `backend` (สำคัญมาก! เพื่อให้ Render รู้ว่า Dockerfile อยู่ในโฟลเดอร์ backend)
   - **Dockerfile Path**: `backend/Dockerfile`
5. **Environment Variables**: เพิ่มตัวแปรจากไฟล์ `backend/.env` ทั้งหมด โดยเฉพาะ:
   - `DATABASE_URL`: (Link จาก Supabase)
   - `PORT`: 3000

---

## 2. Deploy Frontend (ที่ Netlify.com)

Netlify เหมาะสำหรับรัน Quasar/Vue (Static Site)

### ขั้นตอน:
1. **GitHub**: ใช้ repo เดียวกันกับ Backend
2. **Add New Site**: ใน Netlify เลือก Import from git
3. **Settings**:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `frontend/dist/spa`
4. **Environment Variables**:
   - เพิ่ม `VITE_API_URL`: ใส่ URL ที่ได้จาก Render (เช่น `https://my-api-backend.onrender.com`)

---

## ⚠️ สิ่งที่ต้องระวัง (CRITICAL)

### 1. CORS Issue
เมื่อแยก Domain กัน (Netlify บนโดเมนหนึ่ง, Render อีกโดเมนหนึ่ง) คุณต้องไปตั้งค่าที่ Backend เพื่ออนุญาตให้ Netlify เข้าถึงได้:
ในไฟล์ `backend/app.js` (หรือไฟล์หลักของ backend):
```javascript
const cors = require('cors');
app.use(cors({
  origin: 'https://your-site-name.netlify.app' // URL ของ Netlify
}));
```

### 2. VITE_API_URL
ในตอนที่เราใช้ Nginx Proxy เราใช้ `/api` (Relative path) แต่เมื่อแยกตึกกันบน Cloud คุณ **ต้องระบุ Full URL** ของ Render Backend ใน Environment Variable ของ Netlify ครับ

### 3. Prisma
อย่าลืมรัน `npx prisma db push` หรือ `migrate` ให้เรียบร้อยเพื่อให้ Database ใน Supabase พร้อมใช้งาน

---

## 🔍 Troubleshooting (ถ้าข้อมูลไม่ขึ้น)

### 1. ทำไมยังเรียก localhost:3000?
เป็นเพราะ Quasar จำค่าตอนที่ Build ครั้งล่าสุดไว้:
- **วิธีแก้**: เมื่อตั้งค่า Environment Variable ใน Netlify เสร็จแล้ว **ต้องกดปุ่ม "Deploy site" -> "Clear cache and deploy site"** อีก 1 รอบครับ เพื่อให้มัน Build ใหม่ด้วย URL ของ Render

### 2. ทำไมขึ้น Internal Server Error (500)?
มักเกิดจาก Backend เชื่อมต่อ Database ไม่ได้:
- **รหัสผ่าน**: ตรวจสอบว่าใน Render ได้ใส่ `DATABASE_URL` โดยเปลี่ยน `#` เป็น `%23` หรือยัง?
- **IP Allowlist**: ใน Supabase ต้องไปที่ **Settings > Network** แล้วกด **"Allow access from anywhere"** (หรือใส่ IP ของ Render) เพื่อให้ Render เข้าไปอ่านข้อมูลได้ครับ

### 3. ตัวแปรใน Netlify
แนะนำให้ใส่ทั้ง 2 ตัวเพื่อความชัวร์:
- `VITE_API_URL` = `https://your-backend.onrender.com`
- `API_URL` = `https://your-backend.onrender.com`
