import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/auth/permission_provider.dart';

/// Renders [child] only when the current user has [permission].
/// Shows [fallback] (defaults to [SizedBox.shrink]) when access is denied.
///
/// Usage:
/// ```dart
/// PermissionGate(
///   permission: Permissions.clientsWrite,
///   child: ElevatedButton(onPressed: _create, child: Text('Nuevo')),
/// )
/// ```
class PermissionGate extends ConsumerWidget {
  final String permission;
  final Widget child;
  final Widget? fallback;

  const PermissionGate({
    super.key,
    required this.permission,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final has = ref.watch(hasPermissionProvider(permission));
    if (has) return child;
    return fallback ?? const SizedBox.shrink();
  }
}
