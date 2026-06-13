# TrustBill Flutter — Agent Instructions

Read `../../MASTER_PROMPT.md` first. This file adds Flutter-specific rules on top of it.

## What this repo is

Flutter app targeting Android (package `com.trustinfacts.mobile`).
State: Riverpod. Navigation: GoRouter. HTTP: Dio with JWT + refresh interceptor. UI: Material 3.

## Architecture

```
lib/
  core/
    api/        ← api_client.dart (Dio + interceptors), endpoints.dart, api_error.dart
    auth/       ← auth_provider.dart, auth_state.dart (freezed), permission_provider.dart
    models/     ← freezed + json_serializable models (*.freezed.dart, *.g.dart are generated)
    router/     ← app_router.dart (GoRouter with auth guard)
    utils/      ← error_messages.dart (friendlyError()), currency.dart, date.dart
  features/     ← One folder per screen/feature
  widgets/      ← Shared widgets
```

## Critical rules for this repo

- **Always use `friendlyError()`** from `lib/core/utils/error_messages.dart` for user-facing error messages. Never show raw exception strings.
- **Never edit `*.freezed.dart` or `*.g.dart` files directly** — they are code-generated. Run `flutter pub run build_runner build --delete-conflicting-outputs` after changing models.
- **API model changes**: if the API adds a new required field, the corresponding freezed model must be updated AND `build_runner` re-run. Generated files must be committed.
- **Adding an API endpoint**: add it to `lib/core/api/endpoints.dart` first.
- **No `localStorage` or web storage**: use `flutter_secure_storage` for tokens, Riverpod state for UI state.

## Auth flow

1. Login → `POST /auth/login` → receives `accessToken` + `refreshToken`
2. Tokens stored in `flutter_secure_storage`
3. Dio interceptor auto-refreshes on 401 via `POST /auth/refresh`
4. On refresh failure → user is logged out and redirected to login

## Build & install

```bash
adb devices                          # verify USB device connected
flutter build apk --debug
adb install build/app/outputs/flutter-apk/app-debug.apk
```

## Tests

```bash
flutter test                         # runs test/ directory
```

Current test coverage: auth refresh flow. Most features have no widget tests — acceptable for now,
but new critical flows (invoice creation, payment) should have at least a unit test on the provider.

## Before any PR

- [ ] `flutter analyze` passes (no errors, warnings reviewed)
- [ ] `flutter test` passes
- [ ] `*.freezed.dart` and `*.g.dart` regenerated if models changed
- [ ] `friendlyError()` used for all user-facing error messages
- [ ] No raw API URLs hardcoded (use `endpoints.dart`)
- [ ] Stray file `%TEMP%check_verifactu.mjs` does not reappear (was deleted)
