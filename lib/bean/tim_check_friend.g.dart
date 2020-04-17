// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_check_friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimCheckFriend _$TimCheckFriendFromJson(Map<String, dynamic> json) {
  return TimCheckFriend(json['identifier'] as String, json['resultCode'] as int,
      json['resultInfo'] as String, json['resultType'] as int);
}

Map<String, dynamic> _$TimCheckFriendToJson(TimCheckFriend instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'resultCode': instance.resultCode,
      'resultInfo': instance.resultInfo,
      'resultType': instance.resultType
    };
