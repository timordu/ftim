import 'package:json_annotation/json_annotation.dart';

part 'tim_user_profile.g.dart';

@JsonSerializable()
class TimUserProfile extends Object {
  static const String TIM_FRIEND_INVALID = "AllowType_Type_Invalid";
  static const String TIM_FRIEND_ALLOW_ANY = "AllowType_Type_AllowAny";
  static const String TIM_FRIEND_DENY_ANY = "AllowType_Type_DenyAny";
  static const String TIM_FRIEND_NEED_CONFIRM = "AllowType_Type_NeedConfirm";

  @JsonKey(name: 'allowType')
  String allowType;

  @JsonKey(name: 'birthday')
  int birthday;

  @JsonKey(name: 'customInfo')
  Map<String, List<int>> customInfo;

  @JsonKey(name: 'customInfoUint')
  Map<String, int> customInfoUint;

  @JsonKey(name: 'faceUrl')
  String faceUrl;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'identifier')
  String identifier;

  @JsonKey(name: 'language')
  int language;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'role')
  int role;

  @JsonKey(name: 'selfSignature')
  String selfSignature;

  /// @param nickName 昵称
  ///
  /// @param faceurl 头像
  ///
  /// @param gender 性别 0-保密 1-男 2-女
  ///
  /// @param birthday 生日 精确到秒
  ///
  /// @param selfSignature 签名
  ///
  /// @param allowtype 好友申请
  ///
  /// @param location 位置
  ///
  /// @param language 语言
  ///
  /// @param level 等级
  ///
  /// @param role 角色
  ///
  /// @param customInfo 自定义字段
  TimUserProfile({
    this.nickName,
    this.faceUrl,
    this.gender,
    this.birthday,
    this.selfSignature,
    this.allowType,
    this.identifier,
    this.language,
    this.level,
    this.location,
    this.role,
    this.customInfo,
    this.customInfoUint,
  });

  factory TimUserProfile.fromJson(Map<String, dynamic> srcJson) => _$TimUserProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimUserProfileToJson(this);
}

List<TimUserProfile> getTimUserProfileList(List<dynamic> list) {
  List<TimUserProfile> result = [];
  list.forEach((item) {
    result.add(TimUserProfile.fromJson(item));
  });
  return result;
}
