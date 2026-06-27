import { Router } from 'express';
import { getDb } from '../../db/index.js';
import { enrichBooking, filterBookings } from '../../utils/booking.js';

const router = Router();

router.get('/', (req, res) => {
  const filter = (req.query.filter as string) || 'all';

  const rows = getDb()
    .prepare(
      `SELECT b.*, c.name as court_name, c.sport_type, c.image_url,
              u.name as user_name, u.email as user_email
       FROM bookings b
       JOIN courts c ON c.id = b.court_id
       JOIN users u ON u.id = b.user_id
       ORDER BY b.booking_date DESC, b.start_time DESC`
    )
    .all();

  const enriched = rows.map((b) => enrichBooking(b as Parameters<typeof enrichBooking>[0]));
  res.json(filterBookings(enriched, filter));
});

router.patch('/:id', (req, res) => {
  const { action } = req.body;
  if (action !== 'confirm' && action !== 'reject') {
    res.status(400).json({ error: 'FIELDS_REQUIRED' });
    return;
  }

  const booking = getDb()
    .prepare('SELECT * FROM bookings WHERE id = ?')
    .get(req.params.id) as { id: number; status: string } | undefined;

  if (!booking) {
    res.status(404).json({ error: 'BOOKING_NOT_FOUND' });
    return;
  }

  if (booking.status !== 'pending') {
    res.status(400).json({ error: 'BOOKING_NOT_PENDING' });
    return;
  }

  const newStatus = action === 'confirm' ? 'confirmed' : 'cancelled';
  getDb().prepare('UPDATE bookings SET status = ? WHERE id = ?').run(newStatus, booking.id);

  const updated = getDb()
    .prepare(
      `SELECT b.*, c.name as court_name, c.sport_type, c.image_url,
              u.name as user_name, u.email as user_email
       FROM bookings b
       JOIN courts c ON c.id = b.court_id
       JOIN users u ON u.id = b.user_id
       WHERE b.id = ?`
    )
    .get(booking.id);

  res.json(updated);
});

export default router;
