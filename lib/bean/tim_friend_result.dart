import 'package:json_annotation/json_annotation.dart';

part 'tim_friend_result.g.dart';

@JsonSerializable()
class TimFriendResult extends Object {
  @JsonKey(name: 'identifier')
  String identifier;

  @JsonKey(name: 'resultCode')
  int resultCode;

  @JsonKey(name: 'resultInfo')
  String resultInfo;

  TimFriendResult(
    this.identifier,
    this.resultCode,
    this.resultInfo,
  );

  factory TimFriendResult.fromJson(Map<String, dynamic> srcJson) => _$TimFriendResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimFriendResultToJson(this);
}

List<TimFriendResult> getTimFriendResultList(List<dynamic> list) {
  List<TimFriendResult> result = [];
  list.forEach((item) {
    result.add(TimFriendResult.fromJson(item));
  });
  return result;
}
