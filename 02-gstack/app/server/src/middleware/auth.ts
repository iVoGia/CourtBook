import type { Request, Response, NextFunction } from 'express';
import { getDb } from '../db/index.js';

export interface AuthUser {
  id: number;
  email: string;
  name: string;
  role: string;
}

declare global {
  namespace Express {
    interface Request {
      user?: AuthUser;
    }
  }
}

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    res.status(401).json({ error: 'AUTH_REQUIRED' });
    return;
  }
  const token = header.slice(7);
  const row = getDb()
    .prepare(
      `SELECT u.id, u.email, u.name, u.role FROM sessions s
       JOIN users u ON u.id = s.user_id WHERE s.token = ?`
    )
    .get(token) as AuthUser | undefined;

  if (!row) {
    res.status(401).json({ error: 'AUTH_SESSION_INVALID' });
    return;
  }
  req.user = row;
  next();
}
