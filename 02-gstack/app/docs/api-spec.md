# API Spec — CourtBook

Base URL: `http://localhost:3001/api`  
Client proxy: `/api` → server (Vite)

## Endpoints

### GET /health

Response `200`: `{ "status": "ok" }`

### POST /auth/register

Request: `{ "email", "password", "name" }`  
Response `201`: `{ "token", "user": { id, email, name, role } }`

### POST /auth/login

Request: `{ "email", "password" }`  
Response `200`: `{ "token", "user": { id, email, name, role } }`

### GET /auth/me

Headers: `Authorization: Bearer <token>`  
Response `200`: `{ "user" }`

### POST /auth/logout

Headers: `Authorization: Bearer <token>`  
Response `200`: `{ "ok": true }`

### GET /courts

Query: `?sport=badminton|mini_football|tennis` (optional)  
Response `200`: `Array<Court>` (enabled only)

### GET /courts/:id

Response `200`: `Court`

### GET /courts/:id/slots

Query: `?date=YYYY-MM-DD&duration=1|2|3`  
Response `200`: `{ date, duration, operating_hours, slots: [{ start_time, end_time, available }] }`

### GET /bookings

Headers: `Authorization: Bearer <token>`  
Query: `?filter=upcoming|past|all`  
Response `200`: `Array<Booking>` (own bookings; status includes `pending`)

### POST /bookings

Headers: `Authorization: Bearer <token>`  
Request: `{ court_id, booking_date, start_time, duration, customer_name, phone, player_count }`  
Response `201`: `Booking` with `status: "pending"`

### DELETE /bookings/:id

Headers: `Authorization: Bearer <token>`  
Response `200`: `{ "ok": true }` or `400` with error code

## Admin (requires role `admin`)

### GET /admin/bookings

Query: `?filter=upcoming|past|all`  
Response `200`: `Array<Booking + user_name, user_email>`

### PATCH /admin/bookings/:id

Request: `{ "action": "confirm" | "reject" }`  
Response `200`: updated booking (`pending` → `confirmed` or `cancelled`)

### GET /admin/courts

Response `200`: `Array<Court>` (all, including disabled)

### POST /admin/courts

Request: `{ name, sport_type, capacity, hourly_price, image_url?, enabled? }`  
Response `201`: `Court`

### PATCH /admin/courts/:id

Request: partial court fields  
Response `200`: `Court`

### DELETE /admin/courts/:id

Response `200`: `{ "ok": true }` or `409 COURT_HAS_BOOKINGS`

### GET /admin/settings

Response `200`: `{ operating_hours_start, operating_hours_end }`

### PATCH /admin/settings

Request: `{ operating_hours_start, operating_hours_end }`  
Response `200`: settings object

## Booking status values

`pending` | `confirmed` | `cancelled` | `completed`

## Errors

Error body: `{ "error": "<CODE>", "params"?: {} }`

Codes: `AUTH_*`, `ADMIN_FORBIDDEN`, `COURT_NOT_FOUND`, `COURT_HAS_BOOKINGS`, `BOOKING_*`, `CANCEL_*`, `FIELDS_REQUIRED`, `DURATION_INVALID`, `CAPACITY_EXCEEDED`, `ADVANCE_2H`
