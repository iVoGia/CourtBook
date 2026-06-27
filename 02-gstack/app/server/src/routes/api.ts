import { Router } from 'express';
import authRouter from './auth.js';
import courtsRouter from './courts.js';
import bookingsRouter from './bookings.js';
import adminBookingsRouter from './admin/bookings.js';
import adminCourtsRouter from './admin/courts.js';
import adminSettingsRouter from './admin/settings.js';
import { requireAuth } from '../middleware/auth.js';
import { requireAdmin } from '../middleware/admin.js';

const router = Router();

router.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

router.use('/auth', authRouter);
router.use('/courts', courtsRouter);
router.use('/bookings', bookingsRouter);

const adminRouter = Router();
adminRouter.use(requireAuth);
adminRouter.use(requireAdmin);
adminRouter.use('/bookings', adminBookingsRouter);
adminRouter.use('/courts', adminCourtsRouter);
adminRouter.use('/settings', adminSettingsRouter);
router.use('/admin', adminRouter);

export default router;
