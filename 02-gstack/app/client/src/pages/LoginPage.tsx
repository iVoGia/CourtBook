import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';
import { Button } from '@/components/ui/button';
import { AppLogo } from '@/components/AppLogo';
import { useT } from '@/i18n';

export function LoginPage() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const { t } = useT();
  const [email, setEmail] = useState('user@demo.com');
  const [password, setPassword] = useState('demo123');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const loggedIn = await login(email, password);
      navigate(loggedIn.role === 'admin' ? '/admin/bookings' : '/courts');
    } catch (err) {
      setError(err instanceof Error ? err.message : t('auth.loginFailed'));
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
          <h1 className="font-display text-2xl font-bold text-court-primary">{t('app.name')}</h1>
          <p className="mt-1 text-sm text-court-muted">{t('app.tagline')}</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="mb-1 block text-sm font-medium">{t('auth.email')}</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm outline-none focus:border-court-primary focus:ring-2 focus:ring-teal-100"
              required
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium">{t('auth.password')}</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="h-11 w-full rounded-xl border border-court-border px-3 text-sm outline-none focus:border-court-primary focus:ring-2 focus:ring-teal-100"
              required
            />
          </div>
          {error && <p className="text-sm text-red-600">{error}</p>}
          <Button type="submit" className="h-11 w-full" disabled={loading}>
            {loading ? t('auth.signingIn') : t('auth.signIn')}
          </Button>
        </form>

        <details className="mt-4 rounded-xl bg-gray-50 p-3 text-xs text-court-muted">
          <summary className="cursor-pointer font-medium">{t('auth.demoAccounts')}</summary>
          <p className="mt-2">{t('auth.demoUser')}</p>
          <p>{t('auth.demoAdmin')}</p>
        </details>

        <p className="mt-6 text-center text-sm text-court-muted">
          {t('auth.noAccount')}{' '}
          <Link to="/register" className="font-medium text-court-primary hover:underline">
            {t('auth.signUp')}
          </Link>
        </p>
      </div>
    </div>
  );
}
