import { Router } from 'express';
import { getDb } from '../../db/index.js';

const router = Router();

const SPORTS = ['badminton', 'mini_football', 'tennis'] as const;

router.get('/', (_req, res) => {
  const rows = getDb().prepare('SELECT * FROM courts ORDER BY id').all();
  res.json(rows);
});

router.post('/', (req, res) => {
  const { name, sport_type, capacity, hourly_price, image_url, enabled } = req.body;
  if (!name || !sport_type || !capacity || hourly_price == null) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }
  if (!SPORTS.includes(sport_type)) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  const result = getDb()
    .prepare(
      `INSERT INTO courts (name, sport_type, capacity, hourly_price, image_url, enabled)
       VALUES (?, ?, ?, ?, ?, ?)`
    )
    .run(
      name,
      sport_type,
      capacity,
      hourly_price,
      image_url ?? null,
      enabled === false || enabled === 0 ? 0 : 1
    );

  const row = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(result.lastInsertRowid);
  res.status(201).json(row);
});

router.patch('/:id', (req, res) => {
  const court = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(req.params.id);
  if (!court) {
    res.status(404).json({ error: 'COURT_NOT_FOUND' });
    return;
  }

  const { name, sport_type, capacity, hourly_price, image_url, enabled } = req.body;
  const current = court as {
    name: string;
    sport_type: string;
    capacity: number;
    hourly_price: number;
    image_url: string | null;
    enabled: number;
  };

  if (sport_type && !SPORTS.includes(sport_type)) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  getDb()
    .prepare(
      `UPDATE courts SET name = ?, sport_type = ?, capacity = ?, hourly_price = ?,
       image_url = ?, enabled = ? WHERE id = ?`
    )
    .run(
      name ?? current.name,
      sport_type ?? current.sport_type,
      capacity ?? current.capacity,
      hourly_price ?? current.hourly_price,
      image_url !== undefined ? image_url : current.image_url,
      enabled !== undefined ? (enabled === false || enabled === 0 ? 0 : 1) : current.enabled,
      req.params.id
    );

  const row = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(req.params.id);
  res.json(row);
});

router.delete('/:id', (req, res) => {
  const court = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(req.params.id);
  if (!court) {
    res.status(404).json({ error: 'COURT_NOT_FOUND' });
    return;
  }

  const active = getDb()
    .prepare(
      `SELECT COUNT(*) as count FROM bookings
       WHERE court_id = ? AND status IN ('pending', 'confirmed')`
    )
    .get(req.params.id) as { count: number };

  if (active.count > 0) {
    res.status(409).json({ error: 'COURT_HAS_BOOKINGS' });
    return;
  }

  getDb().prepare('DELETE FROM courts WHERE id = ?').run(req.params.id);
  res.json({ ok: true });
});

export default router;
