import 'package:json_annotation/json_annotation.dart';
import 'package:ftim/bean/bean.dart';

part 'tim_conversation.g.dart';

@JsonSerializable()
class TimConversation extends Object {
  static const String TYPE_INVALID = 'Invalid';
  static const String TYPE_C2C = 'C2C';
  static const String TYPE_GROUP = 'Group';
  static const String TYPE_SYSTEM = 'System';

  @JsonKey(name: 'peer')
  String peer;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'faceUrl')
  String faceUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'lastMsg')
  TimMessage lastMsg;

  @JsonKey(name: 'unRead')
  int unRead;

  TimConversation(this.peer, this.type, this.lastMsg, this.unRead, this.faceUrl, this.title);

  factory TimConversation.fromJson(Map<String, dynamic> srcJson) => _$TimConversationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimConversationToJson(this);
}

List<TimConversation> getTimConversationList(List<dynamic> list) {
  List<TimConversation> result = [];
  list.forEach((item) {
    result.add(TimConversation.fromJson(item));
  });
  return result;
}
