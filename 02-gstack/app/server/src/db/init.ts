import Database from 'better-sqlite3';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const dataDir = path.join(__dirname, '../../data');
const dbPath = path.join(dataDir, 'app.db');

if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir, { recursive: true });
}

const db = new Database(dbPath);

// Migrate bookings table if old schema lacks 'pending' status
const bookingsExists = db
  .prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='bookings'")
  .get();
if (bookingsExists) {
  const sql = db
    .prepare("SELECT sql FROM sqlite_master WHERE type='table' AND name='bookings'")
    .get() as { sql: string } | undefined;
  if (sql && !sql.sql.includes('pending')) {
    db.exec('DROP TABLE IF EXISTS bookings');
    console.log('Migrated bookings table (added pending status)');
  }
}

const schema = fs.readFileSync(path.join(__dirname, 'schema.sql'), 'utf-8');
db.exec(schema);

const seed = fs.readFileSync(path.join(__dirname, 'seed.sql'), 'utf-8');
db.exec(seed);

console.log(`Database initialized at ${dbPath}`);
db.close();
