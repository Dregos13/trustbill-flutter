import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/field_task.dart';
import 'models/task_form_options.dart';
import 'models/task_status.dart';
import 'providers.dart';

/// Task mutations that also refresh the relevant cached providers so the map,
/// agenda, summary and detail all stay consistent after a change.
class TaskActions {
  TaskActions(this._ref);

  final Ref _ref;

  Future<FieldTask> setStatus(int id, TaskStatus status) async {
    final updated = await _ref
        .read(tasksRepositoryProvider)
        .updateStatus(id, status);
    _refresh();
    return updated;
  }

  Future<FieldTask> create(TaskInput input) async {
    final created = await _ref.read(tasksRepositoryProvider).createTask(input);
    _refresh();
    return created;
  }

  Future<FieldTask> update(int id, TaskInput input) async {
    final updated = await _ref
        .read(tasksRepositoryProvider)
        .updateTask(id, input);
    _refresh();
    return updated;
  }

  Future<void> delete(int id) async {
    await _ref.read(tasksRepositoryProvider).deleteTask(id);
    _refresh();
  }

  void _refresh() {
    _ref.invalidate(mapClientsProvider);
    _ref.invalidate(taskSummaryProvider);
    _ref.invalidate(openTasksProvider);
    _ref.invalidate(agendaTasksProvider);
    _ref.invalidate(clientTasksProvider);
    _ref.invalidate(taskDetailProvider);
  }
}

final taskActionsProvider = Provider<TaskActions>((ref) => TaskActions(ref));
