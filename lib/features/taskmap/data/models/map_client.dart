import 'task_status.dart';

/// Per-status task counts for a client pin.
class StatusCounts {
  const StatusCounts({
    this.pending = 0,
    this.inProgress = 0,
    this.done = 0,
    this.cancelled = 0,
  });

  final int pending;
  final int inProgress;
  final int done;
  final int cancelled;

  int get total => pending + inProgress + done + cancelled;
  int get open => pending + inProgress;

  int forStatus(TaskStatus s) => switch (s) {
    TaskStatus.pending => pending,
    TaskStatus.inProgress => inProgress,
    TaskStatus.done => done,
    TaskStatus.cancelled => cancelled,
  };

  /// The most "urgent" status with at least one task, used to color the pin.
  TaskStatus get dominantStatus {
    if (inProgress > 0) return TaskStatus.inProgress;
    if (pending > 0) return TaskStatus.pending;
    if (done > 0) return TaskStatus.done;
    return TaskStatus.cancelled;
  }

  factory StatusCounts.fromJson(Map<String, dynamic> json) => StatusCounts(
    pending: (json['pending'] as num?)?.toInt() ?? 0,
    inProgress: (json['inProgress'] as num?)?.toInt() ?? 0,
    done: (json['done'] as num?)?.toInt() ?? 0,
    cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
  );
}

/// A client rendered as a pin: coordinates + aggregated task counts.
class MapClient {
  const MapClient({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.counts,
  });

  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final StatusCounts counts;

  factory MapClient.fromJson(Map<String, dynamic> json) => MapClient(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String? ?? '',
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    counts: StatusCounts.fromJson(
      (json['counts'] as Map?)?.cast<String, dynamic>() ?? const {},
    ),
  );
}
