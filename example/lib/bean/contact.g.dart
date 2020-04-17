// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
      tagIndex: json['tagIndex'] as String,
      userInfo: json['userInfo'] == null
          ? null
          : TimFriend.fromJson(json['userInfo'] as Map<String, dynamic>))
    ..isShowSuspension = json['isShowSuspension'] as bool;
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'tagIndex': instance.tagIndex,
      'userInfo': instance.userInfo
    };
