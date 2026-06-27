import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';

const SAMPLE_ITEMS = [
  {
    id: 1,
    name: 'Sample Item',
    image: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
  },
];

export function ItemsPage() {
  return (
    <div className="space-y-4 pb-16 md:pb-0">
      <div className="flex items-center justify-between">
        <h2 className="text-2xl font-bold">Items</h2>
        <Button onClick={() => alert('Add item — implement theo đề')}>Thêm mới</Button>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {SAMPLE_ITEMS.map((item) => (
          <Card key={item.id} className="overflow-hidden">
            <img
              src={item.image}
              alt={item.name}
              className="h-40 w-full object-cover"
              onError={(e) => {
                e.currentTarget.src = '/images/placeholder.svg';
              }}
            />
            <CardContent className="p-4">
              <p className="font-medium">{item.name}</p>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
