# MotoGenius Mobile

Flutter app for store owners to manage inventory and monitor stock levels in real-time.

**Stack:** Flutter 3.13+ · Riverpod · Dio · GoRouter

**Languages:** English, Hindi, French, Japanese, Spanish, Korean

## Quick Start

### Prerequisites
- Flutter 3.13+
- Dart 3.0+
- Android SDK or Xcode (depending on target)

### Installation

```bash
# Get dependencies
flutter pub get

# Generate i18n files (after editing .arb files)
flutter gen-l10n

# Run on device/emulator (development)
flutter run --dart-define-from-file=.env.development

# Run on staging
flutter run --dart-define-from-file=.env.staging
```

## Available Commands

```bash
flutter pub get              # Install dependencies
flutter gen-l10n             # Regenerate i18n after .arb edits
flutter run                  # Run on device/emulator
flutter run -d web           # Run on web browser
flutter build apk --release  # Build Android release
flutter build ios --release  # Build iOS release
flutter test                 # Run tests
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── routes/              # GoRouter configuration
│   └── theme/               # Design tokens
├── features/
│   ├── auth/                # Login, token storage
│   ├── inventory/           # Stock management, +/− buttons
│   ├── products/            # Product list, detail, edit
│   ├── orders/              # Order tracking
│   └── storage_units/       # Physical location management
├── l10n/                    # ARB files for i18n
├── shared/
│   ├── api/                 # Dio HTTP client
│   ├── widgets/             # Reusable UI components
│   └── models/              # JSON serializable models
└── core/
    ├── constants.dart
    └── env.dart             # API base URL per flavor
```

## Features

- 📦 Inventory management with +/− buttons
- 🔍 Barcode/QR code scanning for quick lookup
- 📱 Real-time stock level updates
- 🔔 Push notifications for low-stock alerts
- 🌍 6-language support
- 🔐 Secure token storage
- 🎨 Material Design UI

## API Integration

Connects to the Laravel backend API at `http://localhost:8000/api` (configurable per flavor).

## Authentication

Uses Dio interceptor to automatically inject Bearer token from `flutter_secure_storage`.

## i18n

ARB files in `lib/l10n/`:
- `app_en.arb` — English
- `app_hi.arb` — Hindi
- `app_fr.arb` — French
- `app_ja.arb` — Japanese
- `app_es.arb` — Spanish
- `app_ko.arb` — Korean

Regenerate typed accessors after editing: `flutter gen-l10n`

## Documentation

See `CLAUDE.md` for detailed architecture and conventions.
