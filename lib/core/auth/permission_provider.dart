import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'auth_state.dart';

/// The current user's permissions as a [Set] — O(1) lookup.
/// Returns empty set when not authenticated.
final permissionsProvider = Provider<Set<String>>((ref) {
  final auth = ref.watch(authProvider);
  if (auth is AuthAuthenticated) {
    return auth.user.permissions.toSet();
  }
  return const {};
});

/// Returns true if the authenticated user has [permissionKey].
/// Also matches wildcard permissions like "clients.*".
final hasPermissionProvider = Provider.family<bool, String>((ref, permissionKey) {
  final perms = ref.watch(permissionsProvider);
  final category = permissionKey.split('.').first;
  return perms.contains(permissionKey) || perms.contains('$category.*');
});

/// Returns true if the user has the 'superadmin' role.
final isSuperadminProvider = Provider<bool>((ref) {
  final auth = ref.watch(authProvider);
  if (auth is AuthAuthenticated) return auth.user.role == 'superadmin';
  return false;
});

/// Returns true if the user has the 'admin' or 'superadmin' role.
final isAdminOrAboveProvider = Provider<bool>((ref) {
  final auth = ref.watch(authProvider);
  if (auth is AuthAuthenticated) {
    return auth.user.role == 'admin' || auth.user.role == 'superadmin';
  }
  return false;
});
