/// Model for a company user returned by GET /users and GET /users/:id
class UserWithPermissions {
  final int id;
  final String name;
  final String email;
  final String role;
  final bool isActive;
  final List<String> permissions;

  const UserWithPermissions({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.permissions,
  });

  factory UserWithPermissions.fromJson(Map<String, dynamic> json) {
    return UserWithPermissions(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String? ?? 'user',
      isActive: json['isActive'] as bool? ?? true,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// Whether this user's permissions are managed by role (not editable).
  bool get hasImplicitPermissions =>
      role == 'admin' || role == 'superadmin';
}
