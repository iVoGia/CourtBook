import { t } from './index';

const ERROR_KEY_MAP: Record<string, string> = {
  AUTH_FIELDS_REQUIRED: 'errors.AUTH_REGISTER_FIELDS_REQUIRED',
  AUTH_REGISTER_FIELDS_REQUIRED: 'errors.AUTH_REGISTER_FIELDS_REQUIRED',
  AUTH_LOGIN_FIELDS_REQUIRED: 'errors.AUTH_LOGIN_FIELDS_REQUIRED',
  AUTH_EMAIL_EXISTS: 'errors.AUTH_EMAIL_EXISTS',
  AUTH_INVALID: 'errors.AUTH_INVALID',
  AUTH_REQUIRED: 'errors.AUTH_REQUIRED',
  AUTH_SESSION_INVALID: 'errors.AUTH_SESSION_INVALID',
  ADMIN_FORBIDDEN: 'errors.ADMIN_FORBIDDEN',
  COURT_NOT_FOUND: 'errors.COURT_NOT_FOUND',
  COURT_HAS_BOOKINGS: 'errors.COURT_HAS_BOOKINGS',
  DATE_REQUIRED: 'errors.DATE_REQUIRED',
  DURATION_INVALID: 'errors.DURATION_INVALID',
  FIELDS_REQUIRED: 'errors.FIELDS_REQUIRED',
  CAPACITY_EXCEEDED: 'errors.CAPACITY_EXCEEDED',
  ADVANCE_2H: 'errors.ADVANCE_2H',
  BOOKING_CONFLICT: 'errors.BOOKING_CONFLICT',
  BOOKING_NOT_FOUND: 'errors.BOOKING_NOT_FOUND',
  BOOKING_NOT_PENDING: 'errors.BOOKING_NOT_PENDING',
  BOOKING_ALREADY_CANCELLED: 'errors.BOOKING_ALREADY_CANCELLED',
  CANCEL_24H: 'errors.CANCEL_24H',
  CANCEL_STARTED: 'errors.CANCEL_STARTED',
};

export function resolveApiError(
  data: { error?: string; params?: Record<string, string | number> }
): string {
  const code = data.error;
  if (!code) return t('common.genericError');
  const key = ERROR_KEY_MAP[code];
  if (key) return t(key, data.params);
  return t('common.genericError');
}
