# Testing & Verification Checklist

## ✅ 1. Deployment Tests
- [ ] Run `deploy.bat` completes without errors.
- [ ] `docker-compose ps` shows all containers as `Up (healthy)`.

## ✅ 2. Functional Tests
- [ ] **Frontend**: Access `http://localhost/` in browser. UI should load.
- [ ] **API Access**: Access `http://localhost/api/tasks`. Should return JSON from backend.
- [ ] **Static Assets**: Inspect network tab for JS/CSS files. Should load with 200/304.
- [ ] **Health Check**: Access `http://localhost/health`. Should return `{"status":"UP",...}`.

## ✅ 3. Performance Tests
- [ ] **Gzip**: Check Response Headers for `Content-Encoding: gzip`.
- [ ] **Caching**: Check Response Headers for `Cache-Control: public, no-transform`.
- [ ] **Connection**: Check Response Headers for `Connection: keep-alive`.

## ✅ 4. Security Tests
- [ ] **Headers**: Check for `X-Frame-Options`, `X-Content-Type-Options`.
- [ ] **Internal Access**: Try accessing `http://localhost:3000`. Should be REFUSED (not exposed).

## ✅ 5. Error Handling
- [ ] **404**: Access a non-existent page like `http://localhost/not-found`. Should fall back to `index.html`.
- [ ] **502**: Stop the backend container and access `/api/demo`. Should show Nginx 502 page.
