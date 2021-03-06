import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

import '../../util/emoji.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.conversation);

  final TimConversation conversation;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _controller;
  double contentHeight = 0;
  double bottomHeight = 0;

  FocusNode focusNode = FocusNode();
  String textMsg = '';

  bool voiceShow = false;
  bool emojiShow = false;
  bool moreShow = false;

  @override
  void initState() {
    super.initState();
    Store.of<FtimProvider>(context).enterConversation(widget.conversation);
    _controller = ScrollController();
    Timer(Duration(milliseconds: 50), () => calculateHeight());
  }

  @override
  void deactivate() {
    super.deactivate();
    Store.of<FtimProvider>(context).exitConversation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void calculateHeight({bool voice, bool emoji, bool more}) {
    double availableHeight = Config.screenHeight(context) - 80;
    double bottom = (emoji ?? false) || (more ?? false) ? 310 : 55;
    if (bottom == 310) {
      if (voice != null && !voice) focusNode.requestFocus();
      if (emoji != null) emoji ? focusNode.unfocus() : focusNode.requestFocus();
      if (more != null) more ? focusNode.unfocus() : focusNode.requestFocus();

      Timer(Duration(milliseconds: 150), () {
        setState(() {
          voiceShow = voice ?? false;
          emojiShow = emoji ?? false;
          moreShow = more ?? false;

          contentHeight = availableHeight - bottom;
          bottomHeight = bottom;
        });
      });
    } else {
      setState(() {
        voiceShow = voice ?? false;
        emojiShow = emoji ?? false;
        moreShow = more ?? false;

        contentHeight = availableHeight - bottom;
        bottomHeight = bottom;
      });
      Timer(Duration(milliseconds: 50), () {
        if (voice != null && !voice) focusNode.requestFocus();
        if (emoji != null) emoji ? focusNode.unfocus() : focusNode.requestFocus();
        if (more != null) more ? focusNode.unfocus() : focusNode.requestFocus();
      });
    }
  }

  void chartMoreEvent(String key) async {
    switch (key) {
      case 'picture':
        File file = await ImagePicker.pickImage(source: ImageSource.gallery);
        if (file != null) widget.conversation.sendImageMessage([file.path]);
        break;
      case 'camera':
        File file = await ImagePicker.pickImage(source: ImageSource.camera);
        if (file != null) widget.conversation.sendImageMessage([file.path]);
        break;
      case 'location':
        break;
      case 'person':
        break;
      case 'file':
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(widget.conversation.title, style: TextStyle(fontSize: 20)),
            actions: <Widget>[]),
        body: Column(children: <Widget>[
          Expanded(
            child: GestureDetector(
                onTap: () => focusNode.unfocus(),
                child: Container(
                    height: contentHeight,
                    child: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
                      Timer(Duration(microseconds: 50),
                          () => _controller.jumpTo(_controller.position.maxScrollExtent));
                      return ListView.builder(
                          controller: _controller,
                          itemCount: snapshot.currentConversationMsgList.length,
                          itemBuilder: (context, index) {
                            return MessageWidget(
                              context,
                              snapshot.currentConversationMsgList[index],
                              imageClick: (elem) =>StaticRouter.toImagePreview(context, elem),
                            ).build();
                          });
                    }))),
          ),
          Container(
              height: bottomHeight,
              color: Colors.grey[200],
              child: Column(children: <Widget>[
                Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(10),
                    child: Row(children: <Widget>[
                      voiceBtn(),
                      Expanded(child: voiceShow ? voiceInput() : textInput()),
                      emojiBtn(),
                      moreBtn(),
                      sendBtn(),
                    ])),
                Visibility(
                    visible: emojiShow,
                    child: ChatEmojiWidget(callBack: (key) => setState(() => textMsg += '[$key]'))),
                Visibility(
                    visible: moreShow,
                    child: ChatMoreWidget(callBack: (key) => chartMoreEvent(key))),
              ]))
        ]));
  }

  /// 语音按钮
  Widget voiceBtn() {
    return GestureDetector(
        onTap: () => calculateHeight(voice: !voiceShow),
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child:
              Image.asset(FileUtil.loadImage('${voiceShow ? 'keyboard' : 'voice'}.png'), width: 25),
        ));
  }

  ///语音输入
  Widget voiceInput() {
    return Container(
        height: 35,
        child: FlatButton(
          color: Colors.grey[300],
          onPressed: () {},
          onLongPress: () {},
          child: Text('按住 说话'),
        ));
  }

  ///文本输入
  Widget textInput() {
    // fixme 无法同时展示4行输入内容
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 35),
        child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: ExtendedTextField(
              style: TextStyle(fontSize: 16),
              maxLines: 4,
              minLines: 1,
              focusNode: focusNode,
              specialTextSpanBuilder: TextSpanBuilder(BuilderType.extendedTextField),
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: textMsg,
                  selection: TextSelection.fromPosition(
                    TextPosition(affinity: TextAffinity.downstream, offset: textMsg.length),
                  ),
                ),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onChanged: (text) => setState(() => textMsg = text),
              onTap: () => calculateHeight(),
            )));
  }

  /// 表情按钮
  Widget emojiBtn() {
    return GestureDetector(
        onTap: () => calculateHeight(emoji: !emojiShow),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child:
              Image.asset(FileUtil.loadImage('${emojiShow ? 'keyboard' : 'emoji'}.png'), width: 25),
        ));
  }

  ///更多按钮
  Widget moreBtn() {
    return Offstage(
        offstage: textMsg.isNotEmpty,
        child: GestureDetector(
          onTap: () => calculateHeight(more: !moreShow),
          child: Image.asset(FileUtil.loadImage('add.png'), width: 25),
        ));
  }

  ///文本发送按钮
  Widget sendBtn() {
    return Offstage(
        offstage: textMsg.isEmpty,
        child: Material(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(3),
            child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 4),
                  child: Text('发送', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
                onTap: () {
                  if (textMsg.isEmpty) {
                    BotToast.showText(
                        text: '不能发送空的消息', textStyle: TextStyle(fontSize: 12, color: Colors.white));
                  } else {
                    widget.conversation.sendTextMessage(textMsg);
                    setState(() => textMsg = '');
                  }
                })));
  }
}
