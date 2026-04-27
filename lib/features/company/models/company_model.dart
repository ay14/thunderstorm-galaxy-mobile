import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel {
  const CompanyModel({
    required this.id,
    required this.name,
    required this.slug,
    this.logoUrl,
    required this.category,
    this.website,
    this.registrationNumber,
    required this.isVerified,
  });

  final int id;
  final String name;
  final String slug;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  final String category;
  final String? website;
  @JsonKey(name: 'registration_number')
  final String? registrationNumber;
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
