import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageList = [ConversationPage(), ContactPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return Store.connect<GlobalProvider>(builder: (context, snapshot, child) {
      return Scaffold(
        body: _pageList[snapshot.homeTabIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: snapshot.homeTabIndex,
            onTap: (index) => setState(() => snapshot.setHomeTabIndex(index)),
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.comment), title: Text('会话')),
              BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('联系人')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我')),
            ]),
      );
    });
  }
}
