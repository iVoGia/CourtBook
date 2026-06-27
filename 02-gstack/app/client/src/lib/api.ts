import { resolveApiError } from '@/i18n/apiErrors';
import { t } from '@/i18n';

const API = '/api';

function getToken() {
  return localStorage.getItem('token');
}

export async function api<T>(
  path: string,
  options: RequestInit = {}
): Promise<T> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...(options.headers as Record<string, string>),
  };
  const token = getToken();
  if (token) headers.Authorization = `Bearer ${token}`;

  const res = await fetch(`${API}${path}`, { ...options, headers });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(resolveApiError(data));
  return data as T;
}

export interface User {
  id: number;
  email: string;
  name: string;
  role: string;
}

export interface Court {
  id: number;
  name: string;
  sport_type: string;
  capacity: number;
  hourly_price: number;
  image_url: string;
}

export interface AdminCourt extends Court {
  enabled: number;
}

export interface AdminSettings {
  operating_hours_start: string;
  operating_hours_end: string;
}

export interface Slot {
  start_time: string;
  end_time: string;
  available: boolean;
}

export interface Booking {
  id: number;
  court_name: string;
  sport_type: string;
  booking_date: string;
  start_time: string;
  end_time: string;
  status: string;
  total_price: number;
  customer_name: string;
  phone: string;
  player_count: number;
  image_url?: string;
  is_upcoming?: boolean;
  is_past?: boolean;
}

export interface AdminBooking extends Booking {
  user_name: string;
  user_email: string;
}

export function formatPrice(v: number) {
  return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(v);
}

export function formatDate(dateStr: string) {
  const [y, mo, d] = dateStr.split('-').map(Number);
  const date = new Date(y, mo - 1, d);
  return date.toLocaleDateString('vi-VN', {
    weekday: 'short',
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  });
}

export function sportLabel(s: string) {
  return t(`sports.${s}`) !== `sports.${s}` ? t(`sports.${s}`) : s;
}

export function statusLabel(status: string) {
  return t(`status.${status}`) !== `status.${status}` ? t(`status.${status}`) : status;
}

export function roleLabel(role: string) {
  return t(`roles.${role}`) !== `roles.${role}` ? t(`roles.${role}`) : role;
}

export function statusBadgeClass(status: string) {
  if (status === 'pending') return 'bg-amber-100 text-amber-800';
  if (status === 'confirmed') return 'bg-green-100 text-green-700';
  if (status === 'cancelled') return 'bg-red-100 text-red-700';
  return 'bg-gray-100 text-gray-600';
}
