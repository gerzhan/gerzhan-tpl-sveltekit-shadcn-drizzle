import type { Config } from 'drizzle-kit';
import * as dotenv from 'dotenv';
dotenv.config();

const { DATABASE_URL = './localhost.db' } = process.env;

export default {
  schema: './drizzle/schema/index.ts',
  out: './drizzle/migrations',
  driver: 'better-sqlite',
  dbCredentials: {
    url: DATABASE_URL as string
  }
} satisfies Config;
