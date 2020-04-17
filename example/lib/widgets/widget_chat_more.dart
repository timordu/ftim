import 'package:flutter/material.dart';

typedef ChatMoreCallback(String key);

class ChatMoreWidget extends StatefulWidget {
  ChatMoreWidget({@required this.callBack});

  final ChatMoreCallback callBack;

  @override
  _ChatMoreWidgetState createState() => _ChatMoreWidgetState();
}

class _ChatMoreWidgetState extends State<ChatMoreWidget> {
  static const List<Map<String, String>> _addList = [
    {'key': 'picture', 'name': '图片'},
    {'key': 'camera', 'name': '相机'},
    {'key': 'location', 'name': '位置'},
    {'key': 'person', 'name': '名片'},
    {'key': 'file', 'name': '文件'}
  ];

  int pageSize = 4 * 2;
  int pageCount = 0;
  List<List<Map<String, String>>> pageList = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    int length = _addList.length;
    pageCount = (length / pageSize).ceil();
    for (int i = 0; i < pageCount; i++) {
      int start = i * pageSize;
      int end = (i + 1) * pageSize;
      if (end > length) end = length;
      pageList.add(_addList.sublist(start, end));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(height: 225, child: buildPageView()),
      Offstage(offstage: pageCount == 1, child: buildIndicator()),
    ]);
  }

  Widget buildPageView() {
    return PageView.builder(
        controller: PageController(initialPage: currentPage, keepPage: true),
        scrollDirection: Axis.horizontal,
        itemCount: pageCount,
        onPageChanged: (page) => setState(() => currentPage = page),
        itemBuilder: (context, page) => buildGridView(page));
  }

  Widget buildGridView(int pageIndex) {
    List<Map<String, String>> pageData = pageList[pageIndex];
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 0, crossAxisSpacing: 0),
      physics: NeverScrollableScrollPhysics(),
      itemCount: pageData.length,
      itemBuilder: (context, index) => buildGridViewItem(pageData[index]),
    );
  }

  Widget buildGridViewItem(Map<String, String> data) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(bottom: 5),
          child: FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Image.asset('assets/images/${data['key']}.png', width: 25),
            onPressed: () => widget.callBack(data['key']),
          )),
      Text(data['name'], style: TextStyle(fontSize: 12))
    ]);
  }

  Widget buildIndicator() {
    List<Widget> itemList = [];
    for (int i = 0; i < pageCount; i++) {
      double marginLeft = (i == 0 ? 0 : 20);
      Color color = (i == currentPage ? Colors.grey : Colors.grey[300]);
      var indicator = Container(
        height: 5,
        width: 5,
        margin: EdgeInsets.only(left: marginLeft),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      );
      itemList.add(indicator);
    }
    return Container(height: 30, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: itemList));
  }
}
