INSERT INTO items (name, description, image_url) VALUES
  ('Sample Item 1', 'Replace with seed data for your domain', 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop'),
  ('Sample Item 2', 'Replace with seed data for your domain', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&h=300&fit=crop');

-- Optional auth seed (uncomment when BA_BRIEF requires login + schema has users table):
-- INSERT INTO users (email, password_hash, role) VALUES
--   ('admin@demo.local', 'demo123', 'admin'),
--   ('user@demo.local', 'demo123', 'user');
-- Demo only — replace with bcrypt in production. See docs/DEMO_ACCOUNTS.md
