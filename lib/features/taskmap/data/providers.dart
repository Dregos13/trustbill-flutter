import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/auth/auth_state.dart';
import 'models/field_task.dart';
import 'models/map_client.dart';
import 'models/task_form_options.dart';
import 'models/task_status.dart';
import 'models/task_summary.dart';
import 'tasks_repository.dart';

final tasksRepositoryProvider = Provider<TasksRepository>(
  (ref) => TasksRepository(ref.watch(apiClientProvider)),
);

/// Re-fetch company-scoped data whenever the active company changes.
final _activeCompanyProvider = Provider.autoDispose<int?>(
  (ref) => ref.watch(
    authProvider.select(
      (s) => s is AuthAuthenticated ? s.activeCompanyId : null,
    ),
  ),
);

/// Status counts for the agenda header.
final taskSummaryProvider = FutureProvider.autoDispose<TaskSummary>((ref) {
  ref.watch(_activeCompanyProvider);
  return ref.watch(tasksRepositoryProvider).summary();
});

/// Client pins for the map.
final mapClientsProvider = FutureProvider.autoDispose<List<MapClient>>((ref) {
  ref.watch(_activeCompanyProvider);
  return ref.watch(tasksRepositoryProvider).mapClients();
});

/// Open jobs (pending + in-progress) for the agenda list.
final openTasksProvider = FutureProvider.autoDispose<List<FieldTask>>((
  ref,
) async {
  ref.watch(_activeCompanyProvider);
  final result = await ref
      .watch(tasksRepositoryProvider)
      .listTasks(status: const [TaskStatus.pending, TaskStatus.inProgress]);
  return result.items;
});

/// All tasks for a single client (map pin tap → sheet).
final clientTasksProvider = FutureProvider.autoDispose
    .family<List<FieldTask>, int>((ref, clientId) async {
      final result = await ref
          .watch(tasksRepositoryProvider)
          .listTasks(clientId: clientId);
      return result.items;
    });

/// Detail for a single task.
final taskDetailProvider = FutureProvider.autoDispose.family<FieldTask, int>(
  (ref, id) => ref.watch(tasksRepositoryProvider).getTask(id),
);

/// Agenda feed. `includeDone == false` → open tasks only (pending + in-progress);
/// `true` → every status. Grouped into date buckets client-side by the screen.
final agendaTasksProvider = FutureProvider.autoDispose
    .family<List<FieldTask>, bool>((ref, includeDone) async {
      ref.watch(_activeCompanyProvider);
      final result = await ref
          .watch(tasksRepositoryProvider)
          .listTasks(
            status: includeDone
                ? null
                : const [TaskStatus.pending, TaskStatus.inProgress],
            limit: 100,
          );
      return result.items;
    });

/// All clients (id/name/coords) for the task form's client picker.
final formClientsProvider = FutureProvider.autoDispose<List<TaskClientOption>>((
  ref,
) {
  ref.watch(_activeCompanyProvider);
  return ref.watch(tasksRepositoryProvider).formClients();
});

/// Company members assignable to a task.
final formUsersProvider = FutureProvider.autoDispose<List<AssignableUser>>((
  ref,
) {
  ref.watch(_activeCompanyProvider);
  return ref.watch(tasksRepositoryProvider).formUsers();
});

/// Invoices for a given client, for the bill picker.
final invoicesForClientProvider = FutureProvider.autoDispose
    .family<List<InvoiceOption>, int>(
      (ref, clientId) =>
          ref.watch(tasksRepositoryProvider).invoicesForClient(clientId),
    );
