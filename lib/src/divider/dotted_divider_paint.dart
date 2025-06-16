import 'package:flutter/material.dart';

/// A custom painter that draws a dotted line with customizable properties
/// 自定义绘制器，用于绘制可自定义属性的虚线
class DottedDividerPaint extends CustomPainter {
  /// Creates a DottedDivider
  /// 创建一个虚线分割线
  DottedDividerPaint({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.direction = Axis.horizontal,
    this.strokeCap = StrokeCap.round,
    this.pattern = const <double>[],
  });

  /// The color of the dotted line
  /// 虚线的颜色
  final Color color;

  /// The width/thickness of the line
  /// 线条的宽度/粗细
  final double strokeWidth;

  /// The width of each dash
  /// 每个虚线段的宽度
  final double dashWidth;

  /// The space between dashes
  /// 虚线段之间的间距
  final double dashSpace;

  /// The direction of the dotted line (horizontal or vertical)
  /// 虚线的方向（水平或垂直）
  final Axis direction;

  /// The style of the line ends
  /// 线条端点的样式
  final StrokeCap strokeCap;

  /// Custom dash pattern (if empty, uses dashWidth and dashSpace)
  /// 自定义虚线模式（如果为空，则使用 dashWidth 和 dashSpace）
  final List<double> pattern;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeCap
          ..style = PaintingStyle.stroke;

    final Path path = Path();

    if (pattern.isEmpty) {
      // Use default dash pattern
      // 使用默认虚线模式
      double start = 0;
      final double maxLength =
          direction == Axis.horizontal ? size.width : size.height;

      while (start < maxLength) {
        if (direction == Axis.horizontal) {
          path.moveTo(start, 0);
          path.lineTo(start + dashWidth, 0);
        } else {
          path.moveTo(0, start);
          path.lineTo(0, start + dashWidth);
        }
        start += dashWidth + dashSpace;
      }
    } else {
      // Use custom dash pattern
      // 使用自定义虚线模式
      double start = 0;
      bool draw = true;
      int patternIndex = 0;

      final double maxLength =
          direction == Axis.horizontal ? size.width : size.height;

      while (start < maxLength) {
        final double length = pattern[patternIndex % pattern.length];
        if (draw) {
          if (direction == Axis.horizontal) {
            path.moveTo(start, 0);
            path.lineTo(start + length, 0);
          } else {
            path.moveTo(0, start);
            path.lineTo(0, start + length);
          }
        }
        start += length;
        draw = !draw;
        patternIndex++;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DottedDividerPaint oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.direction != direction ||
        oldDelegate.strokeCap != strokeCap ||
        oldDelegate.pattern != pattern;
  }
}
