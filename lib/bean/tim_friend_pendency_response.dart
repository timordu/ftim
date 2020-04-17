import 'package:json_annotation/json_annotation.dart';

part 'tim_friend_pendency_response.g.dart';

@JsonSerializable()
class TimFriendPendencyResponse extends Object {
  @JsonKey(name: 'items')
  List<TimFriendPendencyItem> items;

  @JsonKey(name: 'seq')
  int seq;

  @JsonKey(name: 'timestamp')
  int timestamp;

  @JsonKey(name: 'unreadCnt')
  int unreadCnt;

  TimFriendPendencyResponse(
    this.items,
    this.seq,
    this.timestamp,
    this.unreadCnt,
  );

  factory TimFriendPendencyResponse.fromJson(Map<String, dynamic> srcJson) => _$TimFriendPendencyResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendPendencyResponseToJson(this);
}

@JsonSerializable()
class TimFriendPendencyItem extends Object {
  @JsonKey(name: 'addSource')
  String addSource;

  @JsonKey(name: 'addTime')
  int addTime;

  @JsonKey(name: 'addWording')
  String addWording;

  @JsonKey(name: 'identifier')
  String identifier;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'type')
  int type;

  TimFriendPendencyItem(
    this.addSource,
    this.addTime,
    this.addWording,
    this.identifier,
    this.nickname,
    this.type,
  );

  factory TimFriendPendencyItem.fromJson(Map<String, dynamic> srcJson) => _$TimFriendPendencyItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendPendencyItemToJson(this);
}

List<TimFriendPendencyItem> getTimFriendPendencyItemList(List<dynamic> list) {
  List<TimFriendPendencyItem> result = [];
  list.forEach((item) {
    result.add(TimFriendPendencyItem.fromJson(item));
  });
  return result;
}
