# gccloud

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Code Overview

#### `main.dart`

- The `main.dart` file serves as the entry point for the application.
- It initializes the Flutter app (`MyApp`) and sets the login page (`LoginPage`) as the home screen.

#### `LoginPage`

- `LoginPage` is a stateful widget responsible for rendering the login UI.
- It contains dropdown menus for selecting Chiefs, SEs, and EEs, as well as a text input field for entering the password.
- Dropdown menus dynamically populate their options based on the user's selections and API responses.
- The `loginUser` function triggers the login API call and navigates to the appropriate page based on the response.

#### API Integration

- The application integrates with three APIs to fetch data for Chiefs, SEs, and EEs.
- `fetchChiefs`, `fetchSEs`, and `fetchEEs` functions make HTTP GET requests to the respective APIs and update the dropdown menus with the fetched data.
- The `loginUser` function makes an HTTP POST request to the login API with the selected EE's username and the entered password.

#### Pages

- The application contains two additional pages: `SuccessPage` and `ErrorPage`.
- These pages display messages indicating whether the login was successful or failed.

### Dependencies

This application uses the following dependencies:

- `flutter/material.dart`: Flutter's material design library for building UI components.
- `http`: A package for making HTTP requests.
- `dart:convert`: A package for encoding and decoding JSON data.

### Conclusion

This Flutter application demonstrates how to build a login screen with dynamic dropdown menus and API integration. Users can select their Chief, SE, and EE, enter a password, and submit the form to log in. The code can be further extended and customized to meet specific requirements.
