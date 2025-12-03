# 🏠 Key & Dreams - Casa Vacanze App

![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-3.x-blue?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

**Key & Dreams** is a modern, cross-platform mobile application developed with Flutter designed to streamline the experience of finding and booking holiday homes. With an elegant user interface and a robust backend integration, it offers a seamless journey from browsing listings to confirming reservations.

---

## 📑 Table of Contents

- [🚀 Project Overview](#-project-overview)
- [✨ Key Features](#-key-features)
- [🛠 Tech Stack](#-tech-stack)
- [📂 Project Architecture](#-project-architecture)
- [🔌 API Reference](#-api-reference)
- [📱 Screenshots](#-screenshots)
- [🏁 Getting Started](#-getting-started)
- [📦 Installation](#-installation)
- [🧪 Testing](#-testing)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## 🚀 Project Overview

The **Casa Vacanze App** serves as a client-side solution for a holiday rental management system. It targets users looking for vacation rentals, providing them with:
- A secure platform to log in and manage their profile.
- A visual catalog of available properties ("Case Vacanza").
- A straightforward booking mechanism.

The application emphasizes user experience with custom animations (e.g., Splash Screen transitions), a polished design system using custom fonts (`PlayfairDisplay`) and gradients, and real-time data fetching.

---

## ✨ Key Features

### 🔐 Authentication & Security
- **JWT Login**: Secure authentication flow using JSON Web Tokens.
- **Auto-Login**: Persistent session management using `SharedPreferences` and token validation.
- **Secure Storage**: Sensitive user data handling.

### 🏡 Property Discovery
- **Dynamic Feed**: Real-time list of holiday houses fetched from the remote server.
- **Advanced Search**: Instant filtering by name, city, address, region, or description.
- **Rich Details**: High-quality images (with fallback support), pricing per night, and location details.

### 📅 Booking System
- **Intuitive Booking Form**: Date picker integration for start and end dates.
- **Guest Management**: Specify the number of guests.
- **Instant Validation**: Client-side checks before submission.

### 👤 User Profile
- **Personal Dashboard**: View user details (Name, Surname, Username).
- **Logout Functionality**: Securely clear sessions.

---

## 🛠 Tech Stack

### Core
- **Framework**: [Flutter](https://flutter.dev/) (SDK ^3.7.2)
- **Language**: [Dart](https://dart.dev/)

### Dependencies
| Package | Purpose |
|---------|---------|
| `http` | Handling REST API requests (GET, POST). |
| `shared_preferences` | Local persistence for user sessions and tokens. |
| `jwt_decoder` | Decoding JWT tokens to extract user identity and roles. |
| `flutter_launcher_icons` | Generating native app icons for Android and iOS. |

### UI Resources
- **Fonts**: `PlayfairDisplay` for a premium, elegant typography.
- **Assets**: Custom branding (`logo.png`) and placeholder imagery.

---

## 📂 Project Architecture

The project is structured to promote separation of concerns and scalability:

```
lib/
├── core/                # Shared UI components and utilities
│   └── app_bar.dart     # Custom reusable AppBar widget
├── entity/              # Data models (POJOs)
│   ├── house.dart       # Holiday House model
│   ├── prenotazione.dart# Reservation model & API logic
│   └── user.dart        # User model & JWT parsing logic
├── pages/               # UI Screens (Views)
│   ├── home/            # Home screen modules (Feed, Search, BottomNav)
│   ├── login/           # Authentication screens
│   └── user/            # Profile screens
├── service/             # Business Logic & Networking
│   ├── http_login.dart  # Auth API service
│   ├── http_urls.dart   # API Endpoint constants
│   └── token.dart       # Token management service
└── main.dart            # Application Entry Point
```

---

## 🔌 API Reference

The application communicates with a backend server. Key endpoints configured in `lib/service/http_urls.dart`:

| Method | Endpoint | Description |
|--------|----------|-------------|
| **POST** | `/api/utente/login` | Authenticate user and retrieve JWT. |
| **POST** | `/api/utente/validate` | Validate an existing JWT token. |
| **GET** | `/api/casaVacanza/all` | Retrieve the list of all available houses. |
| **POST** | `/api/prenotazione/crea` | Submit a new booking reservation. |

**Base Host**: `http://cityscape.vpsgh.it:8080` (Configurable)

---

## 🏁 Getting Started

### Prerequisites

Ensure you have the following installed:
- **Flutter SDK**: [Install Guide](https://docs.flutter.dev/get-started/install)
- **Android Studio** or **VS Code** with Flutter extensions.
- **Git**.

### Environment Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/casavacanze_app.git
   cd casavacanze_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Installation**
   ```bash
   flutter doctor
   ```

---

## 📦 Installation

To run the app on an emulator or physical device:

### Android
```bash
flutter run
```

### iOS (macOS only)
```bash
cd ios
pod install
cd ..
flutter run
```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  Built with ❤️ using Flutter
</p>
