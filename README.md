<<<<<<< HEAD
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

The **Daily Routine Manager App** is a Flutter-based mobile application designed to help users plan, manage, and track their daily activities efficiently. The application emphasizes usability, clean architecture, and real-world functionality by integrating persistent storage, API communication, and device-level features.

This project was developed as part of an academic requirement to demonstrate core mobile application development concepts using Flutter.
=======
# 📱diyo : Daily Routine Manager App

## 📌 Overview

The **Daily Routine Manager App** is a Flutter-based mobile application designed to help users efficiently plan, manage, and track their daily activities. It emphasizes productivity, structured navigation, clean architecture, and real-world mobile development practices.

This project was developed as part of an academic requirement to demonstrate key concepts in **mobile application development using Flutter**, including state management, persistent storage, API integration, and device feature utilization.
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

## 🎯 Key Objectives

<<<<<<< HEAD
* Design a user-friendly mobile interface
* Implement structured navigation across multiple screens
* Apply scalable state management techniques
* Persist user data locally
* Integrate external APIs and handle asynchronous data
* Utilize device features such as notifications
=======
* Develop an intuitive and user-friendly mobile interface
* Implement structured multi-screen navigation
* Apply scalable state management using Provider
* Enable local data persistence for routines
* Integrate external APIs for dynamic content
* Utilize device features such as notifications and alarms
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

## ✨ Features

### 🧩 User Interface

* Clean and responsive UI design
<<<<<<< HEAD
* Custom reusable widgets
* Form handling with validation
* Feedback mechanisms:

  * Snackbars
  * Dialogs

---

### 🔄 Navigation

* Multi-screen navigation using Flutter Navigator
* Seamless transitions between:
=======
* Reusable custom widgets
* Form validation for user input
* User feedback via Snackbars and Dialogs

---

### 🔄 Navigation System

* Flutter Navigator-based multi-screen flow
* Smooth transitions between:
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

  * Home Screen
  * Add Routine Screen
  * Edit Routine Screen
<<<<<<< HEAD
  * Detail Screen
* Data passed between screens efficiently
=======
  * Routine Detail Screen
* Efficient data transfer between screens
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

### 🧠 State Management

<<<<<<< HEAD
* Local state managed using `setState()`
* Global state managed using **Provider**
* Centralized data flow for routines and UI updates
=======
* Local state handled using `setState`
* Global state managed using **Provider**
* Centralized and reactive data flow across the application
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

### 💾 Data Persistence

<<<<<<< HEAD
* Local database/file storage implementation
* CRUD operations:
=======
* Local database / file-based storage
* Full CRUD functionality:
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

  * Create routines
  * Read routines
  * Update routines
  * Delete routines

---

### 🌐 API Integration

<<<<<<< HEAD
* REST API consumption
* JSON parsing and data modeling
* Error handling and loading states

---

### 📱 Device Features

* Notification and/or alarm integration
* Permission handling for device access
=======
* REST API integration for dynamic content
* JSON parsing and model mapping
* Robust error handling and loading states

---

### 📱 Device Integration

* Local notifications and alarms
* Permission handling for device services
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

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
<<<<<<< HEAD
│   │
=======
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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
<<<<<<< HEAD
├── README.md
└── app-release.apk

=======
└── app-release.apk
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
```

---

## ⚙️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
<<<<<<< HEAD
* **Storage:** Local database / file system
* **API Handling:** HTTP / REST
=======
* **Local Storage:** SQLite / File System
* **Networking:** REST API (HTTP)
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

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

<<<<<<< HEAD
* Manual testing on emulator and real device
* Validation of user inputs
* API response verification
* Edge case handling:

  * Empty data states
=======
* Manual testing on emulator and real devices
* Input validation testing
* API response verification
* Edge case handling:

  * Empty states
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  * Network failures
  * Invalid inputs

---

## 🎥 Demo & Presentation

<<<<<<< HEAD
👉 **Presentation Video Link:**
[]

👉 **APK Download:**
[]

=======
* 🎬 **Presentation Video:** [Add Link Here]
* 📱 **APK Download:** [Add Link Here]
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

## 👥 Team Contributions

<<<<<<< HEAD
## 👥 Team Contributions

| Member              | ID       | Responsibility                  |
| ------------------- | -------- |-------------------------------- |
| Mesnanat Teshager   |          | UI Screens and Design          |
| Tinsaye Gezahegn    | 1005/15  | Navigation & State Management  |
| Eldana Tesfahun     | 0357/15  | Database & Data Persistence    |
| Nebil Abdo          | 0812/15  | Notifications & Device Features |
|                     |          | API Integration and Utilities  |
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
=======
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
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
* Scalable architecture
* Clean separation of concerns

---

## ⚠️ Challenges & Solutions

<<<<<<< HEAD
| Challenge               | Solution                                   |
| ----------------------- | ------------------------------------------ |
| State synchronization   | Implemented Provider for centralized state |
| Navigation data passing | Used constructor-based argument passing    |
| API errors              | Added proper error handling & UI feedback  |
=======
| Challenge               | Solution                                    |
| ----------------------- | ------------------------------------------- |
| State synchronization   | Implemented Provider for centralized state  |
| Navigation data passing | Constructor-based argument passing          |
| API failures            | Added error handling and fallback UI states |
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41

---

## 📌 Future Improvements

* Cloud synchronization
<<<<<<< HEAD
* User authentication
* Advanced analytics (routine tracking insights)
=======
* User authentication system
* Advanced analytics dashboard
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
* Cross-platform enhancements

---

## 📎 Submission Checklist

* ✔ Source Code (GitHub Repository)
* ✔ APK File
* ✔ Documentation (README)
* ✔ Demo Video

---

## 📜 License

<<<<<<< HEAD
This project is for educational purposes only.
=======
This project is developed for **educational purposes only**.
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
