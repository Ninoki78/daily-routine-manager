# 📱diyo : Daily Routine Manager App

## 📌 Overview

The **Daily Routine Manager App** is a Flutter-based mobile application designed to help users efficiently plan, manage, and track their daily activities. It emphasizes productivity, structured navigation, clean architecture, and real-world mobile development practices.

This project was developed as part of an academic requirement to demonstrate key concepts in **mobile application development using Flutter**, including state management, persistent storage, API integration, and device feature utilization.

---

## 🎯 Key Objectives

* Develop an intuitive and user-friendly mobile interface
* Implement structured multi-screen navigation
* Apply scalable state management using Provider
* Enable local data persistence for routines
* Integrate external APIs for dynamic content
* Utilize device features such as notifications and alarms

---

## ✨ Features

### 🧩 User Interface

* Clean and responsive UI design
* Reusable custom widgets
* Form validation for user input
* User feedback via Snackbars and Dialogs

---

### 🔄 Navigation System

* Flutter Navigator-based multi-screen flow
* Smooth transitions between:

  * Home Screen
  * Add Routine Screen
  * Edit Routine Screen
  * Routine Detail Screen
* Efficient data transfer between screens

---

### 🧠 State Management

* Local state handled using `setState`
* Global state managed using **Provider**
* Centralized and reactive data flow across the application

---

### 💾 Data Persistence

* Local database / file-based storage
* Full CRUD functionality:

  * Create routines
  * Read routines
  * Update routines
  * Delete routines

---

### 🌐 API Integration

* REST API integration for dynamic content
* JSON parsing and model mapping
* Robust error handling and loading states

---

### 📱 Device Integration

* Local notifications and alarms
* Permission handling for device services

---

## 🏗️ Project Structure

```bash
daily_routine_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── routine.dart
│   ├── providers/
│   │   ├── routine_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── add_routine_screen.dart
│   │   ├── edit_routine_screen.dart
│   │   ├── routine_detail_screen.dart
│   │   ├── settings_screen.dart
│   │   └── notification_history_screen.dart
│   ├── services/
│   │   ├── database_service.dart
│   │   ├── api_service.dart
│   │   └── notification_service.dart
│   ├── widgets/
│   │   ├── routine_card.dart
│   │   ├── custom_app_bar.dart
│   │   ├── loading_indicator.dart
│   │   ├── empty_state.dart
│   │   └── error_state.dart
│   └── utils/
│       ├── constants.dart
│       ├── helpers.dart
│       └── theme.dart
├── assets/
│   └── icon/
│       └── app_icon.png
├── android/
├── ios/
├── pubspec.yaml
└── app-release.apk
```

---

## ⚙️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
* **Local Storage:** SQLite / File System
* **Networking:** REST API (HTTP)

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio or VS Code
* Emulator or physical device

---

### Installation

```bash
git clone https://github.com/Ninoki78/daily-routine-manager.git
cd daily_routine_app
flutter pub get
flutter run
```

---

## 📦 Build APK

```bash
flutter build apk --release
```

**Output Location:**

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🧪 Testing Strategy

* Manual testing on emulator and real devices
* Input validation testing
* API response verification
* Edge case handling:

  * Empty states
  * Network failures
  * Invalid inputs

---

## 🎥 Demo & Presentation

* 🎬 **Presentation Video:** [Add Link Here]
* 📱 **APK Download:** [Add Link Here]

---

## 👥 Team Contributions

| Name              | ID      | Responsibility                  |
| ----------------- | ------- | ------------------------------- |
| Mesnanat Teshager |         | UI Screens and Design           |
| Tinsaye Gezahegn  | 1005/15 | Navigation & State Management   |
| Eldana Tesfahun   | 0357/15 | Database & Data Persistence     |
| Nebil Abdo        | 0812/15 | Notifications & Device Features |
|                   |         | API Integration & Utilities     |

---

## 🧭 Architecture: Navigation & State Flow

The application follows a structured and reactive flow:

1. User interacts with UI (e.g., adds a routine)
2. Action is handled by Provider
3. Provider updates application state
4. Data is persisted in local storage
5. UI automatically rebuilds using listeners

This ensures:

* Consistent state across screens
* Scalable architecture
* Clean separation of concerns

---

## ⚠️ Challenges & Solutions

| Challenge               | Solution                                    |
| ----------------------- | ------------------------------------------- |
| State synchronization   | Implemented Provider for centralized state  |
| Navigation data passing | Constructor-based argument passing          |
| API failures            | Added error handling and fallback UI states |

---

## 📌 Future Improvements

* Cloud synchronization
* User authentication system
* Advanced analytics dashboard
* Cross-platform enhancements

---

## 📎 Submission Checklist

* ✔ Source Code (GitHub Repository)
* ✔ APK File
* ✔ Documentation (README)
* ✔ Demo Video

---

## 📜 License

This project is developed for **educational purposes only**.
