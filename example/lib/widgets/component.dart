import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftim_example/export.dart';

class Avatar {
  Avatar._();

  static Widget builder(String url, {double width = 40}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => Image.asset(FileUtil.loadImage('avatar.png')),
            errorWidget: (context, url, error) => Image.asset(FileUtil.loadImage('avatar.png')),
            imageBuilder: (context, imageProvider) => Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                )));
  }
}
