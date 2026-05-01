# diyo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,samples, guidance on mobile development, and a full API reference.
=======
# 📱 Daily Routine Manager App

## 📌 Overview

The Daily Routine Manager App is a Flutter-based mobile application designed to help users plan, manage, and track their daily activities efficiently. The application emphasizes usability, clean architecture, and real-world functionality by integrating persistent storage, API communication, and device-level features.

This project was developed as part of an academic requirement to demonstrate core mobile application development concepts using Flutter.

---

## 🎯 Key Objectives

* Design a user-friendly mobile interface
* Implement structured navigation across multiple screens
* Apply scalable state management techniques
* Persist user data locally
* Integrate external APIs and handle asynchronous data
* Utilize device features such as notifications

---

## ✨ Features

### 🧩 User Interface

* Clean and responsive UI design
* Custom reusable widgets
* Form handling with validation
* Feedback mechanisms:

  * Snackbars
  * Dialogs

---

### 🔄 Navigation

* Multi-screen navigation using Flutter Navigator
* Seamless transitions between:

  * Home Screen
  * Add Routine Screen
  * Edit Routine Screen
  * Detail Screen
* Data passed between screens efficiently

---

### 🧠 State Management

* Local state managed using setState()
* Global state managed using Provider
* Centralized data flow for routines and UI updates

---

### 💾 Data Persistence

* Local database/file storage implementation
* CRUD operations:

  * Create routines
  * Read routines
  * Update routines
  * Delete routines

---

### 🌐 API Integration

* REST API consumption
* JSON parsing and data modeling
* Error handling and loading states

---

### 📱 Device Features

* Notification and/or alarm integration
* Permission handling for device access

---

## 🏗 Project Structure

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
│   │
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
├── README.md
└── app-release.apk


---

## ⚙️ Tech Stack

* Framework: Flutter
* Language: Dart
* State Management: Provider
* Storage: Local database / file system
* API Handling: HTTP / REST

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio or VS Code
* Emulator or physical device

---

### Installation

git clone https://github.com/Ninoki78/daily-routine-manager.git
cd daily_routine_app
flutter pub get
flutter run

---

## 📦 Build APK

flutter build apk --release

Output Location:

build/app/outputs/flutter-apk/app-release.apk

---

## 🧪 Testing Strategy

* Manual testing on emulator and real device
* Validation of user inputs
* API response verification
* Edge case handling:
* Empty data states
  * Network failures
  * Invalid inputs

---

## 🎥 Demo & Presentation

👉 Presentation Video Link:
[https://www.loom.com/share/efed7e60ccf34bf88c66bedefdd5121e]
👉 APP demonestration Video Link:
[https://www.loom.com/share/a984c5ebff1640ed8a63ca9cb2ccdd2d]

## 📦 APK Download

👉 **Download the latest APK:** [app-release.apk](app-release.apk)

### Installation Instructions:
1. Download the `app-release.apk` file from the link above
2. On your Android device, go to **Settings > Security**
3. Enable **"Install from Unknown Sources"**
4. Open the downloaded APK file
5. Tap **Install**
6. Open the app and start managing your daily routines!

> ⚠️ **Note:** The APK is built for Android devices running Android 5.0 (API 21) or higher.



## 👥 Team Contributions

| Member              | ID       | Responsibility                  |
| ------------------- | -------- |-------------------------------- |
| Mesnanat Teshager   | 0736/15  | UI Screens and Design           |
| Tinsaye Gezahegn    | 1005/15  | Navigation & State Management   |
| Eldana Tesfahun     | 0357/15  | Database & Data Persistence     |
| Nebil Abdo          | 0812/15  | Notifications & Device Features |
| Kebrom Kelelegn     | 1127/15  | API Integration and Utilities    |
---

## 🧭 Navigation & State Flow (Highlight Section)

The application follows a structured flow:

1. User interacts with UI (e.g., adds a routine)
2. Action triggers Provider
3. Provider updates application state
4. Data is stored persistently
5. UI rebuilds automatically via listeners

This ensures:

* Consistent data across screens
* Scalable architecture
* Clean separation of concerns

---

## ⚠️ Challenges & Solutions

| Challenge               | Solution                                   |
| ----------------------- | ------------------------------------------ |
| State synchronization   | Implemented Provider for centralized state |
| Navigation data passing | Used constructor-based argument passing    |
| API errors              | Added proper error handling & UI feedback  |

---

## 📌 Future Improvements

* Cloud synchronization
* User authentication
* Advanced analytics (routine tracking insights)
* Cross-platform enhancements

---

## 📎 Submission Checklist

* ✔️ Source Code (GitHub Repository)
* ✔️ APK File
* ✔️ Documentation (README)
* ✔️ Demo Video

---

## 📜 License

This project is for educational purposes only.

docs.flutter.dev (https://docs.flutter.dev/get-started/learn-flutter)
Learn Flutter
Find everything you need to start building Flutter apps.
