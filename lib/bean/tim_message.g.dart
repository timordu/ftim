// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimMessage _$TimMessageFromJson(Map<String, dynamic> json) {
  return TimMessage(
      json['type'] as String,
      json['peer'] as String,
      json['msgId'] as String,
      json['msgUniqueId'] as int,
      json['sender'] == null
          ? null
          : TimUserProfile.fromJson(json['sender'] as Map<String, dynamic>),
      json['isSelf'] as bool,
      json['msgTime'] as int,
      json['isPeerReaded'] as bool,
      json['element'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TimMessageToJson(TimMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'peer': instance.peer,
      'msgId': instance.msgId,
      'msgUniqueId': instance.msgUniqueId,
      'sender': instance.sender,
      'isSelf': instance.isSelf,
      'msgTime': instance.msgTime,
      'isPeerReaded': instance.isPeerReaded,
      'element': instance.element
    };
