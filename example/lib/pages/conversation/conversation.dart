import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('Ftim', style: TextStyle(fontSize: 20)), actions: <Widget>[
          IconButton(icon: Icon(Icons.search), color: Config.color_primary, onPressed: () {}),
          IconButton(icon: Icon(Icons.add_circle_outline), color: Config.color_primary, onPressed: () {})
        ]),
        body: Store.connect<FtimProvider>(builder: (context, snapshot, child) {
          return ListView.builder(
            itemCount: snapshot.conversationList.length,
            itemBuilder: (context, index) => itemBuilder(snapshot.conversationList[index]),
          );
        }));
  }

  Widget itemBuilder(TimConversation conversation) {
    return GestureDetector(
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(children: [
            Avatar.builder(conversation.faceUrl),
            Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(conversation.title, style: TextStyle(fontSize: 16)),
                  Container(margin: EdgeInsets.only(top: 10), child: Text(conversation.getLastMsgText(), style: TextStyle(color: Colors.grey, fontSize: 12)))
                ]))
          ])),
      onTap: () => StaticRouter.toSingleChat(context, conversation),
      onLongPress: () {},
    );
  }
}
