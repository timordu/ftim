// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_friend_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimFriendResult _$TimFriendResultFromJson(Map<String, dynamic> json) {
  return TimFriendResult(json['identifier'] as String,
      json['resultCode'] as int, json['resultInfo'] as String);
}

Map<String, dynamic> _$TimFriendResultToJson(TimFriendResult instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'resultCode': instance.resultCode,
      'resultInfo': instance.resultInfo
    };
