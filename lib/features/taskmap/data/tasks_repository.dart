import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import 'models/task_status.dart';
import 'models/field_task.dart';
import 'models/map_client.dart';
import 'models/task_form_options.dart';
import 'models/task_summary.dart';

/// Typed access to the taskmap endpoints on the mobile-api.
class TasksRepository {
  TasksRepository(this._api);

  final ApiClient _api;
  Dio get _dio => _api.dio;

  Future<({List<FieldTask> items, int total})> listTasks({
    List<TaskStatus>? status,
    int? clientId,
    String? search,
    String? bbox,
    int limit = 50,
    int offset = 0,
  }) async {
    final res = await _dio.get<dynamic>(
      '/tasks',
      queryParameters: {
        if (status != null && status.isNotEmpty)
          'status': status.map((s) => s.api).join(','),
        'clientId': ?clientId,
        if (search != null && search.isNotEmpty) 'search': search,
        'bbox': ?bbox,
        'limit': limit,
        'offset': offset,
      },
    );
    final data = res.data as Map;
    final items = (data['items'] as List)
        .map((e) => FieldTask.fromJson(e as Map<String, dynamic>))
        .toList();
    return (items: items, total: (data['total'] as num).toInt());
  }

  Future<FieldTask> getTask(int id) async {
    final res = await _dio.get<dynamic>('/tasks/$id');
    return FieldTask.fromJson(res.data as Map<String, dynamic>);
  }

  Future<FieldTask> updateStatus(int id, TaskStatus status) async {
    final res = await _dio.patch<dynamic>(
      '/tasks/$id/status',
      data: {'status': status.api},
    );
    return FieldTask.fromJson(res.data as Map<String, dynamic>);
  }

  Future<FieldTask> createTask(TaskInput input) async {
    final res = await _dio.post<dynamic>('/tasks', data: input.toJson());
    return FieldTask.fromJson(res.data as Map<String, dynamic>);
  }

  /// Full edit (title, client, invoice, assignee, status, schedule, notes).
  Future<FieldTask> updateTask(int id, TaskInput input) async {
    final res = await _dio.patch<dynamic>('/tasks/$id', data: input.toJson());
    return FieldTask.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteTask(int id) async {
    await _dio.delete<dynamic>('/tasks/$id');
  }

  // ── Form pickers (tasks.read) ───────────────────────────────────────────────

  Future<List<TaskClientOption>> formClients() async {
    final res = await _dio.get<dynamic>('/tasks/form/clients');
    return (res.data as List)
        .map((e) => TaskClientOption.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AssignableUser>> formUsers() async {
    final res = await _dio.get<dynamic>('/tasks/form/users');
    return (res.data as List)
        .map((e) => AssignableUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<InvoiceOption>> invoicesForClient(int clientId) async {
    final res = await _dio.get<dynamic>('/tasks/form/clients/$clientId/invoices');
    return (res.data as List)
        .map((e) => InvoiceOption.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<MapClient>> mapClients() async {
    final res = await _dio.get<dynamic>('/map/clients');
    return (res.data as List)
        .map((e) => MapClient.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TaskSummary> summary() async {
    final res = await _dio.get<dynamic>('/tasks/summary');
    return TaskSummary.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> updateClientLocation(
    int clientId,
    double latitude,
    double longitude,
  ) async {
    await _dio.patch<dynamic>(
      '/clients/$clientId/location',
      data: {'latitude': latitude, 'longitude': longitude},
    );
  }
}
