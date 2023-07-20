// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersInfo _$UsersInfoFromJson(Map<String, dynamic> json) => UsersInfo(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UsersInfoToJson(UsersInfo instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'email': instance.email,
    };

Exhibition _$ExhibitionFromJson(Map<String, dynamic> json) => Exhibition(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ExhibitionToJson(Exhibition instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
