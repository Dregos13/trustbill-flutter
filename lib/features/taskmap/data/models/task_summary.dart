/// Aggregate task counts by status (dashboard header).
class TaskSummary {
  const TaskSummary({
    this.pending = 0,
    this.inProgress = 0,
    this.done = 0,
    this.cancelled = 0,
  });

  final int pending;
  final int inProgress;
  final int done;
  final int cancelled;

  int get open => pending + inProgress;
  int get total => pending + inProgress + done + cancelled;

  factory TaskSummary.fromJson(Map<String, dynamic> json) => TaskSummary(
    pending: (json['pending'] as num?)?.toInt() ?? 0,
    inProgress: (json['inProgress'] as num?)?.toInt() ?? 0,
    done: (json['done'] as num?)?.toInt() ?? 0,
    cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
  );
}
