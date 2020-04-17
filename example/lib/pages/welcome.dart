import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  BubbleAngleDirection direction = BubbleAngleDirection.left;
  GlobalKey globalKey = GlobalKey();
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
        // body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        //   Row(children: <Widget>[BubbleWidget('oli我哈哈哈', anglePos: direction)]),
        //   Container(
        //       margin: EdgeInsets.only(top: 100),
        //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
        //         RaisedButton(onPressed: () => setState(() => direction = BubbleAngleDirection.right), child: Text('right')),
        //         RaisedButton(onPressed: () => setState(() => direction = BubbleAngleDirection.left), child: Text('left')),
        //       ])),
        // ]),
        );
  }
}
