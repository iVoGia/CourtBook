import { Router } from 'express';
import { getDb } from '../db/index.js';
import { createToken, hashPassword } from '../utils/crypto.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.post('/register', (req, res) => {
  const { email, password, name } = req.body;
  if (!email || !password || !name) {
    res.status(400).json({ error: 'AUTH_REGISTER_FIELDS_REQUIRED' });
    return;
  }
  try {
    const result = getDb()
      .prepare('INSERT INTO users (email, password_hash, name, role) VALUES (?, ?, ?, ?)')
      .run(email, hashPassword(password), name, 'user');
    const user = getDb()
      .prepare('SELECT id, email, name, role FROM users WHERE id = ?')
      .get(result.lastInsertRowid);
    const token = createToken();
    getDb().prepare('INSERT INTO sessions (token, user_id) VALUES (?, ?)').run(token, result.lastInsertRowid);
    res.status(201).json({ token, user });
  } catch {
    res.status(400).json({ error: 'AUTH_EMAIL_EXISTS' });
  }
});

router.post('/login', (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    res.status(400).json({ error: 'AUTH_LOGIN_FIELDS_REQUIRED' });
    return;
  }
  const user = getDb()
    .prepare('SELECT id, email, name, role, password_hash FROM users WHERE email = ?')
    .get(email) as { id: number; email: string; name: string; role: string; password_hash: string } | undefined;

  if (!user || user.password_hash !== hashPassword(password)) {
    res.status(401).json({ error: 'AUTH_INVALID' });
    return;
  }
  const token = createToken();
  getDb().prepare('INSERT INTO sessions (token, user_id) VALUES (?, ?)').run(token, user.id);
  res.json({
    token,
    user: { id: user.id, email: user.email, name: user.name, role: user.role },
  });
});

router.get('/me', requireAuth, (req, res) => {
  res.json({ user: req.user });
});

router.post('/logout', requireAuth, (req, res) => {
  const header = req.headers.authorization;
  if (header?.startsWith('Bearer ')) {
    getDb().prepare('DELETE FROM sessions WHERE token = ?').run(header.slice(7));
  }
  res.json({ ok: true });
});

export default router;
