import 'package:json_annotation/json_annotation.dart';
import 'package:ftim/bean/bean.dart';

part 'tim_friend.g.dart';

@JsonSerializable()
class TimFriend extends Object {
  @JsonKey(name: 'identifier')
  String identifier;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'addWording')
  String addWording;

  @JsonKey(name: 'addSource')
  String addSource;

  @JsonKey(name: 'addTime')
  int addTime;

  @JsonKey(name: 'groupNames')
  List<String> groupNames;

  @JsonKey(name: 'timUserProfile')
  TimUserProfile timUserProfile;

  @JsonKey(name: 'customInfo')
   Map<String, List<int>>  customInfo;

  @JsonKey(name: 'customInfoUint')
   Map<String, int>  customInfoUint;

  TimFriend(
    this.identifier,
    this.remark,
    this.addWording,
    this.addSource,
    this.addTime,
    this.groupNames,
    this.timUserProfile,
    this.customInfo,
    this.customInfoUint,
  );

  factory TimFriend.fromJson(Map<String, dynamic> srcJson) => _$TimFriendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendToJson(this);
}

List<TimFriend> getTimFriendList(List<dynamic> list) {
  List<TimFriend> result = [];
  list.forEach((item) {
    result.add(TimFriend.fromJson(item));
  });
  return result;
}
