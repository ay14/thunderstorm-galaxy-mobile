// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      logoUrl: json['logo_url'] as String?,
      category: json['category'] as String,
      website: json['website'] as String?,
      registrationNumber: json['registration_number'] as String?,
      isVerified: json['is_verified'] as bool,
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'logo_url': instance.logoUrl,
      'category': instance.category,
      'website': instance.website,
      'registration_number': instance.registrationNumber,
      'is_verified': instance.isVerified,
    };
