# Campus Pulse — Production Deployment Guide

## 1. Hosting Architecture
- **Frontend**: Flutter Web hosted on **Vercel**.
- **Backend**: Serverpod server hosted on **Serverpod Cloud** or containerized infrastructure.
- **Database**: Managed **PostgreSQL 15+** instance.

---

## 2. Serverpod Backend Deployment (Serverpod Cloud / Docker)

### 2.1 Database Provisioning
Ensure a PostgreSQL database is reachable by the Serverpod server.
Run the database migrations:
```bash
cd campus_pulse_server
serverpod apply-migrations --mode production
```

### 2.2 Environment Configuration
Configure `config/production.yaml` or set environment variables:
```env
SERVERPOD_DATABASE_HOST=db.your-provider.com
SERVERPOD_DATABASE_PORT=5432
SERVERPOD_DATABASE_NAME=campus_pulse_prod
SERVERPOD_DATABASE_USER=postgres
SERVERPOD_DATABASE_PASSWORD=your_secure_password
SERVERPOD_SERVICE_SECRET=your_32_character_serverpod_secret
```

### 2.3 Starting the Server
```bash
dart bin/main.dart --mode production
```

---

## 3. Flutter Web Deployment on Vercel

### 3.1 Build Output
The production build of the Flutter web app produces static assets in:
```
campus_pulse_flutter/build/web
```

### 3.2 Compilation Command
```bash
cd campus_pulse_flutter
flutter build web --release --dart-define=SERVER_URL=https://api.yourdomain.com/
```

### 3.3 Vercel Deployment Settings
- **Root Directory**: `campus_pulse_flutter` (or set Root Directory in Vercel project settings)
- **Build Command**: `flutter build web --release --dart-define=SERVER_URL=$SERVER_URL`
- **Output Directory**: `build/web`
- **Routing & Caching**: Pre-configured via `deployment/vercel.json` (includes SPA rewrite to `index.html` and aggressive caching for immutable static assets).

---

## 4. Verification & Post-Launch Checklist
1. Verify `/livez` and `/readyz` health endpoints on the Serverpod server.
2. Confirm HTTPS certificate provisioning for both frontend domain and API domain.
3. Verify WebSocket upgrades succeed on `/websocket` for live RSVP and Leaderboard real-time updates.
4. Verify cookie banner consent tracking and dark mode persistence across browser reloads.

