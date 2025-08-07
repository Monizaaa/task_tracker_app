# Task Tracker App

A Flutter-based mobile application for tracking tasks and projects.

## Backend API

This Flutter application requires a backend server to function correctly. The source code for the compatible API is available on GitHub:

- **Backend Repository**: [https://github.com/Monizaaa/task-tracker-api](https://github.com/Monizaaa/task-tracker-api)

Please follow the instructions in the backend repository's README to set up and run the server locally.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK
- A configured IDE (like VS Code or Android Studio)
- A running instance of the backend API.

### Configuration

Before running the app, you need to configure the base URL to point to your running backend server.

1.  Open the file `lib/core/api/api_client.dart`.
2.  Find the `baseUrl` variable.
3.  Replace the IP address with the IP address of your local machine where the backend server is running. For the Android emulator, `10.0.2.2` usually works to connect to your host machine's `localhost`.

    ```dart
    // lib/core/api/api_client.dart
    final String baseUrl = "http://YOUR_LOCAL_IP:3000/api";
    ```

---
# task_tracker_app
