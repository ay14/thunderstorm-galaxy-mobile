import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserRole { customer, store_owner, partner, admin }

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.companyId,
    required this.onboardingCompleted,
    this.emailVerifiedAt,
  });

  final int id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  @JsonKey(name: 'company_id')
  final int? companyId;
  @JsonKey(name: 'onboarding_completed')
  final bool onboardingCompleted;
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
