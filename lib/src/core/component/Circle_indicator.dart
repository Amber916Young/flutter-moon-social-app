import 'package:flutter/material.dart';
import 'package:moon/main.dart';

class CircleTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(this, onChanged);
  }
}

class _CirclePainter extends BoxPainter {
  final CircleTabIndicator decoration;

  _CirclePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = Theme.of(Get.context!).primaryColor;
    paint.style = PaintingStyle.fill;
    const double indicatorHeight = 8.0;
    final Rect indicatorRect = Rect.fromPoints(
      Offset(rect.left + (rect.width - indicatorHeight) / 2, rect.bottom - indicatorHeight),
      Offset(rect.right - (rect.width - indicatorHeight) / 2, rect.bottom),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(indicatorRect, const Radius.circular(indicatorHeight / 2)),
      paint,
    );
  }
}
