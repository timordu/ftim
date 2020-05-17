import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';
import 'package:ftim_example/widgets/widget_bubble.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await [Permission.camera, Permission.storage, Permission.locationWhenInUse].request();

    Ftim.get().init(1400302303);

    Timer(Duration(milliseconds: 200), () => StaticRouter.toLogin(context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        floatingActionButton: FloatingActionButton(onPressed: () => text()),
//        body: Center(
//          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
////            ChatRichTextWidget('添加到child上的额外限制条件[1f60b]，其类型为BoxConstraints。BoxConstraints的作用是干啥的呢？'
////                '其实很简单，就是限制各种最大最小宽高。说到这里插一句，double.infinity在widget布局的时候是合法的，'
////                '也就说，例如. 想最大的扩展宽度，可以将宽度值设为double.infinity'),
//
//            Container(
//              margin: EdgeInsets.only(left: 10),
//              child: LimitedBox(
//                  maxWidth: MediaQuery.of(context).size.width * 0.75,
//                  child: BubbleWidget(
//                    direction: BubbleDirection.left,
//                    child: ExtendedText(
//                      '添加到child上的额😁外限制条件[1f60b][1f9d0]，其类型为BoxConstraints。BoxConstraints的作用是干啥的呢？'
//                      '其实很简单，就是限制各种最大最小宽高。说到这里插一句，double',
//                      specialTextSpanBuilder: TextSpanBuilder(BuilderType.extendedText),
//                      style: TextStyle(fontSize: 15),
//                    ),
//                  )),
//            )
//          ]),
//        )
    );
  }
}
