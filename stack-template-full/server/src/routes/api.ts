import { Router } from 'express';
import { getDb } from '../db/index.js';

const router = Router();

router.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

router.get('/items', (_req, res) => {
  const rows = getDb().prepare('SELECT * FROM items ORDER BY id').all();
  res.json(rows);
});

router.post('/items', (req, res) => {
  const { name, description, image_url } = req.body;
  if (!name) {
    res.status(400).json({ error: 'name is required' });
    return;
  }
  const result = getDb()
    .prepare('INSERT INTO items (name, description, image_url) VALUES (?, ?, ?)')
    .run(name, description ?? null, image_url ?? null);
  const row = getDb().prepare('SELECT * FROM items WHERE id = ?').get(result.lastInsertRowid);
  res.status(201).json(row);
});

export default router;
