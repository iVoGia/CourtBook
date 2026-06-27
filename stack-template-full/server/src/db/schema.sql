CREATE TABLE IF NOT EXISTS items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

-- Optional auth (uncomment when BA_BRIEF requires login):
-- CREATE TABLE IF NOT EXISTS users (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   email TEXT UNIQUE NOT NULL,
--   password_hash TEXT NOT NULL,
--   role TEXT DEFAULT 'user',
--   created_at TEXT DEFAULT (datetime('now'))
-- );
