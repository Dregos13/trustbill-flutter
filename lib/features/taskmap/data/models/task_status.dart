import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Field-job lifecycle, mirroring the API `TaskStatus` enum.
enum TaskStatus {
  pending,
  inProgress,
  done,
  cancelled;

  static TaskStatus fromApi(String raw) {
    switch (raw.toUpperCase()) {
      case 'IN_PROGRESS':
        return TaskStatus.inProgress;
      case 'DONE':
        return TaskStatus.done;
      case 'CANCELLED':
        return TaskStatus.cancelled;
      case 'PENDING':
      default:
        return TaskStatus.pending;
    }
  }

  String get api => switch (this) {
    TaskStatus.pending => 'PENDING',
    TaskStatus.inProgress => 'IN_PROGRESS',
    TaskStatus.done => 'DONE',
    TaskStatus.cancelled => 'CANCELLED',
  };

  String get label => switch (this) {
    TaskStatus.pending => 'Pendiente',
    TaskStatus.inProgress => 'En curso',
    TaskStatus.done => 'Completada',
    TaskStatus.cancelled => 'Cancelada',
  };

  Color get color => switch (this) {
    TaskStatus.pending => AppColors.statusPending,
    TaskStatus.inProgress => AppColors.statusInProgress,
    TaskStatus.done => AppColors.statusDone,
    TaskStatus.cancelled => AppColors.statusCancelled,
  };

  IconData get icon => switch (this) {
    TaskStatus.pending => Icons.schedule_rounded,
    TaskStatus.inProgress => Icons.bolt_rounded,
    TaskStatus.done => Icons.check_circle_rounded,
    TaskStatus.cancelled => Icons.cancel_rounded,
  };

  bool get isOpen =>
      this == TaskStatus.pending || this == TaskStatus.inProgress;

  /// The next status for the primary "advance" action (null = terminal).
  TaskStatus? get nextStatus => switch (this) {
    TaskStatus.pending => TaskStatus.inProgress,
    TaskStatus.inProgress => TaskStatus.done,
    _ => null,
  };

  /// Label for the advance action.
  String? get advanceLabel => switch (this) {
    TaskStatus.pending => 'Empezar',
    TaskStatus.inProgress => 'Completar',
    _ => null,
  };
}
