import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Users } from 'lucide-react';
import { api, formatPrice, type Court } from '@/lib/api';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import { useT } from '@/i18n';

export function CourtsPage() {
  const { t } = useT();
  const [courts, setCourts] = useState<Court[]>([]);
  const [sport, setSport] = useState('all');
  const [loading, setLoading] = useState(true);

  const filters = [
    { id: 'all', label: t('courts.filterAll') },
    { id: 'badminton', label: t('courts.filterBadminton') },
    { id: 'mini_football', label: t('courts.filterFootball') },
    { id: 'tennis', label: t('courts.filterTennis') },
  ];

  useEffect(() => {
    setLoading(true);
    const q = sport === 'all' ? '' : `?sport=${sport}`;
    api<Court[]>(`/courts${q}`)
      .then(setCourts)
      .finally(() => setLoading(false));
  }, [sport]);

  return (
    <div>
      <header className="mb-6">
        <h1 className="font-display text-2xl font-bold md:text-3xl">{t('courts.title')}</h1>
        <p className="mt-1 text-court-muted">{t('courts.subtitle')}</p>
      </header>

      <div className="mb-6 flex gap-2 overflow-x-auto pb-1">
        {filters.map((f) => (
          <button
            key={f.id}
            type="button"
            onClick={() => setSport(f.id)}
            className={cn(
              'min-h-11 shrink-0 rounded-xl px-4 text-sm font-medium transition-colors',
              sport === f.id
                ? 'bg-court-primary text-white'
                : 'border border-court-border bg-white text-court-muted'
            )}
          >
            {f.label}
          </button>
        ))}
      </div>

      {loading ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {[1, 2, 3].map((i) => (
            <div key={i} className="h-72 animate-pulse rounded-2xl bg-gray-100" />
          ))}
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {courts.map((court) => (
            <article
              key={court.id}
              className="overflow-hidden rounded-2xl border border-court-border bg-white shadow-sm"
            >
              <div className="relative aspect-video">
                <img
                  src={court.image_url}
                  alt={court.name}
                  className="h-full w-full object-cover"
                  onError={(e) => {
                    e.currentTarget.src = '/images/placeholder.svg';
                  }}
                />
                <div className="absolute left-3 top-3">
                  <SportBadge sport={court.sport_type} />
                </div>
              </div>
              <div className="p-4">
                <h2 className="font-display text-lg font-semibold">{court.name}</h2>
                <div className="mt-2 flex items-center gap-1 text-sm text-court-muted">
                  <Users size={16} />
                  {t('courts.capacity', { count: court.capacity })}
                </div>
                <p className="mt-2 font-display text-lg font-bold text-court-accent">
                  {formatPrice(court.hourly_price)}
                  <span className="text-sm font-normal text-court-muted"> {t('courts.perHour')}</span>
                </p>
                <Link to={`/courts/${court.id}/book`} className="mt-4 block">
                  <Button className="h-11 w-full">{t('courts.bookNow')}</Button>
                </Link>
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
