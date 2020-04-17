import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef Widget Builder<T>(BuildContext context, T snapshot, Widget child);

class Store {
  Store._();

  static init({Widget child, List<SingleChildWidget> providers}) {
    return MultiProvider(providers: providers, child: child);
  }

  static T of<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  static Consumer connect<T>({Widget child, @required Builder<T> builder}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
