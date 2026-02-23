// src/prisma.ts
import 'dotenv/config';            // ให้ Prisma เห็น DATABASE_URL จาก .env
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  console.error('❌ Error: DATABASE_URL is not defined.');
  console.error('Please check your .env file (local) or your Render Environment Variables.');
}

// สร้าง adapter ต่อ PostgreSQL เฉพาะเมื่อมี connectionString
const adapter = connectionString ? new PrismaPg({
  connectionString,
}) : undefined;

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    ...(adapter && { adapter }), // ใช้ adapter เฉพาะเมื่อมีค่า
    log: ['query', 'info', 'warn', 'error'],
  });

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}
