import 'package:json_annotation/json_annotation.dart';
import 'package:ftim/bean/bean.dart';

part 'tim_message.g.dart';

@JsonSerializable()
class TimMessage extends Object {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'peer')
  String peer;

  @JsonKey(name: 'msgId')
  String msgId;

  @JsonKey(name: 'msgUniqueId')
  int msgUniqueId;

  @JsonKey(name: 'sender')
  TimUserProfile sender;

  @JsonKey(name: 'isSelf')
  bool isSelf;

  @JsonKey(name: 'msgTime')
  int msgTime;

  @JsonKey(name: 'isPeerReaded')
  bool isPeerReaded;

  @JsonKey(name: 'element')
  Map element;

  TimMessage(this.type, this.peer, this.msgId, this.msgUniqueId, this.sender, this.isSelf, this.msgTime, this.isPeerReaded, this.element);

  factory TimMessage.fromJson(Map<String, dynamic> srcJson) => _$TimMessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimMessageToJson(this);
}

List<TimMessage> getTimMessageList(List<dynamic> list) {
  List<TimMessage> result = [];
  list.forEach((item) {
    result.add(TimMessage.fromJson(item));
  });
  return result;
}
