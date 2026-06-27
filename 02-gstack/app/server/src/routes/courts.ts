import { Router } from 'express';
import { getDb } from '../db/index.js';
import {
  generateHourlySlots,
  getSettings,
  hasOverlap,
  minutesToTime,
  timeToMinutes,
} from '../utils/booking.js';

const router = Router();

router.get('/', (req, res) => {
  const sport = req.query.sport as string | undefined;
  let sql = 'SELECT * FROM courts WHERE enabled = 1';
  const params: string[] = [];
  if (sport && sport !== 'all') {
    sql += ' AND sport_type = ?';
    params.push(sport);
  }
  sql += ' ORDER BY id';
  const rows = getDb().prepare(sql).all(...params);
  res.json(rows);
});

router.get('/:id', (req, res) => {
  const row = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(req.params.id);
  if (!row) {
    res.status(404).json({ error: 'COURT_NOT_FOUND' });
    return;
  }
  res.json(row);
});

router.get('/:id/slots', (req, res) => {
  const courtId = Number(req.params.id);
  const date = req.query.date as string;
  const duration = Number(req.query.duration) || 1;

  if (!date || !/^\d{4}-\d{2}-\d{2}$/.test(date)) {
    res.status(400).json({ error: 'DATE_REQUIRED' });
    return;
  }
  if (duration < 1 || duration > 3) {
    res.status(400).json({ error: 'DURATION_INVALID' });
    return;
  }

  const court = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(courtId);
  if (!court) {
    res.status(404).json({ error: 'COURT_NOT_FOUND' });
    return;
  }

  const { start, end } = getSettings();
  const startMin = timeToMinutes(start);
  const endMin = timeToMinutes(end);
  const now = new Date();
  const slots: { start_time: string; end_time: string; available: boolean }[] = [];

  for (let m = startMin; m + duration * 60 <= endMin; m += 60) {
    const startTime = minutesToTime(m);
    const endTime = minutesToTime(m + duration * 60);

    const [y, mo, d] = date.split('-').map(Number);
    const [h, mi] = startTime.split(':').map(Number);
    const slotStart = new Date(y, mo - 1, d, h, mi, 0);
    const twoHoursAhead = slotStart.getTime() - now.getTime() >= 2 * 60 * 60 * 1000;
    const overlap = hasOverlap(courtId, date, startTime, endTime);

    slots.push({
      start_time: startTime,
      end_time: endTime,
      available: twoHoursAhead && !overlap,
    });
  }

  res.json({ date, duration, operating_hours: { start, end }, slots });
});

export default router;
