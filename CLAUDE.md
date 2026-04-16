# ThunderBolt Mobile — Flutter

## Dev Commands
```bash
flutter pub get
flutter run --dart-define-from-file=.env.development   # debug
flutter run --dart-define-from-file=.env.staging
flutter build apk --release
flutter build ios --release
flutter test
flutter test test/inventory_test.dart                  # single file
flutter gen-l10n                                       # regenerate after editing .arb files
```

## Folder Structure
```
mobile/lib/
├── main.dart
├── app/
│   ├── routes/             # GoRouter route definitions
│   └── theme/              # Design tokens matching the web UI
├── features/
│   ├── auth/               # Login, token storage (flutter_secure_storage)
│   ├── inventory/          # Stock levels, +/− buttons, low-stock alerts
│   ├── products/           # Product list, detail, edit
│   ├── orders/             # Order list, status updates
│   └── storage_units/      # Physical storage location management
├── l10n/                   # ARB files: app_en.arb, app_hi.arb, app_fr.arb,
│                           #            app_ja.arb, app_es.arb, app_ko.arb
├── shared/
│   ├── api/                # Dio client with Bearer token interceptor
│   ├── widgets/            # StockBadge, ScanButton, ConfirmDialog, UndoToast
│   └── models/             # json_serializable Dart models
└── core/
    ├── constants.dart
    └── env.dart            # API base URL per flavor (dev/staging/prod)
```

## Key Libraries
- `flutter_riverpod` — state management
- `dio` — HTTP client with auth interceptor
- `json_serializable` — model serialization
- `go_router` — navigation
- `flutter_localizations` + `intl` — i18n
- `flutter_secure_storage` — store Bearer token + selected locale
- `mobile_scanner` — barcode/QR scan for inventory lookup
- `flutter_local_notifications` — low-stock push notifications

## Flavors
Three flavors configured (dev / staging / prod) — each reads a different `.env.*` file via `--dart-define-from-file`.  
Never hardcode API URLs — always read from `env.dart`.
