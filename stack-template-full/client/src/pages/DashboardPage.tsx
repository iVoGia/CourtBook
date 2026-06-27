import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';

export function DashboardPage() {
  return (
    <div className="space-y-4 pb-16 md:pb-0">
      <div>
        <h2 className="text-2xl font-bold">Dashboard</h2>
        <p className="text-stone-400">Contest stack template — thay nội dung theo đề</p>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {['MVP', 'UI Kit', 'Ready'].map((label) => (
          <Card key={label}>
            <CardHeader>
              <CardTitle>{label}</CardTitle>
            </CardHeader>
            <CardContent>
              <Badge variant="success">Active</Badge>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
