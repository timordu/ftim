import 'package:json_annotation/json_annotation.dart';
import 'package:ftim_example/export.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact extends ISuspensionBean {
  @JsonKey(name: 'tagIndex')
  String tagIndex;

  @JsonKey(name: 'userInfo')
  TimFriend userInfo;

  Contact({this.tagIndex, this.userInfo});

  factory Contact.fromJson(Map<String, dynamic> srcJson) => _$ContactFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  String getSuspensionTag() => tagIndex;
}
