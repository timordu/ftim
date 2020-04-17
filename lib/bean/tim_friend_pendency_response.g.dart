// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_friend_pendency_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimFriendPendencyResponse _$TimFriendPendencyResponseFromJson(
    Map<String, dynamic> json) {
  return TimFriendPendencyResponse(
      (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : TimFriendPendencyItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['seq'] as int,
      json['timestamp'] as int,
      json['unreadCnt'] as int);
}

Map<String, dynamic> _$TimFriendPendencyResponseToJson(
        TimFriendPendencyResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'seq': instance.seq,
      'timestamp': instance.timestamp,
      'unreadCnt': instance.unreadCnt
    };

TimFriendPendencyItem _$TimFriendPendencyItemFromJson(
    Map<String, dynamic> json) {
  return TimFriendPendencyItem(
      json['addSource'] as String,
      json['addTime'] as int,
      json['addWording'] as String,
      json['identifier'] as String,
      json['nickname'] as String,
      json['type'] as int);
}

Map<String, dynamic> _$TimFriendPendencyItemToJson(
        TimFriendPendencyItem instance) =>
    <String, dynamic>{
      'addSource': instance.addSource,
      'addTime': instance.addTime,
      'addWording': instance.addWording,
      'identifier': instance.identifier,
      'nickname': instance.nickname,
      'type': instance.type
    };
