# Campus Pulse 🎓⚡

**Production-Ready Full-Stack Campus Community Platform**

Campus Pulse connects students, campus events, academic quizzes, peer study matching, and real-time leaderboards into one unified, elegant, Apple-inspired application.

---

## 🌟 Key Capabilities & Features

1. **Authentication & Student Profiles**:
   - Secure student registration and authentication powered by Serverpod's built-in auth module with password hashing (Argon2id/bcrypt).
   - Rich student profile tracking Branch (`CSE`, `IT`, `ECE`, `Mechanical`, `Civil`), Academic Year (`Year 1` - `Year 4`), Hostel/Location, and Subject Interests (`DSA`, `DBMS`, `OS`, `AI`, `Networks`, `Web Development`).
2. **Campus Events & Real-Time RSVP**:
   - Categorized campus event feed (`All`, `Tech`, `Sports`, `Cultural`, `Workshop`, `Hackathon`).
   - Transactional RSVP engine with database-level duplicate prevention (unique compound index on `(eventId, studentId)`).
   - Real-time updates delivered through Serverpod's WebSocket message bus without manual page refreshes.
3. **Smart Study Buddy Finder**:
   - Deterministic matching algorithm scoring peer compatibility based on overlapping subject interests and campus location proximity.
   - Send, accept, and decline peer study invitations.
4. **Authoritative Academic Quizzes**:
   - Built-in subject quizzes across DBMS, OS, and DSA.
   - Cheat-proof architecture: question options are sent to the client with the correct answer masked. Grading is executed server-side.
   - Instant explanations, score breakdown, and time-to-complete analytics.
5. **Live Real-Time Leaderboards**:
   - Aggregated scores with deterministic tie-breaking (highest score, lowest cumulative time taken, oldest registration date).
   - WebSocket streaming for live rank adjustments.
6. **20 Apple-Grade UX Features**:
   - Dark/Light mode toggle with persistence
   - Cookie & privacy consent banner
   - Site-wide search across events, students, and quizzes
   - Back-to-top floating scroll trigger
   - Responsive mobile navigation drawer & desktop navigation bar
   - Skeleton shimmer loading states
   - Micro-interaction hover & focus rings
   - Reading/scroll progress indicator
   - One-tap clipboard copy button with feedback toast
   - Print stylesheet support for academic results
   - Sticky blur/frosted-glass app header
   - Accessible skip-to-content anchor
   - Password visibility toggles
   - Sanitized UTM tracking parameter capture
   - Accessible form validation & inline feedback
   - Safe confirmation modals for destructive operations
   - Relative & absolute date formatting
   - Interactive expandable FAQ accordion
   - Quick-access floating contact support button
   - Bounded cross-entity search bar

---

## 🏗️ Architecture & Technology Stack

| Layer | Technology | Details |
|---|---|---|
| **Frontend** | Flutter 3.47 / Dart 3.13 | Cross-platform UI (Web, Desktop, Mobile), Apple Design System tokens |
| **Backend** | Serverpod 4.0.4 / Dart | Strongly-typed RPC endpoints, ORM, WebSockets, background tasks |
| **Database** | PostgreSQL 16 | Relational tables, unique constraints, foreign keys, migrations |
| **Client SDK** | Generated Serverpod Client | Zero hand-written HTTP calls; fully type-safe generated contract |
| **Hosting** | Vercel & Serverpod Cloud | Vercel for static Flutter Web assets; Serverpod Cloud for persistent Dart server |

---

## 🚀 Quickstart & Development

### Prerequisites
- Dart SDK `^3.13.0` & Flutter SDK `^3.47.0`
- PostgreSQL 15+ (or Docker for local database)
- Serverpod CLI (`dart pub global activate serverpod_cli`)

### 1. Database & Server Setup
```bash
# Navigate to the server package
cd campus_pulse_server

# Apply database migrations
dart bin/main.dart --mode development --apply-migrations

# Start the Serverpod development server
dart bin/main.dart --mode development
```

### 2. Client & Flutter App
```bash
# Navigate to the flutter app package
cd campus_pulse_flutter

# Run in debug mode (Chrome, macOS, Windows, Linux, Android, iOS)
flutter run -d chrome
```

---

## 🧪 Testing & Verification

### Run Server Tests (Embedded PostgreSQL test harness)
```bash
cd campus_pulse_server
dart test
```
*Result: 10/10 integration tests passing.*

### Run Flutter Unit & Widget Tests
```bash
cd campus_pulse_flutter
flutter test
```
*Result: 14/14 widget & design token tests passing.*

### Run Production Web Build
```bash
cd campus_pulse_flutter
flutter build web --release
```
*Result: Clean compilation to `build/web` with icon tree-shaking.*

---

## 📄 License
MIT License. Built with precision for students and campus communities.

