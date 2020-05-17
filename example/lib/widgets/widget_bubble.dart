import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

enum BubbleDirection { left, right }

class BubbleWidget extends StatelessWidget {
  BubbleWidget({
    @required this.child,
    this.color = Colors.lightGreen,
    this.padding = const EdgeInsets.all(10),
    this.direction = BubbleDirection.left,
    this.radius = 10,
    this.angle = 60,
    this.angleHeight = 12,
  });

  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsets padding;

  // 尖角
  final double angle;
  final double angleHeight;
  final BubbleDirection direction;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        padding: EdgeInsets.only(
          left: padding.left + (direction == BubbleDirection.left ? angleHeight : 0),
          right: padding.right + (direction == BubbleDirection.right ? angleHeight : 0),
          top: padding.top,
          bottom: padding.bottom,
        ),
        child: child,
      ),
      painter: _BubblePainter(color: color, radius: radius, angle: angle, angleHeight: angleHeight, direction: direction),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter({
    this.color,
    this.radius,
    this.angle,
    this.angleHeight,
    this.direction,
  });

  final Color color;
  final double radius;

  // 尖角
  final double angle;
  final double angleHeight;
  final BubbleDirection direction;

  double _angle(angle) => angle * pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    double angleLength = angleHeight * tan(_angle(angle * 0.5));

    Path path = Path();

    // 左上角圆角
    Offset leftTop = Offset(direction == BubbleDirection.left ? radius + angleHeight : radius, radius);
    path.arcTo(Rect.fromCircle(center: Offset(leftTop.dx, leftTop.dy), radius: radius), pi, pi * 0.5, false);

    // 右上角圆角
    Offset rightTop = Offset(width - radius - (direction == BubbleDirection.right ? angleHeight : 0), radius);
    path.arcTo(Rect.fromCircle(center: Offset(rightTop.dx, rightTop.dy), radius: radius), -pi * 0.5, pi * 0.5, false);

    if (direction == BubbleDirection.right) {
      path.lineTo(width - angleHeight, radius);
      path.lineTo(width, radius + angleLength);
      path.lineTo(width - angleHeight, radius + angleLength * 2);
    }

    // 右下角圆角
    Offset rightBottom = Offset(direction == BubbleDirection.right ? width - angleHeight - radius : width - radius, height - radius);
    path.arcTo(Rect.fromCircle(center: Offset(rightBottom.dx, rightBottom.dy), radius: radius), 0, pi * 0.5, false);

    // 左下角圆角
    Offset leftBottom = Offset((direction == BubbleDirection.left) ? angleHeight + radius : radius, height - radius);
    path.arcTo(Rect.fromCircle(center: Offset(leftBottom.dx, leftBottom.dy), radius: radius), pi * 0.5, pi * 0.5, false);

    if (direction == BubbleDirection.left) {
      path.lineTo(angleHeight, radius);
      path.lineTo(0, radius + angleLength);
      path.lineTo(angleHeight, radius + angleLength * 2);
    }

    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
