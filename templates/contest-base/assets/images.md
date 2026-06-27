# Image Sources — Dùng khi build UI

## Quy tắc

1. Mỗi card/item trong list phải có ảnh hoặc placeholder local
2. URL Unsplash: thêm `?w=400&h=300&fit=crop` để tối ưu
3. `onError` handler → `public/images/placeholder.svg`
4. Không dùng `via.placeholder.com`

## Unsplash theo category

### Đồ uống / Cafe / Food

```
https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1461023058943-f07a0808c159?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1511920170033-f8396924c348?w=400&h=300&fit=crop
```

### Sản phẩm / E-commerce

```
https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1505744386214-51dba16a26fc?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1572635196233-4b463fbba8c5?w=400&h=300&fit=crop
```

### People / Team / Avatar

```
https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop
```

### Office / Dashboard / Workspace

```
https://images.unsplash.com/photo-1497366216548-37526070297c?w=400&h=300&fit=crop
https://images.unsplash.com/photo-1497215728101-856f4ea42174?w=400&h=300&fit=crop
```

### Illustration (SVG, offline-safe)

- [undraw.co](https://undraw.co/illustrations) — tải SVG về `public/images/`
- Local placeholder: `assets/placeholders/placeholder.svg`

## Fallback local

Copy `assets/placeholders/placeholder.svg` → `public/images/placeholder.svg` khi scaffold.

## React pattern

```tsx
<img
  src={item.imageUrl}
  alt={item.name}
  className="h-40 w-full rounded-xl object-cover"
  onError={(e) => {
    e.currentTarget.src = '/images/placeholder.svg';
  }}
/>
```
