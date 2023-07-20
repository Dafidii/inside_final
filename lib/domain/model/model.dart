import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class UsersInfo {
  @JsonKey(name: 'uid')
  String uid;
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'email')
  String email;

  UsersInfo(
      {required this.uid,
        required this.username,
      required this.email,});

  factory UsersInfo.fromJson(Map<String, dynamic> json) =>
      _$UsersInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UsersInfoToJson(this);
}

@JsonSerializable()
class Exhibition {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'image')
  String image;

  Exhibition(
      {required this.title,
        required this.description,
        required this.image,});

  factory Exhibition.fromJson(Map<String, dynamic> json) =>
      _$ExhibitionFromJson(json);

  Map<String, dynamic> toJson() => _$ExhibitionToJson(this);
}