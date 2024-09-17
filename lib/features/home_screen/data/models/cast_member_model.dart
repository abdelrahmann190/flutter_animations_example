import 'package:json_annotation/json_annotation.dart';

part 'cast_member_model.g.dart';

@JsonSerializable()
class CastMemberModel {
  final bool? adult;
  final int? gender;
  final int? id;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final String? name;
  @JsonKey(name: 'original_name')
  final String? originalName;
  final double? popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @JsonKey(name: 'cast_id')
  final int? castId;
  final String? character;
  @JsonKey(name: 'credit_id')
  final String? creditId;
  final int? order;

  CastMemberModel({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  // A factory constructor to create an instance of CastMember from a JSON object.
  factory CastMemberModel.fromJson(Map<String, dynamic> json) =>
      _$CastMemberModelFromJson(json);

  // A method to convert the CastMember instance into a JSON object.
  Map<String, dynamic> toJson() => _$CastMemberModelToJson(this);
}
