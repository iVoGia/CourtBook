import { useEffect, useState } from 'react';
import { CalendarX } from 'lucide-react';
import {
  api,
  formatDate,
  formatPrice,
  statusLabel,
  type AdminBooking,
} from '@/lib/api';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import { useT } from '@/i18n';

export function AdminBookingsPage() {
  const { t } = useT();
  const [tab, setTab] = useState<'upcoming' | 'past'>('upcoming');
  const [bookings, setBookings] = useState<AdminBooking[]>([]);
  const [loading, setLoading] = useState(true);
  const [msg, setMsg] = useState('');

  const load = () => {
    setLoading(true);
    api<AdminBooking[]>(`/admin/bookings?filter=${tab}`)
      .then(setBookings)
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    load();
  }, [tab]);

  const handleAction = async (id: number, action: 'confirm' | 'reject') => {
    setMsg('');
    try {
      await api(`/admin/bookings/${id}`, {
        method: 'PATCH',
        body: JSON.stringify({ action }),
      });
      load();
    } catch (err) {
      setMsg(err instanceof Error ? err.message : t('admin.bookings.actionFailed'));
    }
  };

  return (
    <div>
      <header className="mb-6">
        <h1 className="font-display text-2xl font-bold md:text-3xl">{t('admin.bookings.title')}</h1>
        <p className="mt-1 text-court-muted">{t('admin.bookings.subtitle')}</p>
      </header>

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

      {msg && (
        <div className="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-3 text-sm text-amber-800">
          {msg}
        </div>
      )}

      {loading ? (
        <div className="space-y-4">
          {[1, 2].map((i) => (
            <div key={i} className="h-32 animate-pulse rounded-2xl bg-gray-100" />
          ))}
        </div>
      ) : bookings.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-court-border bg-white py-12 text-center">
          <CalendarX className="mx-auto text-court-muted" size={40} />
          <p className="mt-3 font-medium">{t('bookings.emptyTitle')}</p>
        </div>
      ) : (
        <div className="space-y-4">
          {bookings.map((b) => (
            <article
              key={b.id}
              className="rounded-2xl border border-court-border bg-white p-4"
            >
              <div className="flex flex-wrap items-center gap-2">
                <h2 className="font-display font-semibold">{b.court_name}</h2>
                <SportBadge sport={b.sport_type} />
                <span
                  className={cn(
                    'rounded-lg px-2 py-0.5 text-xs font-medium',
                    b.status === 'pending' && 'bg-amber-100 text-amber-800',
                    b.status === 'confirmed' && 'bg-green-100 text-green-700',
                    b.status === 'cancelled' && 'bg-red-100 text-red-700',
                    b.status === 'completed' && 'bg-gray-100 text-gray-600'
                  )}
                >
                  {statusLabel(b.status)}
                </span>
              </div>
              <p className="mt-2 text-sm text-court-muted">
                {formatDate(b.booking_date)} · {b.start_time}–{b.end_time}
              </p>
              <p className="text-sm text-court-muted">
                {t('admin.bookings.customer', { name: b.customer_name, phone: b.phone })}
              </p>
              <p className="text-sm text-court-muted">
                {t('admin.bookings.bookedBy', { name: b.user_name })}
              </p>
              <p className="mt-1 font-display font-bold">{formatPrice(b.total_price)}</p>
              {b.status === 'pending' && tab === 'upcoming' && (
                <div className="mt-4 flex flex-col gap-2 sm:flex-row">
                  <Button className="h-11 flex-1" onClick={() => handleAction(b.id, 'confirm')}>
                    {t('admin.bookings.confirm')}
                  </Button>
                  <Button
                    variant="outline"
                    className="h-11 flex-1 border-red-200 text-red-600 hover:bg-red-50"
                    onClick={() => handleAction(b.id, 'reject')}
                  >
                    {t('admin.bookings.reject')}
                  </Button>
                </div>
              )}
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
