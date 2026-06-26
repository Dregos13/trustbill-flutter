// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      companies: (json['companies'] as List<dynamic>)
          .map((e) => CompanyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeCompanyId: (json['activeCompanyId'] as num).toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
      'companies': instance.companies,
      'activeCompanyId': instance.activeCompanyId,
    };

_RefreshResponse _$RefreshResponseFromJson(Map<String, dynamic> json) =>
    _RefreshResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      companies:
          (json['companies'] as List<dynamic>?)
              ?.map((e) => CompanyInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activeCompanyId: (json['activeCompanyId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RefreshResponseToJson(_RefreshResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
      'companies': instance.companies,
      'activeCompanyId': instance.activeCompanyId,
    };

_UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => _UserInfo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String? ?? '',
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  modules:
      (json['modules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$UserInfoToJson(_UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
  'permissions': instance.permissions,
  'modules': instance.modules,
};

_CompanyInfo _$CompanyInfoFromJson(Map<String, dynamic> json) => _CompanyInfo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  role: json['role'] as String? ?? '',
);

Map<String, dynamic> _$CompanyInfoToJson(_CompanyInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
    };

_SwitchCompanyResponse _$SwitchCompanyResponseFromJson(
  Map<String, dynamic> json,
) => _SwitchCompanyResponse(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: (json['expiresIn'] as num).toInt(),
  activeCompanyId: (json['activeCompanyId'] as num).toInt(),
);

Map<String, dynamic> _$SwitchCompanyResponseToJson(
  _SwitchCompanyResponse instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
  'activeCompanyId': instance.activeCompanyId,
};
