// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_friend_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimFriendGroup _$TimFriendGroupFromJson(Map<String, dynamic> json) {
  return TimFriendGroup(json['name'] as String, json['userCnt'] as int,
      (json['friends'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$TimFriendGroupToJson(TimFriendGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userCnt': instance.userCnt,
      'friends': instance.friends
    };
