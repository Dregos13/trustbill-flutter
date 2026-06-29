# TaskMap → TrustBill-Flutter Migration

> Status: COMPLETE ✅  
> Owner: TrustBill Senior Dev  
> Started: 2026-06-26  
> Approach: slow, iterative, test each phase before next

---

## Context

TaskMap (`trustbill-taskmap`) is a standalone Flutter app for field operations — clients on a map, task CRUD, agenda view. Goal: absorb it as a **gated module** inside TrustBill-Flutter. Super-admin enables/disables via API (`/me/capabilities` → `modules[]`). If disabled, tab hidden, routes redirect to `/`.

Same API server. Same auth. Same tenant model. Zero backend work needed.

---

## Hard Rules (read every session)

- One phase at a time. Never start next phase until current is GREEN.
- Every phase ends with a build check: `flutter build apk --debug` must pass.
- Never modify existing screens unless strictly required. Port, don't refactor.
- Always use `friendlyError()` from `lib/core/utils/error_messages.dart` for user-facing errors.
- Caveman mode always. `/graphify` before Glob/Grep. `/impeccable` for UI.
- Commit per phase with tag `feat(taskmap): phase-N ...`.

---

## Phase 1 — Foundation Upgrade

> Gate: Main app compiles clean on Riverpod 3 + GoRouter 17. No regressions.

### Why
TaskMap uses Riverpod 3.3.2 and GoRouter 17. Main app is on 2.5 / 14. Cannot port a single screen until versions match.

### Tasks

- [x] **1.1** Read current `pubspec.yaml` + all `.g.dart` and `.freezed.dart` files — understand scope
- [x] **1.2** Bump in `pubspec.yaml`:
  - `flutter_riverpod`: `^2.5.0` → `^3.0.0`
  - `riverpod_annotation`: `^2.3.0` → `^3.0.0`
  - `riverpod_generator`: `^2.4.0` → `^3.0.0`
  - `go_router`: `^14.0.0` → `^17.3.0`
  - `dio`: `^5.4.0` → `^5.9.0`
  - `flutter_secure_storage`: `^9.0.0` → `^10.3.0`
- [x] **1.3** Add new packages:
  - `flutter_map: ^8.3.0`
  - `flutter_map_marker_cluster: ^8.2.2`
  - `geolocator: ^13.0.2`
  - `latlong2: ^0.9.1`
- [x] **1.4** Run `flutter pub get` — resolve version conflicts (also bumped freezed→3, share_plus→13)
- [x] **1.5** Run `dart run build_runner build --delete-conflicting-outputs` — regenerated 28 outputs
- [x] **1.6** Fix Riverpod 3 breaking changes:
  - `StateNotifier`×3 → `Notifier` (auth, scan, theme)
  - `StateProvider.autoDispose`×5 screens → `NotifierProvider.autoDispose`
  - `valueOrNull`×4 files → `.asData?.value`
  - All `@freezed class` → `@freezed abstract class` (30+ models)
  - Test rewritten to use `ProviderContainer` overrides
- [x] **1.7** Fix GoRouter 17 breaking changes — no API changes needed, all signatures unchanged
- [x] **1.8** Add Android location permissions to `android/app/src/main/AndroidManifest.xml`
- [x] **1.9** `flutter build apk --debug` → succeeded (flutter clean required due to share_plus cache)
- [x] **1.10** Install on device (`adb install`) + smoke-test all existing screens — ✅ all pass

**Skills**: `/graphify` before touching files. `/diagnose` if build breaks.  
**Commit**: `feat(taskmap): phase-1 — upgrade Riverpod3 + GoRouter17 + map packages`

---

## Phase 2 — Module Gate Wiring

> Gate: Tab appears when `modules` contains `'taskmap'` + `permissions` contains `'tasks.read'`. Hidden otherwise. Routes redirect.

### Why
User requirement: super-admin enables/disables module per company. Already works at API level (taskmap's `AuthController` proves it). Wire it into main app.

### Tasks

- [x] **2.1** Read `lib/core/auth/permission_provider.dart` + `permission_helpers.dart` + `app_bottom_nav.dart`
- [x] **2.2** Add `tasksRead` + `tasksWrite` to `permission_helpers.dart`
- [x] **2.3** Add `hasModuleProvider` to `permission_provider.dart`
- [x] **2.4** Add `@Default([]) List<String> modules` to `UserInfo` in `user.dart` + regenerate (28 outputs)
- [x] **2.5** Add `requiredModule` field to `_TabDef` in `app_bottom_nav.dart`
- [x] **2.6** Update `visibleTabsProvider` — filter by module gate then permission gate
- [x] **2.7** Add `'Tareas'` tab to `_allTabs` (route `/tasks`, module `taskmap`, perm `tasks.read`)
- [x] **2.8** Create `lib/features/tasks/tasks_screen.dart` stub + add `/tasks` route in ShellRoute
- [x] **2.9** Add module redirect in `app_router.dart`: `/tasks` → `/no-permission` if `!user.modules.contains('taskmap')`
- [x] **2.10** `flutter build apk --debug` → ✅ succeeded
- [x] **2.11** Installed on device — tab hidden by default (modules:[]) ✅

**Skills**: `/graphify` before edits. `/code-review` after.  
**Commit**: `feat(taskmap): phase-2 — module gate, tasks.read permission, stub tab`

---

## Phase 3 — Data Layer Port

> Gate: All taskmap models and repository compile inside main app. No UI yet.

### Why
Clean separation: get data layer right before touching UI. Easier to unit-test. Establishes naming conventions for Phase 4.

### Destination folder: `lib/features/taskmap/`

### Tasks

- [x] **3.1** Create folder structure:
  ```
  lib/features/taskmap/
    data/
      models/
      providers.dart
      task_actions.dart
      tasks_repository.dart
    map/
    agenda/
    task/
    shared/
  ```
- [x] **3.2** Port `task_status.dart` → `lib/features/taskmap/data/models/task_status.dart` (updated AppColors import)
- [x] **3.3** Port all models into `lib/features/taskmap/data/models/`:
  - `field_task.dart`, `map_client.dart`, `bill.dart`, `task_summary.dart`, `task_form_options.dart`
  - Added 4 status colors to main app `AppColors`
- [x] **3.4** Port `tasks_repository.dart` — fixed `?clientId`/`?bbox` null-aware map syntax; added `Dio get dio` getter to `ApiClient`
- [x] **3.5** Port `task_actions.dart` — adapted provider imports to main app
- [x] **3.6** Create `providers.dart` — `_activeCompanyProvider` wired to `authProvider` (Riverpod 3, no authControllerProvider)
- [x] **3.7** `flutter analyze lib/features/taskmap/` → 0 issues
- [x] **3.8** `flutter build apk --debug` → ✅

**Skills**: `/graphify` before. Copy files manually with Read+Write tools — don't trust raw copy.  
**Commit**: `feat(taskmap): phase-3 — data layer models + repository`

---

## Phase 4 — UI Screens Port

> Gate: All taskmap screens render inside main app. Riverpod wired. No crashes.

### Why
The meat of the migration. Each screen is self-contained. Port one screen, verify, move to next.

### Destination: `lib/features/taskmap/`

### Order (safest → most complex)

#### 4A — Shared Widgets ✅
- [x] **4A.1** Read all files in taskmap's `shared/widgets/`
- [x] **4A.2** Port to `lib/features/taskmap/shared/`:
  - `glass_card.dart`, `skeleton.dart`, `status_chip.dart`, `info_pane.dart`
  - `money_text.dart`, `state_views.dart`
  - Skipped: `app_background.dart`, `brand_mark.dart`, `company_switcher.dart` (unused in ported screens)
  - Created: `tm_colors.dart`, `tm_spacing.dart`, `tm_type.dart` (taskmap design tokens)
- [x] **4A.3** Added 4 status colors to main `AppColors`; "Más" overflow bottom nav (max 4 pinned + sheet)
- [x] **4A.4** `flutter analyze` → 0 issues | device test ✅ | commit: `phase-4A`

#### 4B — Task Widgets ✅
- [x] **4B.1** Port `task_list_item.dart` → uses `?trailing` null-aware Dart 3.7 spread
- [x] **4B.2** Port `advance_button.dart` → FilledButton.icon with nextStatus color
- [x] **4B.3** Port `set_location.dart` → GPS + drop-pin picker; userAgent → `com.trustinfacts.mobile`
- [x] Added `format.dart` (formatDay/formatDayTime), TmColors.bg/surface, TmRadii.xl/brXl
- [x] `flutter analyze` → 0 issues | build ✅ | commit: `phase-4B` | version `1.1.4+20`

#### 4C — Agenda Screen ✅
- [x] **4C.1** Read `features/agenda/agenda_screen.dart` from taskmap
- [x] **4C.2** Port to `lib/features/taskmap/agenda/agenda_screen.dart`
  - Dark gradient background (DecoratedBox); CompanySwitcher removed
  - Date buckets: Vencidas/Hoy/Mañana/Esta semana/Más adelante/Sin programar/Anteriores
  - Abiertas/Todas segmented toggle
- [x] **4C.3** Riverpod: `agendaTasksProvider(bool)` — already wired in data layer
- [x] **4C.4** Router: `/tasks` → `AgendaScreen` (was stub `TasksScreen`); stub deleted
- [x] **4C.5** FAB "Nueva tarea" added to `AppShell._buildFab` for `/tasks` route
- [x] Added `TmType.display` (26px w800); device test ✅ | commit: `phase-4C` | version `1.1.4+21`

#### 4D — Task Detail + Form ✅
- [x] **4D.1–2** Port `task_detail_screen.dart` → own dark Scaffold; `canWrite` via `hasPermissionProvider`
- [x] **4D.3–4** Port `task_form_screen.dart` → `Theme(_tmDark())` wrapper; status chips; client picker sheet; location warning
- [x] **4D.5** Routes added outside ShellRoute: `/task/new`, `/task/:id/edit`, `/task/:id`
  - Module gate widened: `loc.startsWith('/task')` (covers all taskmap routes)
- [x] **4D.6** Device test: create/view/edit/advance/delete all ✅
- [x] Added TmColors: hairline/statusPending/statusInProgress; TmType.moneyLg
- [x] `flutter analyze` → 0 issues | build ✅ | commit: `phase-4D` | version `1.1.4+22`

#### 4E — Map Screen ✅
- [x] **4E.1** Read `features/map/map_screen.dart` + `client_tasks_sheet.dart` + `widgets/task_pin.dart`
- [x] **4E.2** Port `task_pin.dart` → `lib/features/taskmap/map/widgets/task_pin.dart`
- [x] **4E.3** Port `client_tasks_sheet.dart` → `lib/features/taskmap/map/client_tasks_sheet.dart`
- [x] **4E.4** Port `map_screen.dart` → `lib/features/taskmap/map/map_screen.dart`
  - FAB stripped from MapScreen (AppShell handles it) — consistent with all other screens
  - CompanySwitcher removed (decided in 4C)
  - GPS "Mi ubicación" button added to header overlay
  - userAgentPackageName: com.trustinfacts.mobile
- [x] **4E.5** `/map` route added in ShellRoute; "Mapa" added as separate entry in "Más" overflow sheet; "Tareas" icon changed to checklist; module gate extended to cover `/map`
- [x] **4E.6** `flutter build apk --debug` → ✅
- [x] **4E.7** Device test: map loads tiles, GPS button centers map, pins appear, tap pin → client sheet, tap task → detail ✅ | version `1.1.4+23`

**Commit**: `feat(taskmap): phase-4E — map screen + clustering`

---

## Phase 5 — Router + Shell Integration

> Gate: Full navigation flow works. Module gate enforced at router level.

### Tasks

- [x] **5.1** `/map` route wired to real `MapScreen()` in ShellRoute (done in 4E)
- [x] **5.2** `/tasks` (agenda) + `/map` both inside ShellRoute (done in 4C + 4E)
- [x] **5.3** `/task/new`, `/task/:id`, `/task/:id/edit` OUTSIDE ShellRoute (done in 4D)
- [x] **5.4** Router redirect: `/task*` + `/map*` → `/no-permission` if `!hasModule('taskmap')` (done in 4D + 4E)
- [x] **5.5** AppShell FAB: `/map` + `/tasks` → "Nueva tarea" (tasks.write); detail/form screens → no FAB
- [x] **5.6** Bottom nav: Inicio/Clientes/Facturas/Compras pinned; Catálogo, Tareas, Mapa in "Más" overflow
- [x] **5.7** AppShell PopScope: any non-`/` route → back → `go('/')` (covers `/map` and `/tasks`)
- [x] **5.8** `flutter build apk --debug` → ✅
- [x] **5.9** Full nav test ✅ | version `1.1.4+24`

**Commit**: `feat(taskmap): phase-5 — router integration + shell FAB + nav order`

---

## Phase 6 — QA + Hardening

> Gate: All flows green on real device. Module gating verified. No regressions on existing features.

### Tasks

- [x] **6.1** Full smoke test — existing features:
  - Login → Dashboard → Clientes → Facturas → Compras → Catálogo → Account
  - Invoice CRUD, Budget, Sales, Scan
- [x] **6.2** TaskMap module ENABLED tests:
  - Tab "Tareas" visible
  - Map loads OSM tiles
  - Pins render, clusters group correctly
  - Tap pin → client sheet → tap task → detail
  - Create new task (with + without invoice link)
  - Edit task
  - Advance status (PENDING → IN_PROGRESS → DONE)
  - Set client location via map
- [x] **6.3** TaskMap module DISABLED tests:
  - Tab "Tareas" hidden
  - Deep-link `/map` → redirects to `/`
  - Deep-link `/task/1` → redirects to `/`
- [x] **6.4** Location permission flow:
  - First launch → permission dialog appears
  - Denied → map still loads (no crash), location button disabled
  - Granted → map centers on user
- [x] **6.5** Offline / API down:
  - Task list shows error state (not crash)
  - Map shows error state
- [x] **6.6** Verify `friendlyError()` used in all taskmap error states
- [x] **6.7** Final `flutter build apk --debug` + `adb install` + full pass
- [x] **6.8** Archive taskmap repo: tag it `v1.2.0-final-standalone`, add README note pointing to main app

**Skills**: `/verify` skill for manual device testing. `/code-review` final pass.  
**Commit**: `feat(taskmap): phase-6 — QA pass, module gating verified, archived standalone app`

---

## Phase 7 — Calendar View + Bug Fixes

> Gate: Calendar week view working in Tareas. Bugs from QA verified fixed. Build clean.

### Bug fixes

- [x] **7.1** Bug: `CreateSaleScreen` didn't inherit `taxKind` from budget → added `initialTaxKind` param, passed via router `extra`
- [x] **7.2** Bug: back nav after "Emitir factura" from sale exited app (iOS) → `sale_detail_screen` `context.push` → `context.go`
- [x] **7.3** Feature: map client sheet groups tasks by status — "En curso" / "Pendiente" / "Completadas" with section headers
- [x] **7.4** Feature: "Detectar ubicación" GPS button in create client form — map confirmation dialog → auto-PATCH location after create
- [x] **7.5** Feature: calendar week view in Tareas — "Lista" | "Calendario" toggle, week grid, tap slot → pre-filled task form

### Calendar implementation

- `lib/features/taskmap/agenda/calendar_week_view.dart` — new file
  - `PageView` for week swiping (page 1000 = current week)
  - 7 columns × 24 hourly rows, `_kHourH = 56px` per row
  - Task chips positioned via `Positioned(top: hour * 56)`, colored by status
  - Tap empty slot → `onSlotTap(DateTime)` → router pushes `/task/new` with `scheduledAt` in extra
  - Tap chip → `onTaskTap(FieldTask)` → router pushes `/task/:id`
- `TaskFormScreen` — added `initialScheduledAt` param, wired in `_load()`
- `app_router.dart` `/task/new` — reads `extra['scheduledAt']` as `DateTime?`

**Commit**: `feat(taskmap): phase-7 — calendar week view + bug fixes`

---

## Decisions Log

| # | Decision | Reason |
|---|----------|--------|
| 1 | Port screens manually (Read+Write) not git merge | Avoid importing taskmap's broken import graph |
| 2 | Taskmap screens go under `lib/features/taskmap/` | Isolated, deletable if we revert |
| 3 | Shared widgets duplicated under `taskmap/shared/` first | Avoids breaking existing widgets during port; reconcile after QA |
| 4 | Riverpod 3 style: plain `Notifier`, no code-gen for taskmap files | Taskmap never used code-gen; keep consistent with source |
| 5 | `/task/*` routes OUTSIDE ShellRoute | Same pattern as `/invoices/new`, `/clients/new` — full-screen forms |
| 6 | Tab label: "Tareas" (not "Mapa") | Feature is task management; map is just one view |

---

## Reference Files

### TaskMap source (read-only reference)
- Router: `trustbill-taskmap/lib/core/router/app_router.dart`
- Auth controller: `trustbill-taskmap/lib/core/auth/auth_controller.dart`
- Map screen: `trustbill-taskmap/lib/features/map/map_screen.dart`
- Tasks repo: `trustbill-taskmap/lib/data/tasks_repository.dart`

### Main app targets (edit here)
- Pubspec: `trustbill-flutter/pubspec.yaml`
- Router: `trustbill-flutter/lib/core/router/app_router.dart`
- Permissions: `trustbill-flutter/lib/core/auth/permission_provider.dart`
- Bottom nav: `trustbill-flutter/lib/widgets/app_bottom_nav.dart`
- Shell: `trustbill-flutter/lib/widgets/app_shell.dart`

---

## Phase Completion Checklist

| Phase | Status | Build OK | Device Test | Commit |
|-------|--------|----------|-------------|--------|
| 1 — Foundation | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-1 |
| 2 — Module Gate | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-2 |
| 3 — Data Layer | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-3 |
| 4A–D — UI (partial) | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-4A…4D |
| 4E — Map Screen | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-4E |
| 5 — Router | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-5 |
| 6 — QA | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-6 |
| 7 — Calendar + Bug fixes | ✅ DONE | ✅ | ✅ | feat(taskmap): phase-7 |
