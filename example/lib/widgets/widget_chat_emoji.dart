import 'package:flutter/material.dart';

typedef ChatEmojiCallBack(String emoji);

class ChatEmojiWidget extends StatefulWidget {
  ChatEmojiWidget({@required this.callBack});

  final ChatEmojiCallBack callBack;

  @override
  _ChatEmojiWidgetState createState() => _ChatEmojiWidgetState();
}

class _ChatEmojiWidgetState extends State<ChatEmojiWidget> {
  static const List<String> _emojiList = [
    '1f600', '1f601', '1f602', '1f603', '1f604', '1f605', '1f606', '1f607', '1f609', '1f60a', '1f60b',
    '1f60c', '1f60d', '1f60e', '1f60f', '1f610', '1f611', '1f612', '1f613', '1f614', '1f615', '1f616',
    '1f617', '1f618', '1f619', '1f61a', '1f61b', '1f61c', '1f61d', '1f61e', '1f61f', '1f620', '1f621',
    '1f622', '1f623', '1f624', '1f625', '1f626', '1f627', '1f628', '1f629', '1f62a', '1f62b', '1f62c',
    '1f62d', '1f62e', '1f62f', '1f630', '1f631', '1f632', '1f633', '1f634', '1f635', '1f636', '1f637',
    '1f639', '1f63a', '1f641', '1f642', '1f643', '1f644', '1f910', '1f911', '1f912', '1f913', '1f914',
    '1f915', '1f917', '1f920', '1f922', '1f923', '1f924', '1f925', '1f927', '1f928', '1f929', '1f92a',
    '1f92b', '1f92c', '1f92d', '1f92e', '1f92f', '1f970', '1f971', '1f973', '1f974', '1f975', '1f976',
    '1f97a', '1f9d0'
  ];

  int pageSize = 7 * 4;
  int pageCount = 0;
  List<List<String>> pageList = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    int length = _emojiList.length;
    pageCount = (length / pageSize).ceil();
    for (int i = 0; i < pageCount; i++) {
      int start = i * pageSize;
      int end = (i + 1) * pageSize;
      if (end > length) end = length;
      pageList.add(_emojiList.sublist(start, end));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
    List<String> pageData = pageList[pageIndex];
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 0, crossAxisSpacing: 0),
      physics: NeverScrollableScrollPhysics(),
      itemCount: pageData.length,
      itemBuilder: (context, index) => buildGridViewItem(pageData[index]),
    );
  }

  Widget buildGridViewItem(String imageName) {
    return Container(
        alignment: Alignment.center,
        child: FlatButton(
          child: Image.asset('assets/emoji/$imageName.png', width: 25),
          onPressed: () => widget.callBack(imageName),
        ));
  }

  Widget buildIndicator() {
    List<Widget> itemList = [];
    for (int i = 0; i < pageCount; i++) {
      double marginLeft = (i == 0 ? 0 : 20);
      Color color = (i == currentPage ? Colors.grey : Colors.grey[300]);
      var indicator = Container(
          height: 5, width: 5, margin: EdgeInsets.only(left: marginLeft), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)));
      itemList.add(indicator);
    }
    return Container(height: 30, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: itemList));
  }
}
