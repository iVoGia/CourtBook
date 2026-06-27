import { useEffect, useState } from 'react';
import { api, type AdminSettings } from '@/lib/api';
import { Button } from '@/components/ui/button';
import { useT } from '@/i18n';

export function AdminSettingsPage() {
  const { t } = useT();
  const [start, setStart] = useState('06:00');
  const [end, setEnd] = useState('22:00');
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');
  const [error, setError] = useState('');

  useEffect(() => {
    api<AdminSettings>('/admin/settings')
      .then((s) => {
        setStart(s.operating_hours_start);
        setEnd(s.operating_hours_end);
      })
      .finally(() => setLoading(false));
  }, []);

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setMsg('');
    setSaving(true);
    try {
      await api('/admin/settings', {
        method: 'PATCH',
        body: JSON.stringify({
          operating_hours_start: start,
          operating_hours_end: end,
        }),
      });
      setMsg(t('admin.settings.saved'));
    } catch (err) {
      setError(err instanceof Error ? err.message : t('admin.settings.saveFailed'));
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return <div className="animate-pulse rounded-2xl bg-gray-100 p-8">…</div>;
  }

  return (
    <div className="max-w-md">
      <header className="mb-6">
        <h1 className="font-display text-2xl font-bold">{t('admin.settings.title')}</h1>
        <p className="mt-1 text-court-muted">{t('admin.settings.subtitle')}</p>
      </header>

      <form onSubmit={handleSave} className="space-y-4 rounded-2xl border border-court-border bg-white p-6">
        <div>
          <label className="mb-1 block text-sm font-medium">{t('admin.settings.openTime')}</label>
          <input
            type="time"
            value={start}
            onChange={(e) => setStart(e.target.value)}
            className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
            required
          />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium">{t('admin.settings.closeTime')}</label>
          <input
            type="time"
            value={end}
            onChange={(e) => setEnd(e.target.value)}
            className="h-11 w-full rounded-xl border border-court-border px-3 text-sm"
            required
          />
        </div>
        {msg && <p className="text-sm text-green-700">{msg}</p>}
        {error && <p className="text-sm text-red-600">{error}</p>}
        <Button type="submit" className="h-11 w-full" disabled={saving}>
          {saving ? t('common.saving') : t('admin.settings.save')}
        </Button>
      </form>
    </div>
  );
}
