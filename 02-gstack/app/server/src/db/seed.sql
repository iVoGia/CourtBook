DELETE FROM bookings;
DELETE FROM sessions;
DELETE FROM courts;
DELETE FROM users;

INSERT INTO users (email, password_hash, name, role) VALUES
  ('user@demo.com', 'd3ad9315b7be5dd53b31a273b3b3aba5defe700808305aa16a3062b76658a791', 'Người dùng demo', 'user'),
  ('admin@demo.com', 'd3ad9315b7be5dd53b31a273b3b3aba5defe700808305aa16a3062b76658a791', 'Admin Lan', 'admin');

INSERT INTO courts (name, sport_type, capacity, hourly_price, image_url) VALUES
  ('Sân cầu lông A', 'badminton', 4, 120000,
   'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=400&h=225&fit=crop'),
  ('Sân mini football A', 'mini_football', 10, 350000,
   'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=225&fit=crop'),
  ('Sân tennis A', 'tennis', 4, 200000,
   'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=400&h=225&fit=crop');
