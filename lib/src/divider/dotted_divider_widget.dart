import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

/// A widget that displays a dotted line with customizable properties
/// 一个显示可自定义属性虚线的组件
class DottedDividerWidget extends StatelessWidget {
  /// Creates a DottedDividerWidget
  /// 创建一个虚线分割线组件
  const DottedDividerWidget({
    super.key,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.direction = Axis.horizontal,
    this.strokeCap = StrokeCap.round,
    this.pattern = const <double>[],
    this.height,
    this.width,
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

  /// The direction of the dotted line
  /// 虚线的方向
  final Axis direction;

  /// The style of the line ends
  /// 线条端点的样式
  final StrokeCap strokeCap;

  /// Custom dash pattern
  /// 自定义虚线模式
  final List<double> pattern;

  /// Height of the widget (required for vertical lines)
  /// 组件的高度（垂直线条时必需）
  final double? height;

  /// Width of the widget (required for horizontal lines)
  /// 组件的宽度（水平线条时必需）
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedDividerPaint(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        direction: direction,
        strokeCap: strokeCap,
        pattern: pattern,
      ),
      size: Size(
        direction == Axis.horizontal ? width ?? double.infinity : strokeWidth,
        direction == Axis.vertical ? height ?? double.infinity : strokeWidth,
      ),
    );
  }
}
