import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required UserInfo user,
    required List<CompanyInfo> companies,
    required int activeCompanyId,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class RefreshResponse with _$RefreshResponse {
  const factory RefreshResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) = _RefreshResponse;

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseFromJson(json);
}

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required int id,
    required String name,
    required String email,
    @Default('') String role,
    @Default([]) List<String> permissions,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

@freezed
class CompanyInfo with _$CompanyInfo {
  const factory CompanyInfo({
    required int id,
    required String name,
    @Default('') String role,
  }) = _CompanyInfo;

  factory CompanyInfo.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoFromJson(json);
}

@freezed
class SwitchCompanyResponse with _$SwitchCompanyResponse {
  const factory SwitchCompanyResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required int activeCompanyId,
  }) = _SwitchCompanyResponse;

  factory SwitchCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$SwitchCompanyResponseFromJson(json);
}
