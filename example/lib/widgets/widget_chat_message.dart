import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class MessageWidget {
  MessageWidget(this.context, this.message);

  final BuildContext context;
  final TimMessage message;

  bool get _isTextMsg => message.element['type'] == 'Text';

  Widget build() {
    switch (message.type) {
      case TimConversation.TYPE_C2C:
        return _single();
        break;
      case TimConversation.TYPE_GROUP:
        return _group();
        break;
      case TimConversation.TYPE_SYSTEM:
        return _system();
        break;
      default:
        return _invalid();
        break;
    }
  }

  Widget _single() {
    var row = message.isSelf
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: _isTextMsg ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: <Widget>[
                Container(margin: EdgeInsets.only(right: 10), child: _elementDispatcher(message.element)),
                Avatar.builder(message.sender.faceUrl),
              ])
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: _isTextMsg ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: <Widget>[
                Avatar.builder(message.sender.faceUrl),
                Container(margin: EdgeInsets.only(left: 10), child: _elementDispatcher(message.element)),
              ]);
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      alignment: message.isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: row,
    );
  }

  Widget _group() {
    return Container();
  }

  Widget _system() {
    return Container();
  }

  Widget _invalid() {
    return Container();
  }

  Widget _elementDispatcher(Map elem) {
    switch (elem['type']) {
      case 'Text':
        return _textMessage(TimTextElem.fromJson(elem));
        break;
      case 'Image':
        return _imageMessage(TimImageElem.fromJson(elem));
        break;
      default:
        return Container();
    }
  }

  Widget _textMessage(TimTextElem elem) {
    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width * 0.75,
      child: BubbleWidget(
        color: message.isSelf ? Colors.lightGreenAccent[100] : Colors.lightBlueAccent[100],
        direction: message.isSelf ? BubbleDirection.right : BubbleDirection.left,
        child: ExtendedText(elem.text, specialTextSpanBuilder: TextSpanBuilder(BuilderType.extendedText)),
      ),
    );
  }

  Widget _imageMessage(TimImageElem elem) {
    TimImage image;
    if (elem.imageList.length > 0) {
      image = elem.imageList.firstWhere((e) => e.type == 'Thumb');
    }
    return image != null
        ? Container(
            width: image.width.toDouble() / 2,
            height: image.height.toDouble() / 2,
            child: CachedNetworkImage(imageUrl: image.url),
          )
        : Container();
  }
}
