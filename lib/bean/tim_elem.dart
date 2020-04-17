import 'package:json_annotation/json_annotation.dart';

part 'tim_elem.g.dart';

@JsonSerializable()
class TimElem extends Object {
  @JsonKey(name: 'type')
  String type;

  TimElem(this.type);

  factory TimElem.fromJson(Map<String, dynamic> srcJson) => _$TimElemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimElemToJson(this);
}

@JsonSerializable()
class TimTextElem extends TimElem {
  @JsonKey(name: 'text')
  String text;

  TimTextElem(String type, this.text) : super(type);

  factory TimTextElem.fromJson(Map<String, dynamic> srcJson) => _$TimTextElemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimTextElemToJson(this);
}

@JsonSerializable()
class TimImageElem extends TimElem {
  @JsonKey(name: 'path')
  String path;

  @JsonKey(name: 'imageList')
  List<TimImage> imageList;

  TimImageElem(String type, this.path, this.imageList) : super(type);

  factory TimImageElem.fromJson(Map<String, dynamic> srcJson) => _$TimImageElemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimImageElemToJson(this);
}

@JsonSerializable()
class TimImage extends Object {
  @JsonKey(name: 'height')
  int height;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'width')
  int width;

  TimImage(this.height, this.size, this.type, this.url, this.uuid, this.width);

  factory TimImage.fromJson(Map<String, dynamic> srcJson) => _$TimImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimImageToJson(this);
}
