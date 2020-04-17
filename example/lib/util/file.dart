import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FileUtil {
  ///根据fileName加载资源目录下的json
  ///
  /// @fileName 文件名称
  ///
  /// @path 默认目录assets/json
  static Future loadJson(String fileName, {String path = 'assets/json'}) async {
    return json.decode(await rootBundle.loadString('$path/$fileName'));
  }

  ///根据imageName加载资源目录下的Image
  ///
  /// @imageName 文件名称
  ///
  /// @path 默认目录assets/images
  static String loadImage(String imageName, {String path = 'assets/images'}) {
    return '$path/$imageName';
  }
}
