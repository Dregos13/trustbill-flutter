import 'task_status.dart';
import 'bill.dart';

DateTime? _date(dynamic value) =>
    value == null ? null : DateTime.tryParse(value as String);

/// The client a task pins to (name + optional coordinates).
class ClientRef {
  const ClientRef({
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

  factory ClientRef.fromJson(Map<String, dynamic> json) => ClientRef(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String? ?? '',
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

/// A field job. Used for both list rows and detail; `notes`/`assignedToId` and
/// `bill.lines` are populated only by the detail endpoint.
class FieldTask {
  const FieldTask({
    required this.id,
    required this.title,
    required this.status,
    required this.client,
    this.scheduledAt,
    this.startedAt,
    this.completedAt,
    this.notes,
    this.assignedToId,
    this.bill,
  });

  final int id;
  final String title;
  final TaskStatus status;
  final ClientRef client;
  final DateTime? scheduledAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? notes;
  final int? assignedToId;
  final BillSummary? bill;

  factory FieldTask.fromJson(Map<String, dynamic> json) => FieldTask(
    id: (json['id'] as num).toInt(),
    title: json['title'] as String? ?? '',
    status: TaskStatus.fromApi(json['status'] as String? ?? 'PENDING'),
    client: ClientRef.fromJson(json['client'] as Map<String, dynamic>),
    scheduledAt: _date(json['scheduledAt']),
    startedAt: _date(json['startedAt']),
    completedAt: _date(json['completedAt']),
    notes: json['notes'] as String?,
    assignedToId: (json['assignedToId'] as num?)?.toInt(),
    bill: json['bill'] == null
        ? null
        : BillSummary.fromJson(json['bill'] as Map<String, dynamic>),
  );
}
