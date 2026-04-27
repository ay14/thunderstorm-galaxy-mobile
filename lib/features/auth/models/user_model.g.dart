// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      companyId: (json['company_id'] as num?)?.toInt(),
      onboardingCompleted: json['onboarding_completed'] as bool,
      emailVerifiedAt: json['email_verified_at'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'company_id': instance.companyId,
      'onboarding_completed': instance.onboardingCompleted,
      'email_verified_at': instance.emailVerifiedAt,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.store_owner: 'store_owner',
  UserRole.partner: 'partner',
  UserRole.admin: 'admin',
};
