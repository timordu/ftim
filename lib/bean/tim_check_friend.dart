import 'package:json_annotation/json_annotation.dart';

part 'tim_check_friend.g.dart';

@JsonSerializable()
class TimCheckFriend extends Object {
  @JsonKey(name: 'identifier')
  String identifier;

  @JsonKey(name: 'resultCode')
  int resultCode;

  @JsonKey(name: 'resultInfo')
  String resultInfo;

  @JsonKey(name: 'resultType')
  int resultType;

  /// @param resultType 0-不是好友 1-在我的好友列表中 2-在对方好友列表中 3-互为好友
  TimCheckFriend(
    this.identifier,
    this.resultCode,
    this.resultInfo,
    this.resultType,
  );

  factory TimCheckFriend.fromJson(Map<String, dynamic> srcJson) => _$TimCheckFriendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimCheckFriendToJson(this);

  String getResultType() {
    switch (resultType) {
      case 1:
        return '对方在我的好友列表中';
        break;
      case 2:
        return '我在对方的好友列表中';
        break;
      case 3:
        return '互为好友';
        break;
      default:
        return '不是好友';
    }
  }
}

List<TimCheckFriend> getTimCheckFriendList(List<dynamic> list) {
  List<TimCheckFriend> result = [];
  list.forEach((item) {
    result.add(TimCheckFriend.fromJson(item));
  });
  return result;
}
