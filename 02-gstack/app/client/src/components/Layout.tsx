import { Calendar, ClipboardList, LayoutGrid, LogOut, Settings, User } from 'lucide-react';
import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import { cn } from '@/lib/utils';
import { useAuth } from '@/context/AuthContext';
import { AppLogo } from '@/components/AppLogo';
import { useT } from '@/i18n';

export function Layout() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const { t } = useT();
  const isAdmin = user?.role === 'admin';

  const userNav = [
    { to: '/courts', label: t('nav.courts'), icon: LayoutGrid },
    { to: '/bookings', label: t('nav.bookings'), icon: Calendar },
    { to: '/profile', label: t('nav.profile'), icon: User },
  ];

  const adminNav = [
    { to: '/admin/bookings', label: t('nav.adminBookings'), icon: ClipboardList },
    { to: '/admin/courts', label: t('nav.adminCourts'), icon: LayoutGrid },
    { to: '/admin/settings', label: t('nav.adminSettings'), icon: Settings },
    { to: '/profile', label: t('nav.profile'), icon: User },
  ];

  const nav = isAdmin ? adminNav : userNav;

  const handleLogout = async () => {
    await logout();
    navigate('/login');
  };

  return (
    <div className="flex min-h-screen bg-court-bg font-body text-court-ink">
      <aside className="hidden w-60 flex-col border-r border-court-border bg-white p-5 lg:flex">
        <div className="mb-8">
          <div className="mb-3 flex items-center gap-3">
            <AppLogo size={40} />
            <div>
              <h1 className="font-display text-xl font-bold text-court-primary">{t('app.name')}</h1>
              <p className="text-xs text-court-muted">{t('app.tagline')}</p>
            </div>
          </div>
        </div>
        <nav className="flex flex-1 flex-col gap-1">
          {nav.map(({ to, label, icon: Icon }) => (
            <NavLink
              key={to}
              to={to}
              className={({ isActive }) =>
                cn(
                  'flex min-h-11 items-center gap-3 rounded-xl px-3 text-sm font-medium transition-colors',
                  isActive
                    ? 'bg-teal-50 text-court-primary'
                    : 'text-court-muted hover:bg-gray-50'
                )
              }
            >
              <Icon size={20} />
              {label}
            </NavLink>
          ))}
        </nav>
        <div className="mt-auto border-t border-court-border pt-4">
          <p className="truncate text-sm font-medium">{user?.name}</p>
          <p className="truncate text-xs text-court-muted">{user?.email}</p>
          <button
            type="button"
            onClick={handleLogout}
            className="mt-3 flex min-h-11 w-full items-center gap-2 rounded-xl px-3 text-sm text-court-muted hover:bg-gray-50"
          >
            <LogOut size={18} />
            {t('nav.logout')}
          </button>
        </div>
      </aside>

      <main className="flex-1 overflow-x-hidden pb-20 lg:pb-6 lg:pl-0">
        <div className="mx-auto max-w-5xl p-4 md:p-6">
          <Outlet />
        </div>
      </main>

      <nav className="fixed bottom-0 left-0 right-0 z-50 flex border-t border-court-border bg-white pb-[env(safe-area-inset-bottom)] lg:hidden">
        {nav.map(({ to, label, icon: Icon }) => (
          <NavLink
            key={to}
            to={to}
            className={({ isActive }) =>
              cn(
                'flex min-h-14 flex-1 flex-col items-center justify-center gap-0.5 px-1 text-[10px] font-medium sm:text-xs',
                isActive ? 'text-court-primary' : 'text-court-muted'
              )
            }
          >
            <Icon size={20} />
            <span className="truncate">{label}</span>
          </NavLink>
        ))}
      </nav>
    </div>
  );
}
