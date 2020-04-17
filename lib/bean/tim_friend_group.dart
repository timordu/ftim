import 'package:json_annotation/json_annotation.dart';

part 'tim_friend_group.g.dart';

@JsonSerializable()
class TimFriendGroup extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'userCnt')
  int userCnt;

  @JsonKey(name: 'friends')
  List<String> friends;

  TimFriendGroup(
    this.name,
    this.userCnt,
    this.friends,
  );

  factory TimFriendGroup.fromJson(Map<String, dynamic> srcJson) => _$TimFriendGroupFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendGroupToJson(this);
}

List<TimFriendGroup> getTimFriendGroupList(List<dynamic> list) {
  List<TimFriendGroup> result = [];
  list.forEach((item) {
    result.add(TimFriendGroup.fromJson(item));
  });
  return result;
}
