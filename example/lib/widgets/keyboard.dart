import 'package:flutter/widgets.dart';

typedef ShowCallback = void Function(bool isShow);

class KeyboardDetector extends StatefulWidget {
  static double keyboardHeight(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;

  ///键盘是否显示
  static bool isShow(BuildContext context) => MediaQuery.of(context).viewInsets.bottom > 0;

  ///显示键盘
  static void show(BuildContext context, FocusNode focusNode) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      final focusScope = FocusScope.of(context);
      focusScope.requestFocus(FocusNode());
      Future.delayed(Duration.zero, () => focusScope.requestFocus(focusNode));
    }
  }

  ///关闭键盘
  static void close(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());

  final ShowCallback showCallback;

  final Widget child;

  KeyboardDetector({this.showCallback, @required this.child});

  @override
  _KeyboardDetectorState createState() => _KeyboardDetectorState();
}

class _KeyboardDetectorState extends State<KeyboardDetector> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.showCallback?.call(MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
