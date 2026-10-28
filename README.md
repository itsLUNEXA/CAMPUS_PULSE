# Campus Pulse 🎓⚡

**Campus Pulse** is a modern full-stack campus community application built with **Serverpod** (Dart backend with real-time WebSockets & Postgres) and **Flutter** (cross-platform mobile/web UI).

---

## 🏗️ Project Architecture

```
campus_pulse/
├── campus_pulse_server/   # Serverpod backend (PostgreSQL, Endpoints, Streaming, Seeds)
├── campus_pulse_client/   # Auto-generated & typed client SDK
└── campus_pulse_flutter/  # Clean, modular Flutter application (4 core tabs + Auth)
```

---

## 🌟 Core Features

1. **Authentication**:
   - Clean Student Login & Registration
   - Branch, graduation year, interests tags, and hostel area profile tracking.

2. **Home Feed & Live Events**:
   - Filter events by Category (`All`, `Tech`, `Sports`, `Cultural`, `Workshop`, `Hackathon`).
   - Create new campus events with live posting.
   - Interactive Event Detail View.
   - **Real-time Live RSVP counter**: Tap RSVP, instant database record + WebSocket broadcast updating all active screens live.

3. **Study Buddy Finder**:
   - Filter peers by Subject (`DBMS`, `OS`, `DSA`, `AI`, `Networks`, `Mathematics`) and Hostel / Campus Location.
   - Intelligent matching based on subject affinity, location proximity, and active study requests.
   - Post study requests directly.

4. **Interactive Quiz**:
   - Subject-wise 5-question quick assessments (DBMS, OS, DSA).
   - Instant score calculation and automatic score submission to server.
   - Automatic redirection to Leaderboard upon completion.

5. **Live Real-time Leaderboard**:
   - Top scores ranked branch and year-wise.
   - WebSocket streaming channel updates list in real time whenever any peer completes a quiz.

---

## 🚀 Running the Project

### 1. Prerequisites
- [Dart SDK](https://dart.dev/get-dart) & [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Serverpod CLI](https://serverpod.dev/docs/getting-started/cli): `dart pub global activate serverpod_cli`
- [Docker Desktop](https://www.docker.com/) (for Serverpod local Postgres container)

### 2. Start Backend (Serverpod)
```bash
cd campus_pulse/campus_pulse_server
serverpod start
```
*Note: Embedded Postgres starts automatically. Seed data (5 students, 10 campus events, 15 quiz questions) seeds automatically on first run.*

### 3. Run Flutter Application
```bash
cd campus_pulse/campus_pulse_flutter
flutter pub get
flutter run
```

---

## ☁️ Deployment
Deploy instantly using Serverpod Cloud:
```bash
cd campus_pulse/campus_pulse_server
serverpod cloud launch
```
