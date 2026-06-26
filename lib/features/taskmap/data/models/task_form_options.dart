import 'task_status.dart';

/// A selectable client in the task form's client picker (id/name/coords).
/// Distinct from [MapClient]: this lists *every* client, not only those with
/// tasks, and carries no per-status counts.
class TaskClientOption {
  const TaskClientOption({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
  });

  final int id;
  final String name;
  final double? latitude;
  final double? longitude;

  bool get hasLocation => latitude != null && longitude != null;

  TaskClientOption copyWith({double? latitude, double? longitude}) =>
      TaskClientOption(
        id: id,
        name: name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory TaskClientOption.fromJson(Map<String, dynamic> json) =>
      TaskClientOption(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String? ?? '',
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
      );
}

/// A company member assignable to a task.
class AssignableUser {
  const AssignableUser({required this.id, required this.name});

  final int id;
  final String name;

  factory AssignableUser.fromJson(Map<String, dynamic> json) => AssignableUser(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String? ?? '',
  );
}

/// An invoice option for the task form's bill picker. `total` arrives as a
/// 2-decimal string from the serializer; we keep it as num for display.
class InvoiceOption {
  const InvoiceOption({
    required this.id,
    required this.number,
    required this.status,
    required this.total,
  });

  final int id;
  final String number;
  final String status;
  final num total;

  factory InvoiceOption.fromJson(Map<String, dynamic> json) => InvoiceOption(
    id: (json['id'] as num).toInt(),
    number: json['number'] as String? ?? '',
    status: json['status'] as String? ?? '',
    total: (json['total'] as num?) ?? num.tryParse('${json['total']}') ?? 0,
  );
}

/// Payload for creating or fully updating a task. Mirrors the API
/// create/update schemas one-to-one.
class TaskInput {
  const TaskInput({
    required this.title,
    required this.clientId,
    this.documentId,
    this.status = TaskStatus.pending,
    this.scheduledAt,
    this.notes,
    this.assignedToId,
  });

  final String title;
  final int clientId;
  final int? documentId;
  final TaskStatus status;
  final DateTime? scheduledAt;
  final String? notes;
  final int? assignedToId;

  /// JSON body. Nullable fields are always emitted (explicit null clears them
  /// server-side on update; ignored harmlessly on create).
  Map<String, dynamic> toJson() => {
    'title': title,
    'clientId': clientId,
    'documentId': documentId,
    'status': status.api,
    'scheduledAt': scheduledAt?.toUtc().toIso8601String(),
    'notes': (notes != null && notes!.isEmpty) ? null : notes,
    'assignedToId': assignedToId,
  };
}
