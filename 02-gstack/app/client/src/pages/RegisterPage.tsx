import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';
import { Button } from '@/components/ui/button';
import { AppLogo } from '@/components/AppLogo';
import { useT } from '@/i18n';

export function RegisterPage() {
  const { register } = useAuth();
  const navigate = useNavigate();
  const { t } = useT();
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await register(email, password, name);
      navigate('/courts');
    } catch (err) {
      setError(err instanceof Error ? err.message : t('auth.registerFailed'));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-court-bg p-4">
      <div className="w-full max-w-md rounded-2xl border border-court-border bg-white p-6 shadow-sm md:p-8">
        <div className="mb-6 text-center">
          <div className="mb-4 flex justify-center">
            <AppLogo size={72} />
          </div>
          <h1 className="font-display text-2xl font-bold text-court-ink">{t('auth.createAccountTitle')}</h1>
          <p className="mt-1 text-sm text-court-muted">{t('auth.createAccountSubtitle')}</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="mb-1 block text-sm font-medium">{t('auth.fullName')}</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm outline-none focus:border-court-primary"
              required
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium">{t('auth.email')}</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm outline-none focus:border-court-primary"
              required
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium">{t('auth.password')}</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm outline-none focus:border-court-primary"
              minLength={6}
              required
            />
          </div>
          {error && <p className="text-sm text-red-600">{error}</p>}
          <Button type="submit" className="h-11 w-full" disabled={loading}>
            {loading ? t('auth.creating') : t('auth.createAccount')}
          </Button>
        </form>

        <p className="mt-6 text-center text-sm text-court-muted">
          {t('auth.hasAccount')}{' '}
          <Link to="/login" className="font-medium text-court-primary hover:underline">
            {t('auth.signIn')}
          </Link>
        </p>
      </div>
    </div>
  );
}
