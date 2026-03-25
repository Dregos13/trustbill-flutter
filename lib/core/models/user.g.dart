// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      companies: (json['companies'] as List<dynamic>)
          .map((e) => CompanyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeCompanyId: (json['activeCompanyId'] as num).toInt(),
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
      'companies': instance.companies,
      'activeCompanyId': instance.activeCompanyId,
    };

_$RefreshResponseImpl _$$RefreshResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RefreshResponseImpl(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: (json['expiresIn'] as num).toInt(),
);

Map<String, dynamic> _$$RefreshResponseImplToJson(
  _$RefreshResponseImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
};

_$UserInfoImpl _$$UserInfoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String? ?? '',
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserInfoImplToJson(_$UserInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'permissions': instance.permissions,
    };

_$CompanyInfoImpl _$$CompanyInfoImplFromJson(Map<String, dynamic> json) =>
    _$CompanyInfoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      role: json['role'] as String? ?? '',
    );

Map<String, dynamic> _$$CompanyInfoImplToJson(_$CompanyInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
    };

_$SwitchCompanyResponseImpl _$$SwitchCompanyResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SwitchCompanyResponseImpl(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: (json['expiresIn'] as num).toInt(),
  activeCompanyId: (json['activeCompanyId'] as num).toInt(),
);

Map<String, dynamic> _$$SwitchCompanyResponseImplToJson(
  _$SwitchCompanyResponseImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
  'activeCompanyId': instance.activeCompanyId,
};
