# bus_pos

A new Flutter project.

## 1. Prerequisites
- Flutter SDK (>=3.5.0)
- Dart SDK (>=3.5.0)
- Android Studio / VS Code
- A working emulator or physical device

## ⚡ 2. Terminal Commands  

```bash
# Install dependencies
flutter pub get   

# Build in dev mode (supports hot reload)
flutter build   

# Run in production mode
flutter run --release     #app builds in prodution mode
```

## 3 . Folder Structure
    lib/
│── core/                     # Shared resources across the app
│   ├── constants/             # App-wide constants (colors, themes, strings)
│   ├── utils/                 # Helpers (formatters, validators, extensions)
│   ├── services/              # Shared services
│   │   ├── api_client.dart        # Handles HTTP requests
│   │   └── local_storage.dart     # Wrapper around SharedPreferences
│   ├── widgets/               # Reusable UI widgets (buttons, loaders, etc.)
│   └── config/                # App config (env, routes, providers setup)
│
│── features/                  # Feature-first structure
│   ├── authentication/                  # Authentication module
│   │   ├── data/              # Data sources (remote/local APIs)
│   │   │   └── auth_api.dart
│   │   │   └── auth_local.dart
│   │   ├── models/            # Data Transfer Objects (e.g., User model)
│   │   ├── providers/         # State management (AuthProvider)
│   │   ├── repository/        # Repository layer (AuthRepository)
│   │   ├── ui/                # Screens (login, register, forgot password)
│   │   └── widgets/           # Auth-specific widgets (forms, inputs, etc.)
│   │
│   
│
│── app.dart                   # Root widget 
│── main.dart                  # App entry point

## Explanation

Core

constants/ → global constants (theme colors, text styles, app strings).

utils/ → helper functions like formatDate, validators, etc.

services/ → reusable services like ApiClient (for HTTP) and LocalStorage.

widgets/ → reusable shared widgets (AppButton, LoadingIndicator).

config/ → app environment setup (AppConfig, AppRoutes).

Features

Each feature (e.g., auth, store, ads) follows the same internal structure:

data/ → API classes (auth_api.dart) or local DB access.

models/ → Dart classes (DTOs/Entities).

repository/ → Abstract layer combining APIs + storage.

providers/ → State management (AuthProvider) using ChangeNotifier.

ui/ → Screens (LoginScreen, RegisterScreen).

widgets/ → UI components specific to that feature.