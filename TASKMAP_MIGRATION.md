# TaskMap → TrustBill-Flutter Migration

> Status: PLANNING  
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

- [ ] **2.1** Read `lib/core/auth/permission_provider.dart` + `permission_helpers.dart` + `app_bottom_nav.dart`
- [ ] **2.2** Add to `permission_helpers.dart`:
  ```dart
  static const tasksRead = 'tasks.read';
  static const tasksWrite = 'tasks.write';
  ```
- [ ] **2.3** Add to `permission_provider.dart`:
  ```dart
  // Returns true if authenticated user's modules list contains [moduleName].
  final hasModuleProvider = Provider.family<bool, String>((ref, moduleName) {
    final auth = ref.watch(authProvider);
    if (auth is AuthAuthenticated) return auth.user.modules.contains(moduleName);
    return false;
  });
  ```
- [ ] **2.4** Verify `AuthAuthenticated` (in `auth_state.freezed.dart`) exposes `modules`. If not, add `List<String> modules = const []` field and regenerate.
- [ ] **2.5** Add `requiredModule` field to `_TabDef` in `app_bottom_nav.dart`:
  ```dart
  final String? requiredModule; // null = no module gate
  ```
- [ ] **2.6** Update `visibleTabsProvider` — filter by both permission AND module:
  ```dart
  final visible = _allTabs.where((tab) {
    final permOk = tab.requiredPermission == null || ...existing check...;
    final modOk = tab.requiredModule == null ||
        ref.watch(hasModuleProvider(tab.requiredModule!));
    return permOk && modOk;
  }).toList();
  ```
- [ ] **2.7** Add stub `'Tareas'` tab to `_allTabs`:
  ```dart
  _TabDef(
    route: '/map',
    routePrefix: '/map',
    icon: Icons.map_outlined,
    activeIcon: Icons.map,
    label: 'Tareas',
    requiredPermission: Permissions.tasksRead,
    requiredModule: 'taskmap',
  ),
  ```
- [ ] **2.8** Add stub route `/map` to `app_router.dart` (temporary placeholder screen):
  ```dart
  GoRoute(
    path: '/map',
    builder: (_, _) => const Scaffold(body: Center(child: Text('Tareas — próximamente'))),
  ),
  ```
- [ ] **2.9** Add module redirect: in `app_router.dart` redirect block, if user navigates to `/map` or `/task/*` and `!hasModule('taskmap')` → return `'/'`
- [ ] **2.10** `flutter build apk --debug` → must succeed
- [ ] **2.11** Test: call API to enable/disable `taskmap` module, verify tab appears/disappears on hot restart

**Skills**: `/graphify` before edits. `/code-review` after.  
**Commit**: `feat(taskmap): phase-2 — module gate, tasks.read permission, stub tab`

---

## Phase 3 — Data Layer Port

> Gate: All taskmap models and repository compile inside main app. No UI yet.

### Why
Clean separation: get data layer right before touching UI. Easier to unit-test. Establishes naming conventions for Phase 4.

### Destination folder: `lib/features/taskmap/`

### Tasks

- [ ] **3.1** Create folder structure:
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
- [ ] **3.2** Port `core/models/task_status.dart` → `lib/features/taskmap/data/models/task_status.dart`
  - Keep identical, just move namespace
- [ ] **3.3** Port models from taskmap into `lib/features/taskmap/data/models/`:
  - `field_task.dart` (FieldTask, ClientRef)
  - `map_client.dart` (MapClient, StatusCounts)
  - `bill.dart` (BillSummary, BillLine)
  - `task_summary.dart` (TaskSummary)
  - `task_form_options.dart` (TaskClientOption, AssignableUser, InvoiceOption, TaskInput)
  - Fix all import paths to point inside main app
- [ ] **3.4** Port `tasks_repository.dart` → `lib/features/taskmap/data/tasks_repository.dart`
  - `ApiClient` import → `lib/core/api/api_client.dart` (main app's client)
- [ ] **3.5** Port `task_actions.dart` → `lib/features/taskmap/data/task_actions.dart`
- [ ] **3.6** Create `lib/features/taskmap/data/providers.dart`:
  ```dart
  final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
    return TasksRepository(ref.watch(apiClientProvider));
  });
  ```
  - Wire to main app's `apiClientProvider` from `lib/core/api/api_client.dart`
- [ ] **3.7** Run `flutter analyze` on new files — zero errors
- [ ] **3.8** `flutter build apk --debug` → must succeed

**Skills**: `/graphify` before. Copy files manually with Read+Write tools — don't trust raw copy.  
**Commit**: `feat(taskmap): phase-3 — data layer models + repository`

---

## Phase 4 — UI Screens Port

> Gate: All taskmap screens render inside main app. Riverpod wired. No crashes.

### Why
The meat of the migration. Each screen is self-contained. Port one screen, verify, move to next.

### Destination: `lib/features/taskmap/`

### Order (safest → most complex)

#### 4A — Shared Widgets
- [ ] **4A.1** Read all files in taskmap's `shared/widgets/`
- [ ] **4A.2** Port to `lib/features/taskmap/shared/`:
  - `glass_card.dart`
  - `skeleton.dart`
  - `status_chip.dart`
  - `info_pane.dart`
  - `money_text.dart`
  - `state_views.dart`
  - `app_background.dart`
  - `brand_mark.dart`
  - `company_switcher.dart`
- [ ] **4A.3** Check for conflicts with existing `lib/widgets/` — if widget is identical, use existing one instead of duplicating
- [ ] **4A.4** `flutter analyze` — zero errors

#### 4B — Task List Item + Status Chip
- [ ] **4B.1** Port `features/task/widgets/task_list_item.dart`
- [ ] **4B.2** Port `features/task/widgets/advance_button.dart`
- [ ] **4B.3** Port `features/task/widgets/set_location.dart`

#### 4C — Agenda Screen (simplest screen)
- [ ] **4C.1** Read `features/agenda/agenda_screen.dart` from taskmap
- [ ] **4C.2** Port to `lib/features/taskmap/agenda/agenda_screen.dart`
- [ ] **4C.3** Wire Riverpod providers (adapt Notifier style to match main app patterns)
- [ ] **4C.4** Add route `/agenda` to `app_router.dart` inside ShellRoute
- [ ] **4C.5** Test on device: agenda loads, tasks show

#### 4D — Task Detail + Form
- [ ] **4D.1** Read `features/task/task_detail_screen.dart`
- [ ] **4D.2** Port to `lib/features/taskmap/task/task_detail_screen.dart`
- [ ] **4D.3** Read `features/task/task_form_screen.dart`
- [ ] **4D.4** Port to `lib/features/taskmap/task/task_form_screen.dart`
- [ ] **4D.5** Add routes outside ShellRoute (full-screen, like existing form screens):
  - `/task/new`
  - `/task/:id`
  - `/task/:id/edit`
- [ ] **4D.6** Test: create task, view, edit, advance status

#### 4E — Map Screen (most complex — flutter_map + clustering)
- [ ] **4E.1** Read `features/map/map_screen.dart` + `client_tasks_sheet.dart` + `widgets/task_pin.dart`
- [ ] **4E.2** Port `task_pin.dart` → `lib/features/taskmap/map/widgets/task_pin.dart`
- [ ] **4E.3** Port `client_tasks_sheet.dart` → `lib/features/taskmap/map/client_tasks_sheet.dart`
- [ ] **4E.4** Port `map_screen.dart` → `lib/features/taskmap/map/map_screen.dart`
  - Use `/impeccable` skill for UI polish
  - Verify OpenStreetMap tile URL in flutter_map config
  - Verify geolocator permission request flow
- [ ] **4E.5** `flutter build apk --debug` → must succeed
- [ ] **4E.6** Install + test: map loads tiles, pins appear, tap pin → client sheet, tap task → detail

**Skills**: `/graphify`, `/impeccable` for map UI, `/diagnose` if map tiles fail to load.  
**Commit**: `feat(taskmap): phase-4 — all screens ported (agenda, task CRUD, map)`

---

## Phase 5 — Router + Shell Integration

> Gate: Full navigation flow works. Module gate enforced at router level.

### Tasks

- [ ] **5.1** Replace stub `/map` route with real `MapScreen()`
- [ ] **5.2** Move `/agenda` + `/map` into ShellRoute (bottom nav destinations)
- [ ] **5.3** Keep `/task/new`, `/task/:id`, `/task/:id/edit` OUTSIDE ShellRoute (full-screen, no bottom nav)
- [ ] **5.4** Router redirect: paths starting with `/map`, `/agenda`, `/task` → redirect to `/` if `!hasModule('taskmap')`
- [ ] **5.5** Update `AppShell._buildFab()` in `lib/widgets/app_shell.dart`:
  - Add case for `/map` → FAB = "Nueva tarea" (requires `tasks.write`)
  - Add case for `/agenda` → no FAB (list view, FAB on map)
- [ ] **5.6** Update `AppBottomNav` — tab order: Inicio, Clientes, Facturas, Compras, Catálogo, **Tareas** (last)
- [ ] **5.7** PopScope on `/map` → back → go to `/` (same pattern as existing screens)
- [ ] **5.8** `flutter build apk --debug` → must succeed
- [ ] **5.9** Full nav test: all tabs navigate correctly, back button correct

**Commit**: `feat(taskmap): phase-5 — router integration + shell FAB + nav order`

---

## Phase 6 — QA + Hardening

> Gate: All flows green on real device. Module gating verified. No regressions on existing features.

### Tasks

- [ ] **6.1** Full smoke test — existing features:
  - Login → Dashboard → Clientes → Facturas → Compras → Catálogo → Account
  - Invoice CRUD, Budget, Sales, Scan
- [ ] **6.2** TaskMap module ENABLED tests:
  - Tab "Tareas" visible
  - Map loads OSM tiles
  - Pins render, clusters group correctly
  - Tap pin → client sheet → tap task → detail
  - Create new task (with + without invoice link)
  - Edit task
  - Advance status (PENDING → IN_PROGRESS → DONE)
  - Set client location via map
- [ ] **6.3** TaskMap module DISABLED tests:
  - Tab "Tareas" hidden
  - Deep-link `/map` → redirects to `/`
  - Deep-link `/task/1` → redirects to `/`
- [ ] **6.4** Location permission flow:
  - First launch → permission dialog appears
  - Denied → map still loads (no crash), location button disabled
  - Granted → map centers on user
- [ ] **6.5** Offline / API down:
  - Task list shows error state (not crash)
  - Map shows error state
- [ ] **6.6** Verify `friendlyError()` used in all taskmap error states
- [ ] **6.7** Final `flutter build apk --debug` + `adb install` + full pass
- [ ] **6.8** Archive taskmap repo: tag it `v1.2.0-final-standalone`, add README note pointing to main app

**Skills**: `/verify` skill for manual device testing. `/code-review` final pass.  
**Commit**: `feat(taskmap): phase-6 — QA pass, module gating verified, archived standalone app`

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
| 2 — Module Gate | ⬜ TODO | ⬜ | ⬜ | — |
| 3 — Data Layer | ⬜ TODO | ⬜ | ⬜ | — |
| 4 — UI Screens | ⬜ TODO | ⬜ | ⬜ | — |
| 5 — Router | ⬜ TODO | ⬜ | ⬜ | — |
| 6 — QA | ⬜ TODO | ⬜ | ⬜ | — |
