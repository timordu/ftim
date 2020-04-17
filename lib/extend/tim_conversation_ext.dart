import 'package:ftim/bean/bean.dart';
import 'package:ftim/ftim_plugin.dart';

extension TimConversationExt on TimConversation {
  /// 会话列表获取会话的最后一次的消息类型
  String getLastMsgText() {
    if (lastMsg == null) return '';
    switch (lastMsg.element['type']) {
      case 'Text':
        return TimTextElem.fromJson(lastMsg.element).text;
        break;
      case 'Image':
        return '[图片]';
        break;
      default:
        return '';
    }
  }

  /// 发送消息 TIMMessage
  void sendTextMessage(String content) => Ftim.get().sendTextMessage(content, peer, type);

  void sendImageMessage(List<String> content) => Ftim.get().sendImageMessage(content, peer, type);

  ///发送在线消息（无痕消息） “在线消息”，也可以称为是“无痕消息”。
  void sendOnlineMessage() {}

  ///向本地消息列表中添加一条消息，但并不将其发送出去
  void saveMessage() {}

  ///撤回一条已发送的消息
  void revokeMessage() {}

  /// 获取本地历史消息
  Future<List<TimMessage>> getLocalMessage() async => await Ftim.get().getLocalMessage(peer, type);
}
