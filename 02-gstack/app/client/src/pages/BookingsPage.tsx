import { useEffect, useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { CalendarX } from 'lucide-react';
import {
  api,
  formatDate,
  formatPrice,
  statusBadgeClass,
  statusLabel,
  type Booking,
} from '@/lib/api';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import { useT } from '@/i18n';

export function BookingsPage() {
  const { t } = useT();
  const location = useLocation();
  const [tab, setTab] = useState<'upcoming' | 'past'>('upcoming');
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [loading, setLoading] = useState(true);
  const [cancelMsg, setCancelMsg] = useState('');
  const [successMsg, setSuccessMsg] = useState(
    (location.state as { submittedPending?: boolean })?.submittedPending
      ? t('booking.submittedPending')
      : ''
  );

  const load = () => {
    setLoading(true);
    api<Booking[]>(`/bookings?filter=${tab}`)
      .then(setBookings)
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    load();
  }, [tab]);

  const handleCancel = async (id: number) => {
    setCancelMsg('');
    try {
      await api(`/bookings/${id}`, { method: 'DELETE' });
      load();
    } catch (err) {
      setCancelMsg(err instanceof Error ? err.message : t('bookings.cancelFailed'));
    }
  };

  const canCancel = (b: Booking) =>
    tab === 'upcoming' && (b.status === 'pending' || b.status === 'confirmed');

  return (
    <div>
      <header className="mb-6">
        <h1 className="font-display text-2xl font-bold md:text-3xl">{t('bookings.title')}</h1>
        <p className="mt-1 text-court-muted">{t('bookings.subtitle')}</p>
      </header>

      {successMsg && (
        <div className="mb-4 rounded-xl border border-green-200 bg-green-50 p-3 text-sm text-green-800">
          {successMsg}
        </div>
      )}

      <div className="mb-6 flex gap-2">
        {(['upcoming', 'past'] as const).map((tabKey) => (
          <button
            key={tabKey}
            type="button"
            onClick={() => setTab(tabKey)}
            className={cn(
              'min-h-11 rounded-xl px-5 text-sm font-medium',
              tab === tabKey
                ? 'bg-court-primary text-white'
                : 'border border-court-border bg-white text-court-muted'
            )}
          >
            {t(`bookings.${tabKey}`)}
          </button>
        ))}
      </div>

      {cancelMsg && (
        <div className="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-3 text-sm text-amber-800">
          {cancelMsg}
        </div>
      )}

      {loading ? (
        <div className="space-y-4">
          {[1, 2].map((i) => (
            <div key={i} className="h-28 animate-pulse rounded-2xl bg-gray-100" />
          ))}
        </div>
      ) : bookings.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-court-border bg-white py-12 text-center">
          <CalendarX className="mx-auto text-court-muted" size={40} />
          <p className="mt-3 font-medium">{t('bookings.emptyTitle')}</p>
          <p className="text-sm text-court-muted">{t('bookings.emptySubtitle')}</p>
          <Link to="/courts" className="mt-4 inline-block">
            <Button className="h-11">{t('bookings.browseCourts')}</Button>
          </Link>
        </div>
      ) : (
        <div className="space-y-4">
          {bookings.map((b) => (
            <article
              key={b.id}
              className="flex flex-col gap-3 rounded-2xl border border-court-border bg-white p-4 sm:flex-row sm:items-center"
            >
              {b.image_url && (
                <img
                  src={b.image_url}
                  alt=""
                  className="h-20 w-full rounded-xl object-cover sm:w-28"
                  onError={(e) => {
                    e.currentTarget.src = '/images/placeholder.svg';
                  }}
                />
              )}
              <div className="flex-1">
                <div className="flex flex-wrap items-center gap-2">
                  <h2 className="font-display font-semibold">{b.court_name}</h2>
                  <SportBadge sport={b.sport_type} />
                  <span
                    className={cn(
                      'rounded-lg px-2 py-0.5 text-xs font-medium',
                      statusBadgeClass(b.status)
                    )}
                  >
                    {statusLabel(b.status)}
                  </span>
                </div>
                <p className="mt-1 text-sm text-court-muted">
                  {formatDate(b.booking_date)} · {b.start_time}–{b.end_time}
                </p>
                <p className="text-sm text-court-muted">
                  {t('bookings.players', { count: b.player_count })} · {b.customer_name}
                </p>
              </div>
              <div className="flex items-center justify-between gap-4 sm:flex-col sm:items-end">
                <p className="font-display text-lg font-bold">{formatPrice(b.total_price)}</p>
                {canCancel(b) && (
                  <Button
                    variant="outline"
                    className="h-11 border-red-200 text-red-600 hover:bg-red-50"
                    onClick={() => handleCancel(b.id)}
                  >
                    {t('bookings.cancel')}
                  </Button>
                )}
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
