import { Router } from 'express';
import { getDb } from '../../db/index.js';
import { getSettings } from '../../utils/booking.js';

const router = Router();

router.get('/', (_req, res) => {
  const { start, end } = getSettings();
  res.json({
    operating_hours_start: start,
    operating_hours_end: end,
  });
});

router.patch('/', (req, res) => {
  const { operating_hours_start, operating_hours_end } = req.body;
  if (!operating_hours_start || !operating_hours_end) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  const timeRe = /^\d{2}:\d{2}$/;
  if (!timeRe.test(operating_hours_start) || !timeRe.test(operating_hours_end)) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  getDb()
    .prepare('INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)')
    .run('operating_hours_start', operating_hours_start);
  getDb()
    .prepare('INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)')
    .run('operating_hours_end', operating_hours_end);

  res.json({
    operating_hours_start,
    operating_hours_end,
  });
});

export default router;
