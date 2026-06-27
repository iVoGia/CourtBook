import { useAuth } from '@/context/AuthContext';
import { AppLogo } from '@/components/AppLogo';
import { SportBadge } from '@/components/SportBadge';
import { Button } from '@/components/ui/button';
import { useNavigate } from 'react-router-dom';
import { roleLabel } from '@/lib/api';
import { useT } from '@/i18n';

export function ProfilePage() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const { t } = useT();

  const handleLogout = async () => {
    await logout();
    navigate('/login');
  };

  return (
    <div className="max-w-md">
      <header className="mb-6">
        <h1 className="font-display text-2xl font-bold">{t('profile.title')}</h1>
        <p className="mt-1 text-sm text-court-muted">{t('profile.subtitle')}</p>
      </header>

      <div className="rounded-2xl border border-court-border bg-[#eef2f0] p-6 text-center">
        <div className="mb-4 flex justify-center">
          <AppLogo size={72} />
        </div>
        <h2 className="font-display text-xl font-bold text-court-primary">{t('app.name')}</h2>
        <p className="mt-1 text-sm text-court-muted">{t('app.tagline')}</p>
        <p className="mt-4 text-sm leading-relaxed text-court-muted">{t('profile.introDescription')}</p>
        <div className="mt-4 flex flex-wrap justify-center gap-2">
          <SportBadge sport="badminton" />
          <SportBadge sport="mini_football" />
          <SportBadge sport="tennis" />
        </div>
      </div>

      <div className="mt-4 rounded-2xl border border-court-border bg-white p-6">
        <h2 className="font-display text-base font-semibold">{t('profile.accountInfo')}</h2>
        <p className="mt-4 text-sm text-court-muted">{t('profile.name')}</p>
        <p className="font-medium">{user?.name}</p>
        <p className="mt-4 text-sm text-court-muted">{t('profile.email')}</p>
        <p className="font-medium">{user?.email}</p>
        <p className="mt-4 text-sm text-court-muted">{t('profile.role')}</p>
        <p className="font-medium">{user?.role ? roleLabel(user.role) : ''}</p>
        <Button variant="outline" className="mt-6 h-11 w-full" onClick={handleLogout}>
          {t('profile.logout')}
        </Button>
      </div>
    </div>
  );
}
