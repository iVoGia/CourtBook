import { cn } from '@/lib/utils';
import type { HTMLAttributes } from 'react';

interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: 'default' | 'success' | 'warning';
}

export function Badge({ className, variant = 'default', ...props }: BadgeProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium',
        variant === 'default' && 'bg-stone-800 text-stone-300',
        variant === 'success' && 'bg-emerald-900/50 text-emerald-300',
        variant === 'warning' && 'bg-amber-900/50 text-amber-300',
        className
      )}
      {...props}
    />
  );
}
