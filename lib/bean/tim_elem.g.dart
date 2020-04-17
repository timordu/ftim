// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tim_elem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimElem _$TimElemFromJson(Map<String, dynamic> json) {
  return TimElem(json['type'] as String);
}

Map<String, dynamic> _$TimElemToJson(TimElem instance) => <String, dynamic>{'type': instance.type};

TimTextElem _$TimTextElemFromJson(Map<String, dynamic> json) {
  return TimTextElem(json['type'] as String, json['text'] as String);
}

Map<String, dynamic> _$TimTextElemToJson(TimTextElem instance) => <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
    };

TimImageElem _$TimImageElemFromJson(Map<String, dynamic> json) {
  return TimImageElem(
    json['type'] as String,
    json['path'] as String,
    (json['imageList'] as List)?.map((e) => e == null ? null : TimImage.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$TimImageElemToJson(TimImageElem instance) => <String, dynamic>{
      'type': instance.type,
      'path': instance.path,
      'imageList': instance.imageList,
    };

TimImage _$TimImageFromJson(Map<String, dynamic> json) {
  return TimImage(
    json['height'] as int,
    json['size'] as int,
    json['type'] as String,
    json['url'] as String,
    json['uuid'] as String,
    json['width'] as int,
  );
}

Map<String, dynamic> _$TimImageToJson(TimImage instance) => <String, dynamic>{
      'height': instance.height,
      'size': instance.size,
      'type': instance.type,
      'url': instance.url,
      'uuid': instance.uuid,
      'width': instance.width,
    };
