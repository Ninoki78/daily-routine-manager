# 📱 Daily Routine Manager App

## 📌 Overview

The **Daily Routine Manager App** is a Flutter-based mobile application designed to help users plan, manage, and track their daily activities efficiently. The application emphasizes usability, clean architecture, and real-world functionality by integrating persistent storage, API communication, and device-level features.

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

* Local state managed using `setState()`
* Global state managed using **Provider**
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

## 🏗️ Project Structure

```bash
daily_routine_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── widgets/
│   └── utils/
├── assets/
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

---

## ⚙️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
* **Storage:** Local database / file system
* **API Handling:** HTTP / REST

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

* Manual testing on emulator and real device
* Validation of user inputs
* API response verification
* Edge case handling:

  * Empty data states
  * Network failures
  * Invalid inputs

---

## 🎥 Demo & Presentation

👉 **Presentation Video Link:**
[]

👉 **APK Download:**
[]


---

## 👥 Team Contributions

| Member            |    ID   | Responsibility                  |
| ----------------- | ------- |-------------------------------- |
| Mesnanat Teshager |         | UI Screens and Design           |
| Tinsaye Gezahegn  | 1005/15 | Navigation & State Management   |
| Eldana Tesfahun   |         | Database & Data Persistence     | 
|                   |         | API Integration and Utilities   | 
|                   |         | Notifications & Device Features | 
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

* ✔ Source Code (GitHub Repository)
* ✔ APK File
* ✔ Documentation (README)
* ✔ Demo Video

---

## 📜 License

This project is for educational purposes only.
