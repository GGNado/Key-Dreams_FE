# Casa Vacanze App

A Flutter application for booking holiday houses. This app allows users to browse available holiday homes, view details, and make reservations.

## Features

*   **User Authentication**: Secure login system using JWT tokens.
*   **House Browsing**: View a list of available holiday houses with images and details.
*   **Search & Filter**: Filter houses by name, location, or description.
*   **Booking System**: Select dates and number of guests to book a house.
*   **User Profile**: View user information.

## Getting Started

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
*   An IDE (VS Code, Android Studio, or IntelliJ) with Flutter/Dart plugins.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd casavacanze_app
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the application:**

    ```bash
    flutter run
    ```

## Project Structure

The project follows a standard Flutter architecture:

*   **`lib/core/`**: Core components and utilities (e.g., custom app bar).
*   **`lib/entity/`**: Data models (entities) like `House`, `User`, `Prenotazione`.
*   **`lib/pages/`**: UI screens (pages) organized by feature (Home, Login, User).
*   **`lib/service/`**: Services for API communication (`HttpLogin`) and data storage (`TokenStorage`).
*   **`lib/main.dart`**: Application entry point.

## Configuration

The application connects to a backend server defined in `lib/service/http_urls.dart`.
Ensure the backend server is running and reachable.

## Documentation

The codebase is thoroughly documented using DartDoc standards. You can view the inline documentation in your IDE or generate HTML documentation using:

```bash
dart doc .
```
