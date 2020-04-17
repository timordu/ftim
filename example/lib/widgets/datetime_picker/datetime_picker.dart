import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/date_model.dart';
import 'src/i18n_model.dart';
import 'src/datetime_picker_theme.dart';

export 'src/date_model.dart';
export 'src/i18n_model.dart';
export 'src/datetime_picker_theme.dart';

typedef DateChangedCallback(DateTime time);
typedef String StringAtIndexCallBack(int index);

class DateTimePicker {
  ///显示日期选择器
  static showDatePicker(
    BuildContext context, {
    DateTime currentTime,
    DateType dateType: DateType.Y_M_D,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    bool showTitleActions: true,
    DateTime minTime,
    DateTime maxTime,
    LocaleType locale: LocaleType.zh,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel:
                DatePickerModel(currentTime: currentTime, maxTime: maxTime, minTime: minTime, dateType: dateType, locale: locale)));
  }

  ///显示时间选择器
  static showTimePicker(
    BuildContext context, {
    DateTime currentTime,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    bool showSecond: false,
    bool showTitleActions: true,
    LocaleType locale: LocaleType.zh,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: TimePickerModel(showSecond: showSecond, currentTime: currentTime, locale: locale)));
  }

  ///显示日期时间选择器
  static showDateTimePicker(
    BuildContext context, {
    DateTime currentTime,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    bool showTitleActions: true,
    LocaleType locale: LocaleType.zh,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DateTimePickerModel(currentTime: currentTime, locale: locale)));
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.locale,
    this.barrierLabel,
    theme,
    pickerModel,
    RouteSettings settings,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool showTitleActions;
  final DateChangedCallback onChanged;
  final DateChangedCallback onConfirm;
  final DatePickerTheme theme;
  final LocaleType locale;
  final BasePickerModel pickerModel;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _DatePickerComponent(onChanged: onChanged, locale: this.locale, route: this, pickerModel: pickerModel));
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({Key key, @required this.route, this.onChanged, this.locale, this.pickerModel});

  final DateChangedCallback onChanged;
  final _DatePickerRoute route;
  final LocaleType locale;
  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = new FixedExtentScrollController(initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = new FixedExtentScrollController(initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = new FixedExtentScrollController(initialItem: widget.pickerModel.currentRightIndex());
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(widget.pickerModel.finalTime());
    }
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return new GestureDetector(
        child: new AnimatedBuilder(
            animation: widget.route.animation,
            builder: (BuildContext context, Widget child) {
              return new ClipRect(
                  child: new CustomSingleChildLayout(
                      delegate:
                          new _BottomPickerLayout(widget.route.animation.value, theme, showTitleActions: widget.route.showTitleActions),
                      child: new GestureDetector(child: Material(color: Colors.transparent, child: _renderPickerView(theme)))));
            }));
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions) {
      return Column(children: <Widget>[_renderTitleActionsView(theme), itemView]);
    }
    return itemView;
  }

  Widget _renderColumnView(
    ValueKey key,
    DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
  ) {
    return Expanded(
        flex: layoutProportion,
        child: Container(
            padding: EdgeInsets.all(8.0),
            height: theme.containerHeight,
            decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
            child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification.depth == 0 &&
                      selectedChangedWhenScrollEnd != null &&
                      notification is ScrollEndNotification &&
                      notification.metrics is FixedExtentMetrics) {
                    final FixedExtentMetrics metrics = notification.metrics;
                    final int currentItemIndex = metrics.itemIndex;
                    selectedChangedWhenScrollEnd(currentItemIndex);
                  }
                  return false;
                },
                child: CupertinoPicker.builder(
                    key: key,
                    backgroundColor: theme.backgroundColor ?? Colors.white,
                    scrollController: scrollController,
                    itemExtent: theme.itemHeight,
                    onSelectedItemChanged: (int index) {
                      selectedChangedWhenScrolling(index);
                    },
                    useMagnifier: true,
                    itemBuilder: (BuildContext context, int index) {
                      final content = stringAtIndexCB(index);
                      if (content == null) {
                        return null;
                      }
                      return Container(
                          height: theme.itemHeight,
                          alignment: Alignment.center,
                          child: Text(
                            content,
                            style: theme.itemStyle,
                            textAlign: TextAlign.start,
                          ));
                    }))));
  }

  Widget _renderItemView(DatePickerTheme theme) {
    var left = _renderColumnView(ValueKey(widget.pickerModel.currentLeftIndex()), theme, widget.pickerModel.leftStringAtIndex,
        leftScrollCtrl, widget.pickerModel.layoutProportions()[0], (index) {
      widget.pickerModel.setLeftIndex(index);
    }, (index) {
      setState(() {
        refreshScrollOffset();
        _notifyDateChanged();
      });
    });

    var leftDivider = Text(widget.pickerModel.leftDivider(), style: theme.itemStyle);

    var middle = _renderColumnView(ValueKey(widget.pickerModel.currentLeftIndex()), theme, widget.pickerModel.middleStringAtIndex,
        middleScrollCtrl, widget.pickerModel.layoutProportions()[1], (index) {
      widget.pickerModel.setMiddleIndex(index);
    }, (index) {
      setState(() {
        refreshScrollOffset();
        _notifyDateChanged();
      });
    });

    var rightDivider = Text(widget.pickerModel.rightDivider(), style: theme.itemStyle);

    var right = _renderColumnView(ValueKey(widget.pickerModel.currentMiddleIndex() + widget.pickerModel.currentLeftIndex()), theme,
        widget.pickerModel.rightStringAtIndex, rightScrollCtrl, widget.pickerModel.layoutProportions()[2], (index) {
      widget.pickerModel.setRightIndex(index);
      _notifyDateChanged();
    }, null);

    var row = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [left, leftDivider, middle, rightDivider, right]);
    if (widget.pickerModel is DatePickerModel) {
      var model = widget.pickerModel as DatePickerModel;
      switch (model.dateType) {
        case DateType.Y:
          row = Row(mainAxisAlignment: MainAxisAlignment.center, children: [left]);
          break;
        case DateType.Y_M:
          row = Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [left, leftDivider, middle]);
          break;
        default:
          break;
      }
    } else if (widget.pickerModel is TimePickerModel) {
      var model = widget.pickerModel as TimePickerModel;
      if (!model.showSecond) {
        row = Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [left, leftDivider, middle]);
      }
    }

    return Container(color: theme.backgroundColor ?? Colors.white, child: row);
  }

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    String done = _localeDone();
    String cancel = _localeCancel();

    return Container(
        height: theme.titleHeight,
        decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Container(
              height: theme.titleHeight,
              child: CupertinoButton(
                pressedOpacity: 0.3,
                padding: EdgeInsets.only(left: 16, top: 0),
                child: Text('$cancel', style: theme.cancelStyle),
                onPressed: () => Navigator.pop(context),
              )),
          Container(
              height: theme.titleHeight,
              child: CupertinoButton(
                  pressedOpacity: 0.3,
                  padding: EdgeInsets.only(right: 16, top: 0),
                  child: Text('$done', style: theme.doneStyle),
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.route.onConfirm != null) {
                      widget.route.onConfirm(widget.pickerModel.finalTime());
                    }
                  }))
        ]));
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'];
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'];
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme, {this.itemCount, this.showTitleActions});

  final double progress;
  final int itemCount;
  final bool showTitleActions;
  final DatePickerTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions) {
      maxHeight += theme.titleHeight;
    }
    return new BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth, minHeight: 0.0, maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
