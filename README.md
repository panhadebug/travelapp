# Travel App

A Flutter project for a Travel Application.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)

### Firebase Setup

This app uses Firebase for authentication and backend services. You need to configure it before running.

1.  **Log in to Firebase:**
    ```bash
    firebase login
    ```

2.  **Activate the FlutterFire CLI:**
    ```bash
    dart pub global activate flutterfire_cli
    ```

3.  **Configure the app:**
    ```bash
    flutterfire configure
    ```
    Select your Firebase project and the platforms you want to support (Android, iOS, Web, etc.). This will generate `lib/firebase_options.dart`.

### Running the App

Once Firebase is configured:

```bash
flutter run
```

## Project Structure

- `lib/main.dart`: Entry point.
- `lib/core`: Core utilities, router, theme.
- `lib/data`: Repositories and data sources.
- `lib/presentation`: Screens and providers.

## Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
