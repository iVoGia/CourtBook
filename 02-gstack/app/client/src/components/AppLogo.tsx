import { cn } from '@/lib/utils';

type AppLogoProps = {
  size?: number;
  className?: string;
};

export function AppLogo({ size = 56, className }: AppLogoProps) {
  return (
    <img
      src="/images/app-logo.png"
      alt="CourtBook"
      width={size}
      height={size}
      className={cn('rounded-2xl object-cover shadow-sm', className)}
    />
  );
}
