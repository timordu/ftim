import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatefulWidget {
  EditInfoPage(this.filed, this.title, this.value);

  final String filed;
  final String title;
  final String value;

  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  String value;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('修改${widget.title}', style: TextStyle(fontSize: 20)), actions: <Widget>[
        CupertinoButton(
          child: Text('确定', style: TextStyle(color: Colors.white, fontSize: 14)),
          onPressed: () => Navigator.pop(context, value),
        )
      ]),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: CupertinoTextField(
              padding: EdgeInsets.all(5),
              style: TextStyle(fontSize: 15),
              maxLines:  widget.filed == 'signature' ? 5 : 1,
              decoration: BoxDecoration(),
              controller: TextEditingController.fromValue(TextEditingValue(
                text: value,
                selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: value.length)),
              )),
              onChanged: (String str) => setState(() => value = str))),
    );
  }
}
