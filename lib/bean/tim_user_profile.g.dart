// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimUserProfile _$TimUserProfileFromJson(Map<String, dynamic> json) {
  return TimUserProfile(
      nickName: json['nickName'] as String,
      faceUrl: json['faceUrl'] as String,
      gender: json['gender'] as int,
      birthday: json['birthday'] as int,
      selfSignature: json['selfSignature'] as String,
      allowType: json['allowType'] as String,
      identifier: json['identifier'] as String,
      language: json['language'] as int,
      level: json['level'] as int,
      location: json['location'] as String,
      role: json['role'] as int,
      customInfo: (json['customInfo'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, (e as List)?.map((e) => e as int)?.toList()),
      ),
      customInfoUint: (json['customInfoUint'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as int),
      ));
}

Map<String, dynamic> _$TimUserProfileToJson(TimUserProfile instance) =>
    <String, dynamic>{
      'allowType': instance.allowType,
      'birthday': instance.birthday,
      'customInfo': instance.customInfo,
      'customInfoUint': instance.customInfoUint,
      'faceUrl': instance.faceUrl,
      'gender': instance.gender,
      'identifier': instance.identifier,
      'language': instance.language,
      'level': instance.level,
      'location': instance.location,
      'nickName': instance.nickName,
      'role': instance.role,
      'selfSignature': instance.selfSignature
    };
