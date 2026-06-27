import { Router } from 'express';
import { getDb } from '../db/index.js';
import { requireAuth } from '../middleware/auth.js';
import {
  canCancel,
  enrichBooking,
  filterBookings,
  hasOverlap,
  isAtLeast2HoursAhead,
  minutesToTime,
  timeToMinutes,
} from '../utils/booking.js';

const router = Router();

router.use(requireAuth);

router.get('/', (req, res) => {
  const filter = (req.query.filter as string) || 'all';
  const userId = req.user!.id;

  const rows = getDb()
    .prepare(
      `SELECT b.*, c.name as court_name, c.sport_type, c.image_url
       FROM bookings b
       JOIN courts c ON c.id = b.court_id
       WHERE b.user_id = ?
       ORDER BY b.booking_date DESC, b.start_time DESC`
    )
    .all(userId);

  const enriched = rows.map((b) => enrichBooking(b as Parameters<typeof enrichBooking>[0]));
  res.json(filterBookings(enriched, filter));
});

router.post('/', (req, res) => {
  const { court_id, booking_date, start_time, duration, customer_name, phone, player_count } =
    req.body;

  if (!court_id || !booking_date || !start_time || !customer_name || !phone || !player_count) {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  const dur = Number(duration) || 1;
  if (dur < 1 || dur > 3) {
    res.status(400).json({ error: 'DURATION_INVALID' });
    return;
  }

  const court = getDb().prepare('SELECT * FROM courts WHERE id = ?').get(court_id) as
    | { id: number; capacity: number; hourly_price: number; enabled: number }
    | undefined;

  if (!court || !court.enabled) {
    res.status(404).json({ error: 'COURT_NOT_FOUND' });
    return;
  }

  if (Number(player_count) > court.capacity) {
    res.status(400).json({
      error: 'CAPACITY_EXCEEDED',
      params: { max: court.capacity },
    });
    return;
  }

  if (!isAtLeast2HoursAhead(booking_date, start_time)) {
    res.status(400).json({ error: 'ADVANCE_2H' });
    return;
  }

  const end_time = minutesToTime(timeToMinutes(start_time) + dur * 60);

  if (hasOverlap(court_id, booking_date, start_time, end_time)) {
    res.status(409).json({ error: 'BOOKING_CONFLICT' });
    return;
  }

  const total_price = court.hourly_price * dur;
  const result = getDb()
    .prepare(
      `INSERT INTO bookings (user_id, court_id, booking_date, start_time, end_time,
        customer_name, phone, player_count, total_price, status)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')`
    )
    .run(
      req.user!.id,
      court_id,
      booking_date,
      start_time,
      end_time,
      customer_name,
      phone,
      player_count,
      total_price
    );

  const booking = getDb()
    .prepare(
      `SELECT b.*, c.name as court_name, c.sport_type FROM bookings b
       JOIN courts c ON c.id = b.court_id WHERE b.id = ?`
    )
    .get(result.lastInsertRowid);

  res.status(201).json(booking);
});

router.delete('/:id', (req, res) => {
  const booking = getDb()
    .prepare('SELECT * FROM bookings WHERE id = ? AND user_id = ?')
    .get(req.params.id, req.user!.id) as
    | { id: number; booking_date: string; start_time: string; status: string }
    | undefined;

  if (!booking) {
    res.status(404).json({ error: 'BOOKING_NOT_FOUND' });
    return;
  }

  if (booking.status === 'cancelled') {
    res.status(400).json({ error: 'BOOKING_ALREADY_CANCELLED' });
    return;
  }

  if (booking.status !== 'pending' && booking.status !== 'confirmed') {
    res.status(400).json({ error: 'CANCEL_STARTED' });
    return;
  }

  const { allowed, warning } = canCancel(
    booking.booking_date,
    booking.start_time,
    booking.status
  );

  if (!allowed) {
    res.status(400).json({
      error: warning ? 'CANCEL_24H' : 'CANCEL_STARTED',
      warning,
    });
    return;
  }

  getDb().prepare("UPDATE bookings SET status = 'cancelled' WHERE id = ?").run(booking.id);
  res.json({ ok: true });
});

export default router;
