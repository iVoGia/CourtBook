import { cn } from '@/lib/utils';
import { sportLabel } from '@/lib/api';

const colors: Record<string, string> = {
  badminton: 'bg-violet-100 text-violet-700',
  mini_football: 'bg-blue-100 text-blue-700',
  tennis: 'bg-emerald-100 text-emerald-700',
};

export function SportBadge({ sport }: { sport: string }) {
  return (
    <span
      className={cn(
        'inline-flex rounded-lg px-2 py-0.5 text-xs font-medium',
        colors[sport] || 'bg-gray-100 text-gray-700'
      )}
    >
      {sportLabel(sport)}
    </span>
  );
}
