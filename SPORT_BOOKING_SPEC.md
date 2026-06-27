# Sports Court Booking System Specification

## Overview

Build a **Responsive (Mobile-First) Sports Court Booking Web Application**.

Supported sports:

* Badminton
* Mini Football
* Tennis

---

# Required Features

## 1. Authentication

### Roles

* User
* Admin

### Functions

* Register
* Login
* Role-based Authorization

---

## 2. Court Management

Display a list of sports courts.

Each court contains:

* Court Name
* Sport Type

  * Badminton
  * Mini Football
  * Tennis
* Capacity
* Hourly Price

---

## 3. Court Booking

### Booking Flow

```text
Select Court
      ↓
Select Date
      ↓
Select Time Slot
      ↓
Enter:
- Customer Name
- Phone Number
- Number of Players
      ↓
Calculate Total Price
      ↓
Confirm Booking
```

---

## 4. My Bookings

Display:

* Upcoming Bookings
* Past Bookings

Booking information:

* Court
* Date
* Time
* Status
* Total Price

---

## 5. Cancel Booking

Allow cancellation only if the booking has not started.

If less than **24 hours** remain before the booking time:

* Display a warning message before cancellation.

---

## 6. Court Calendar

Provide a calendar view.

Support:

* Weekly Calendar
* Available Slots
* Booked Slots

---

## 7. Recurring Booking

Support recurring bookings.

Example:

```text
Every Thursday
19:00
```

Store recurrence patterns and automatically generate booking slots.

Allow:

* Cancel entire series
* Cancel a single occurrence

---

## 8. Admin Panel

Admin can:

### Court Management

* Add Court
* Edit Court
* Delete Court

### Configuration

* Configure Operating Hours
* Configure Hourly Price
* Enable / Disable Court

---

# Business Rules

## Booking Conflict

Two bookings cannot overlap on the same court.

---

## Advance Booking

Bookings must be made at least **2 hours** before the starting time.

Example:

Current Time:

```
14:00
```

Earliest booking:

```
16:00
```

---

## Operating Hours

Bookings are only allowed within configured operating hours.

Default:

```
06:00 - 22:00
```

Admin can modify these values.

---

## Booking Duration

Minimum:

```
1 hour
```

Maximum:

```
3 hours
```

---

## Capacity

Number of players cannot exceed the court capacity.

---

## Cancellation Policy

Bookings cannot be cancelled within **24 hours** before the start time.

---

## Pricing

Total Price =

```
Hourly Rate × Booking Duration
```

No real payment gateway is required.

Simply display the calculated amount.

---

## Demo Data

Seed at least **3 demo courts** with different sports.

Example:

* Badminton Court A
* Mini Football Field A
* Tennis Court A

---

# Technical Requirements

* Responsive Web Application
* Mobile First Design
* Generate Specification using Spec-Kit before implementation
* API Backend
* Database
* Weekly Calendar View
* User / Admin Authorization
* Recurring Booking Logic
* Store recurrence pattern and generate booking slots automatically

---

# Bonus Features

## 1. QR Code Check-in

Generate a QR Code for each booking.

Users check in by scanning the QR Code upon arrival.

---

## 2. Find Teammates

Users can create posts such as:

> Need more players

Attach the post to a booking.

Other users can join.

---

## 3. Dashboard Statistics

Display:

* Most booked court
* Total bookings
* Revenue (optional)
* Occupancy rate (optional)

---

## 4. Mock Online Payment

Provide a payment selection screen.

Examples:

* Credit Card
* Banking
* Momo
* ZaloPay

No real payment gateway integration is required.

---

# Suggested Tech Stack

## Frontend

* Next.js
* React
* TypeScript
* TailwindCSS
* shadcn/ui

## Backend

* Node.js
* ExpressJS or NestJS

## Database

* PostgreSQL
* Prisma ORM

---

# UI Requirements

* Clean UI
* Modern Design
* Responsive
* Mobile First
* Dashboard Layout
* Calendar View
* Light / Dark Mode
* Beautiful Empty States
* Loading Skeletons
* Form Validation
* Toast Notifications
* Accessible Components

---

# Deliverables

* Full Source Code
* API
* Database Schema
* Seed Data
* Authentication
* Admin Dashboard
* Booking System
* Calendar View
* Recurring Booking
* Bonus Features (if time permits)
* README with setup instructions
