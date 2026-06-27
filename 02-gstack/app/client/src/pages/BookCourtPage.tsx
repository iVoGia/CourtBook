import { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';
import { api, formatPrice, type Court, type Slot } from '@/lib/api';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/context/AuthContext';
import { cn } from '@/lib/utils';
import { useT } from '@/i18n';

function nextDays(count: number) {
  const days: { value: string; label: string }[] = [];
  for (let i = 0; i < count; i++) {
    const d = new Date();
    d.setDate(d.getDate() + i);
    const value = d.toISOString().slice(0, 10);
    const label = d.toLocaleDateString('vi-VN', { weekday: 'short', day: 'numeric', month: 'short' });
    days.push({ value, label });
  }
  return days;
}

export function BookCourtPage() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { t } = useT();
  const days = useMemo(() => nextDays(7), []);

  const [court, setCourt] = useState<Court | null>(null);
  const [date, setDate] = useState(days[0].value);
  const [duration, setDuration] = useState(1);
  const [slots, setSlots] = useState<Slot[]>([]);
  const [selectedSlot, setSelectedSlot] = useState<Slot | null>(null);
  const [customerName, setCustomerName] = useState(user?.name || '');
  const [phone, setPhone] = useState('');
  const [playerCount, setPlayerCount] = useState(2);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [step, setStep] = useState(1);

  useEffect(() => {
    api<Court>(`/courts/${id}`).then(setCourt).catch(() => setCourt(null));
  }, [id]);

  useEffect(() => {
    if (!id) return;
    api<{ slots: Slot[] }>(`/courts/${id}/slots?date=${date}&duration=${duration}`)
      .then((d) => {
        setSlots(d.slots);
        setSelectedSlot(null);
      })
      .catch(() => setSlots([]));
  }, [id, date, duration]);

  const totalPrice = court ? court.hourly_price * duration : 0;

  const handleConfirm = async () => {
    if (!selectedSlot || !court) return;
    setError('');
    setLoading(true);
    try {
      await api('/bookings', {
        method: 'POST',
        body: JSON.stringify({
          court_id: court.id,
          booking_date: date,
          start_time: selectedSlot.start_time,
          duration,
          customer_name: customerName,
          phone,
          player_count: playerCount,
        }),
      });
      navigate('/bookings', { state: { submittedPending: true } });
    } catch (err) {
      setError(err instanceof Error ? err.message : t('booking.bookingFailed'));
    } finally {
      setLoading(false);
    }
  };

  if (!court) {
    return <div className="animate-pulse rounded-2xl bg-gray-100 p-8">{t('booking.loadingCourt')}</div>;
  }

  return (
    <div>
      <Link
        to="/courts"
        className="mb-4 inline-flex min-h-11 items-center gap-2 text-sm text-court-muted hover:text-court-ink"
      >
        <ArrowLeft size={18} />
        {t('booking.backToCourts')}
      </Link>

      <div className="mb-6 flex flex-wrap items-start justify-between gap-4">
        <div>
          <SportBadge sport={court.sport_type} />
          <h1 className="mt-2 font-display text-2xl font-bold">{court.name}</h1>
          <p className="text-court-muted">
            {formatPrice(court.hourly_price)}
            {t('booking.perHour')}
          </p>
        </div>
        <div className="flex gap-1 rounded-xl bg-gray-100 p-1">
          {[1, 2, 3].map((d) => (
            <button
              key={d}
              type="button"
              onClick={() => setDuration(d)}
              className={cn(
                'min-h-11 rounded-lg px-4 text-sm font-medium',
                duration === d ? 'bg-white shadow-sm' : 'text-court-muted'
              )}
            >
              {t('booking.durationHours', { h: d })}
            </button>
          ))}
        </div>
      </div>

      <div className="mb-6 flex gap-2 lg:hidden">
        {[1, 2, 3].map((s) => (
          <div
            key={s}
            className={cn('h-1 flex-1 rounded-full', step >= s ? 'bg-court-primary' : 'bg-gray-200')}
          />
        ))}
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <section className={cn(step !== 1 && 'hidden lg:block')}>
          <h2 className="mb-3 font-display text-lg font-semibold">{t('booking.stepDate')}</h2>
          <div className="flex gap-2 overflow-x-auto pb-2">
            {days.map((d) => (
              <button
                key={d.value}
                type="button"
                onClick={() => {
                  setDate(d.value);
                  setStep(2);
                }}
                className={cn(
                  'min-h-11 shrink-0 rounded-xl border px-3 text-sm font-medium',
                  date === d.value
                    ? 'border-court-primary bg-teal-50 text-court-primary'
                    : 'border-court-border bg-white'
                )}
              >
                {d.label}
              </button>
            ))}
          </div>

          <h2 className="mb-3 mt-6 font-display text-lg font-semibold">{t('booking.stepTime')}</h2>
          <div className="flex flex-wrap gap-2">
            {slots.map((slot) => (
              <button
                key={slot.start_time}
                type="button"
                disabled={!slot.available}
                onClick={() => {
                  setSelectedSlot(slot);
                  setStep(3);
                }}
                className={cn(
                  'min-h-11 min-w-[5.5rem] rounded-lg border px-3 text-sm font-medium transition-transform active:scale-95',
                  !slot.available && 'cursor-not-allowed opacity-40 line-through',
                  selectedSlot?.start_time === slot.start_time
                    ? 'border-court-primary bg-court-primary text-white'
                    : slot.available
                      ? 'border-court-border bg-white hover:border-court-primary'
                      : 'border-gray-200 bg-gray-50'
                )}
              >
                {slot.start_time}
              </button>
            ))}
          </div>
        </section>

        <section className={cn(step !== 3 && 'hidden lg:block')}>
          <h2 className="mb-3 font-display text-lg font-semibold">{t('booking.stepDetails')}</h2>
          <div className="space-y-4 rounded-2xl border border-court-border bg-white p-4">
            <div>
              <label className="mb-1 block text-sm font-medium">{t('booking.customerName')}</label>
              <input
                value={customerName}
                onChange={(e) => setCustomerName(e.target.value)}
                className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
                required
              />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">{t('booking.phone')}</label>
              <input
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
                placeholder={t('booking.phonePlaceholder')}
                required
              />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">
                {t('booking.maxPlayers', { max: court.capacity })}
              </label>
              <input
                type="number"
                min={1}
                max={court.capacity}
                value={playerCount}
                onChange={(e) => setPlayerCount(Number(e.target.value))}
                className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
              />
            </div>
            {error && <p className="text-sm text-red-600">{error}</p>}
          </div>
        </section>
      </div>

      <div className="fixed bottom-16 left-0 right-0 border-t border-court-border bg-white p-4 lg:static lg:mt-8 lg:border-0 lg:bg-transparent lg:p-0">
        <div className="mx-auto flex max-w-5xl items-center justify-between gap-4">
          <div>
            <p className="text-xs text-court-muted">{t('booking.total')}</p>
            <p className="font-display text-xl font-bold text-court-accent">
              {formatPrice(totalPrice)}
            </p>
            {selectedSlot && (
              <p className="text-xs text-court-muted">
                {date} · {selectedSlot.start_time}–{selectedSlot.end_time}
              </p>
            )}
          </div>
          <Button
            className="h-11 min-w-[8rem] px-6"
            disabled={!selectedSlot || !customerName || !phone || loading}
            onClick={handleConfirm}
          >
            {loading ? t('booking.booking') : t('booking.confirm')}
          </Button>
        </div>
      </div>
    </div>
  );
}
