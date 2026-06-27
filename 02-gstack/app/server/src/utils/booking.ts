import { getDb } from '../db/index.js';

export function getSettings() {
  const rows = getDb().prepare('SELECT key, value FROM settings').all() as { key: string; value: string }[];
  const map = Object.fromEntries(rows.map((r) => [r.key, r.value]));
  return {
    start: map.operating_hours_start ?? '06:00',
    end: map.operating_hours_end ?? '22:00',
  };
}

export function timeToMinutes(t: string): number {
  const [h, m] = t.split(':').map(Number);
  return h * 60 + (m || 0);
}

export function minutesToTime(mins: number): string {
  const h = Math.floor(mins / 60);
  const m = mins % 60;
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
}

export function generateHourlySlots(): string[] {
  const { start, end } = getSettings();
  const startMin = timeToMinutes(start);
  const endMin = timeToMinutes(end);
  const slots: string[] = [];
  for (let m = startMin; m < endMin; m += 60) {
    slots.push(minutesToTime(m));
  }
  return slots;
}

export function getBookingStart(date: string, startTime: string): Date {
  const [y, mo, d] = date.split('-').map(Number);
  const [h, mi] = startTime.split(':').map(Number);
  return new Date(y, mo - 1, d, h, mi, 0);
}

export function hasOverlap(
  courtId: number,
  date: string,
  startTime: string,
  endTime: string,
  excludeId?: number
): boolean {
  const bookings = getDb()
    .prepare(
      `SELECT id, start_time, end_time FROM bookings
       WHERE court_id = ? AND booking_date = ? AND status IN ('pending', 'confirmed')`
    )
    .all(courtId, date) as { id: number; start_time: string; end_time: string }[];

  const newStart = timeToMinutes(startTime);
  const newEnd = timeToMinutes(endTime);

  return bookings.some((b) => {
    if (excludeId && b.id === excludeId) return false;
    const bStart = timeToMinutes(b.start_time);
    const bEnd = timeToMinutes(b.end_time);
    return newStart < bEnd && newEnd > bStart;
  });
}

export function isAtLeast2HoursAhead(date: string, startTime: string): boolean {
  const bookingStart = getBookingStart(date, startTime);
  const diffMs = bookingStart.getTime() - Date.now();
  return diffMs >= 2 * 60 * 60 * 1000;
}

export function canCancel(
  date: string,
  startTime: string,
  status: string
): { allowed: boolean; warning: boolean } {
  const bookingStart = getBookingStart(date, startTime);
  const diffMs = bookingStart.getTime() - Date.now();

  if (status === 'pending') {
    if (diffMs <= 0) return { allowed: false, warning: false };
    return { allowed: true, warning: false };
  }

  if (diffMs <= 0) return { allowed: false, warning: false };
  if (diffMs < 24 * 60 * 60 * 1000) return { allowed: false, warning: true };
  return { allowed: true, warning: false };
}

export interface BookingRow {
  booking_date: string;
  start_time: string;
  status: string;
}

export function enrichBooking<T extends BookingRow>(b: T, now = new Date()) {
  const start = getBookingStart(b.booking_date, b.start_time);
  const isPastStart = start.getTime() < now.getTime();
  const isUpcoming =
    !isPastStart && (b.status === 'pending' || b.status === 'confirmed');
  const isPast =
    isPastStart ||
    b.status === 'cancelled' ||
    b.status === 'completed' ||
    (b.status === 'pending' && isPastStart);

  return { ...b, is_upcoming: isUpcoming, is_past: isPast };
}

export function filterBookings<T extends BookingRow & { is_upcoming?: boolean; is_past?: boolean }>(
  rows: T[],
  filter: string
): T[] {
  if (filter === 'upcoming') return rows.filter((b) => b.is_upcoming);
  if (filter === 'past') return rows.filter((b) => b.is_past);
  return rows;
}
