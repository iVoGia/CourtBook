# API Spec — {PROJECT_NAME}

Base URL: `http://localhost:3001/api`  
Client proxy: `/api` → server (Vite)

## Endpoints

### GET /health

Response `200`:

```json
{ "status": "ok" }
```

### GET /items

List items.

Response `200`: `Array<{ id, name, description?, image_url?, created_at }>`

### POST /items

Create item.

Request body:

```json
{
  "name": "string (required)",
  "description": "string?",
  "image_url": "string?"
}
```

Response `201`: created object

### PATCH /items/:id (optional)

Update status or fields.

### DELETE /items/:id (optional)

Delete item.

## Errors

- `400` — validation error `{ "error": "message" }`
- `500` — server error
