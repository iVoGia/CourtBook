import { useEffect, useState } from 'react';
import { api, formatPrice, sportLabel, type AdminCourt } from '@/lib/api';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { useT } from '@/i18n';

const SPORTS = ['badminton', 'mini_football', 'tennis'] as const;

const emptyForm = {
  name: '',
  sport_type: 'badminton' as (typeof SPORTS)[number],
  capacity: 4,
  hourly_price: 100000,
  image_url: '',
  enabled: true,
};

export function AdminCourtsPage() {
  const { t } = useT();
  const [courts, setCourts] = useState<AdminCourt[]>([]);
  const [loading, setLoading] = useState(true);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [form, setForm] = useState(emptyForm);
  const [showForm, setShowForm] = useState(false);
  const [error, setError] = useState('');

  const load = () => {
    setLoading(true);
    api<AdminCourt[]>('/admin/courts')
      .then(setCourts)
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    load();
  }, []);

  const openCreate = () => {
    setEditingId(null);
    setForm(emptyForm);
    setShowForm(true);
    setError('');
  };

  const openEdit = (court: AdminCourt) => {
    setEditingId(court.id);
    setForm({
      name: court.name,
      sport_type: court.sport_type as (typeof SPORTS)[number],
      capacity: court.capacity,
      hourly_price: court.hourly_price,
      image_url: court.image_url || '',
      enabled: !!court.enabled,
    });
    setShowForm(true);
    setError('');
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      const body = {
        ...form,
        hourly_price: Number(form.hourly_price),
        capacity: Number(form.capacity),
        enabled: form.enabled ? 1 : 0,
      };
      if (editingId) {
        await api(`/admin/courts/${editingId}`, { method: 'PATCH', body: JSON.stringify(body) });
      } else {
        await api('/admin/courts', { method: 'POST', body: JSON.stringify(body) });
      }
      setShowForm(false);
      load();
    } catch (err) {
      setError(err instanceof Error ? err.message : t('admin.courts.saveFailed'));
    }
  };

  const handleDelete = async (id: number) => {
    if (!confirm(t('admin.courts.deleteConfirm'))) return;
    try {
      await api(`/admin/courts/${id}`, { method: 'DELETE' });
      load();
    } catch (err) {
      setError(err instanceof Error ? err.message : t('admin.courts.deleteFailed'));
    }
  };

  return (
    <div>
      <header className="mb-6 flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="font-display text-2xl font-bold md:text-3xl">{t('admin.courts.title')}</h1>
          <p className="mt-1 text-court-muted">{t('admin.courts.subtitle')}</p>
        </div>
        <Button className="h-11" onClick={openCreate}>
          {t('admin.courts.add')}
        </Button>
      </header>

      {error && (
        <div className="mb-4 rounded-xl border border-red-200 bg-red-50 p-3 text-sm text-red-700">
          {error}
        </div>
      )}

      {showForm && (
        <form
          onSubmit={handleSave}
          className="mb-6 space-y-4 rounded-2xl border border-court-border bg-white p-4"
        >
          <div>
            <label className="mb-1 block text-sm font-medium">{t('admin.courts.name')}</label>
            <input
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
              required
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium">{t('admin.courts.sport')}</label>
            <select
              value={form.sport_type}
              onChange={(e) =>
                setForm({ ...form, sport_type: e.target.value as (typeof SPORTS)[number] })
              }
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
            >
              {SPORTS.map((s) => (
                <option key={s} value={s}>
                  {sportLabel(s)}
                </option>
              ))}
            </select>
          </div>
          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <label className="mb-1 block text-sm font-medium">{t('admin.courts.capacity')}</label>
              <input
                type="number"
                min={1}
                value={form.capacity}
                onChange={(e) => setForm({ ...form, capacity: Number(e.target.value) })}
                className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
                required
              />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">{t('admin.courts.price')}</label>
              <input
                type="number"
                min={0}
                value={form.hourly_price}
                onChange={(e) => setForm({ ...form, hourly_price: Number(e.target.value) })}
                className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
                required
              />
            </div>
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium">{t('admin.courts.imageUrl')}</label>
            <input
              value={form.image_url}
              onChange={(e) => setForm({ ...form, image_url: e.target.value })}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
            />
          </div>
          <label className="flex min-h-11 items-center gap-2 text-sm">
            <input
              type="checkbox"
              checked={form.enabled}
              onChange={(e) => setForm({ ...form, enabled: e.target.checked })}
            />
            {t('admin.courts.enabled')}
          </label>
          <div className="flex gap-2">
            <Button type="submit" className="h-11 flex-1">
              {t('admin.courts.save')}
            </Button>
            <Button
              type="button"
              variant="outline"
              className="h-11 flex-1"
              onClick={() => setShowForm(false)}
            >
              {t('admin.courts.cancel')}
            </Button>
          </div>
        </form>
      )}

      {loading ? (
        <div className="space-y-4">
          {[1, 2, 3].map((i) => (
            <div key={i} className="h-24 animate-pulse rounded-2xl bg-gray-100" />
          ))}
        </div>
      ) : (
        <div className="space-y-4">
          {courts.map((court) => (
            <article
              key={court.id}
              className="flex flex-col gap-3 rounded-2xl border border-court-border bg-white p-4 sm:flex-row sm:items-center"
            >
              <div className="flex-1">
                <div className="flex flex-wrap items-center gap-2">
                  <h2 className="font-display font-semibold">{court.name}</h2>
                  <SportBadge sport={court.sport_type} />
                  {!court.enabled && (
                    <span className="rounded-lg bg-gray-100 px-2 py-0.5 text-xs text-gray-600">
                      Tắt
                    </span>
                  )}
                </div>
                <p className="mt-1 text-sm text-court-muted">
                  {t('courts.capacity', { count: court.capacity })} · {formatPrice(court.hourly_price)}
                  {t('courts.perHour')}
                </p>
              </div>
              <div className="flex gap-2">
                <Button variant="outline" className="h-11" onClick={() => openEdit(court)}>
                  {t('admin.courts.edit')}
                </Button>
                <Button
                  variant="outline"
                  className="h-11 border-red-200 text-red-600"
                  onClick={() => handleDelete(court.id)}
                >
                  {t('admin.courts.delete')}
                </Button>
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
