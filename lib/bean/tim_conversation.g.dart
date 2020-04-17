// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimConversation _$TimConversationFromJson(Map<String, dynamic> json) {
  return TimConversation(
      json['peer'] as String,
      json['type'] as String,
      json['lastMsg'] == null
          ? null
          : TimMessage.fromJson(json['lastMsg'] as Map<String, dynamic>),
      json['unRead'] as int,
      json['faceUrl'] as String,
      json['title'] as String);
}

Map<String, dynamic> _$TimConversationToJson(TimConversation instance) =>
    <String, dynamic>{
      'peer': instance.peer,
      'type': instance.type,
      'faceUrl': instance.faceUrl,
      'title': instance.title,
      'lastMsg': instance.lastMsg,
      'unRead': instance.unRead
    };
