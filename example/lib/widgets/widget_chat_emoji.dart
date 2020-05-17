import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

typedef ChatEmojiCallBack(String emoji);

class ChatEmojiWidget extends StatefulWidget {
  ChatEmojiWidget({@required this.callBack});

  final ChatEmojiCallBack callBack;

  @override
  _ChatEmojiWidgetState createState() => _ChatEmojiWidgetState();
}

class _ChatEmojiWidgetState extends State<ChatEmojiWidget> {
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
    int length = EmojiUtil.get().emojiList.length;
    pageCount = (length / pageSize).ceil();
    for (int i = 0; i < pageCount; i++) {
      int start = i * pageSize;
      int end = (i + 1) * pageSize;
      if (end > length) end = length;
      pageList.add(EmojiUtil.get().emojiList.sublist(start, end));
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
          height: 5,
          width: 5,
          margin: EdgeInsets.only(left: marginLeft),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)));
      itemList.add(indicator);
    }
    return Container(height: 30, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: itemList));
  }
}
