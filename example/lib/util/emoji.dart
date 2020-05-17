import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

enum BuilderType { extendedText, extendedTextField }

class EmojiUtil {
  EmojiUtil._();

  final List<String> _emojiList = [
    '1f600',
    '1f601',
    '1f602',
    '1f603',
    '1f604',
    '1f605',
    '1f606',
    '1f607',
    '1f609',
    '1f60a',
    '1f60b',
    '1f60c',
    '1f60d',
    '1f60e',
    '1f60f',
    '1f610',
    '1f611',
    '1f612',
    '1f613',
    '1f614',
    '1f615',
    '1f616',
    '1f617',
    '1f618',
    '1f619',
    '1f61a',
    '1f61b',
    '1f61c',
    '1f61d',
    '1f61e',
    '1f61f',
    '1f620',
    '1f621',
    '1f622',
    '1f623',
    '1f624',
    '1f625',
    '1f626',
    '1f627',
    '1f628',
    '1f629',
    '1f62a',
    '1f62b',
    '1f62c',
    '1f62d',
    '1f62e',
    '1f62f',
    '1f630',
    '1f631',
    '1f632',
    '1f633',
    '1f634',
    '1f635',
    '1f636',
    '1f637',
    '1f639',
    '1f63a',
    '1f641',
    '1f642',
    '1f643',
    '1f644',
    '1f910',
    '1f911',
    '1f912',
    '1f913',
    '1f914',
    '1f915',
    '1f917',
    '1f920',
    '1f922',
    '1f923',
    '1f924',
    '1f925',
    '1f927',
    '1f928',
    '1f929',
    '1f92a',
    '1f92b',
    '1f92c',
    '1f92d',
    '1f92e',
    '1f92f',
    '1f970',
    '1f971',
    '1f973',
    '1f974',
    '1f975',
    '1f976',
    '1f97a',
    '1f9d0'
  ];

  static EmojiUtil _instance;

  static EmojiUtil get() {
    if (_instance == null) _instance = EmojiUtil._();
    return _instance;
  }

  List<String> get emojiList => _emojiList;
}

class EmojiText extends SpecialText {
  static const flag = '[';

  EmojiText(TextStyle textStyle, {this.start}) : super(flag, ']', textStyle);

  final int start;

  @override
  InlineSpan finishText() {
    String data = toString();
    String key = data.substring(1, data.length - 1);
    if (EmojiUtil.get().emojiList.contains(key)) {
      return ImageSpan(
        AssetImage('assets/emoji/$key.png'),
        imageWidth: textStyle.fontSize,
        imageHeight: textStyle.fontSize,
        actualText: data,
        fit: BoxFit.fill,
        start: start,
      );
    }
    return TextSpan(text: data, style: textStyle);
  }
}

class TextSpanBuilder extends SpecialTextSpanBuilder {
  TextSpanBuilder(this.builderType);

  final BuilderType builderType;

  @override
  SpecialText createSpecialText(String flag, {TextStyle textStyle, onTap, int index}) {
    if (flag == null || flag == "") return null;
    if (isStart(flag, '[')) {
      return EmojiText(textStyle, start: index - (EmojiText.flag.length - 1));
    }
    return null;
  }

  @override
  TextSpan build(String data, {TextStyle textStyle, onTap}) {
    return super.build(data, textStyle: textStyle, onTap: onTap);
  }
}
