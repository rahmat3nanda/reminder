# Reminder

**(Flutter – Local Reminder & Notification App)**

Reminder App is a **Flutter-based** mobile application designed to manage time-based reminders with
repeat rules, snooze functionality, and custom notification sounds.

This project focuses on **clean architecture**, **predictable state management**, and **robust local
notification scheduling**, showcasing production-ready patterns for a real-world
reminder/alarm-style application.

---

## Descriptions

Reminder App allows users to:

- Create reminders with a specific time
- Edit existing reminders
- Enable / disable reminders
- Set repeat rules:
    - Never
    - Weekdays
    - Weekends
    - Custom days
- Enable snooze with configurable duration
- Receive scheduled local notifications
- Snooze reminders directly from notification action buttons
- Persist reminders locally using Hive

The app is fully **offline-first**, relying entirely on local storage and native notification
scheduling.

---

## Features

- ⏰ Time-based reminders
- 🔁 Flexible repeat rules
- 💤 Snooze support (with notification action)
- 🔊 Custom notification sounds
- 📦 Local persistence using Hive
- 🧠 Predictable state management with BLoC / Cubit
- 🧱 Clean Architecture (Domain → Data → Presentation)
- 🌍 Timezone-aware scheduling
- 📱 Android & iOS support

---

## Getting Started

Follow the instructions below to run the project locally.

### Prerequisites

Make sure you have the following installed:

- **Flutter SDK** (min. 3.38.3)
- **FVM** (recommended)
- **Android Studio or VS Code**
- **Android Emulator or iOS Simulator**
- **Git**

---

### Configurations

1. **Clone the repository**

```bash
git clone https://github.com/rahmat3nanda/boo.git
cd boo
```

2. **Install the repository**

```bash
flutter pub get
```

or if you use FVM

```bash
fvm use .
fvm flutter pub get
```
