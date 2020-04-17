// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimFriend _$TimFriendFromJson(Map<String, dynamic> json) {
  return TimFriend(
      json['identifier'] as String,
      json['remark'] as String,
      json['addWording'] as String,
      json['addSource'] as String,
      json['addTime'] as int,
      (json['groupNames'] as List)?.map((e) => e as String)?.toList(),
      json['timUserProfile'] == null
          ? null
          : TimUserProfile.fromJson(
              json['timUserProfile'] as Map<String, dynamic>),
      (json['customInfo'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, (e as List)?.map((e) => e as int)?.toList()),
      ),
      (json['customInfoUint'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as int),
      ));
}

Map<String, dynamic> _$TimFriendToJson(TimFriend instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'remark': instance.remark,
      'addWording': instance.addWording,
      'addSource': instance.addSource,
      'addTime': instance.addTime,
      'groupNames': instance.groupNames,
      'timUserProfile': instance.timUserProfile,
      'customInfo': instance.customInfo,
      'customInfoUint': instance.customInfoUint
    };
