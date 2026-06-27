import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '@/context/AuthContext';

export function AdminRoute() {
  const { user, loading } = useAuth();

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-court-bg">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-court-primary border-t-transparent" />
      </div>
    );
  }

  if (!user || user.role !== 'admin') {
    return <Navigate to="/courts" replace />;
  }

  return <Outlet />;
}
