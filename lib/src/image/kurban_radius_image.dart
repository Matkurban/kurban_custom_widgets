import 'package:flutter/material.dart';

/// A customizable widget for displaying images with rounded corners or circular shape
/// 一个用于显示带圆角或圆形图片的可自定义组件
class KurbanRadiusImage extends StatelessWidget {
  /// Creates a RadiusImage widget
  /// 创建一个RadiusImage组件
  const KurbanRadiusImage({
    super.key,
    required this.image,
    this.radius = 10,
    required this.width,
    required this.height,
    this.fit = BoxFit.fill,
    this.borderWidth = 0,
    this.borderColor,
    this.backgroundColor,
    this.onTap,
  });

  /// The image to display
  /// 要显示的图片
  final ImageProvider image;

  /// Border radius of the image (only applies when shape is rectangle)
  /// 图片的圆角半径（仅在形状为矩形时生效）
  final double radius;

  /// Width of the image container
  /// 图片容器的宽度
  final double width;

  /// Height of the image container
  /// 图片容器的高度
  final double height;

  /// How the image should be inscribed into the container
  /// 图片在容器中的填充方式
  final BoxFit fit;

  /// Border width of the image container
  /// 图片容器的边框宽度
  final double borderWidth;

  /// Border color of the image container
  /// 图片容器的边框颜色
  final Color? borderColor;

  /// Background color of the image container
  /// 图片容器的背景颜色
  final Color? backgroundColor;

  /// Callback function when the image is tapped
  /// 图片点击时的回调函数
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: radius != 0 ? BorderRadius.circular(radius) : null,
        image: DecorationImage(image: image, fit: fit),
        border:
            borderWidth > 0
                ? Border.all(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth,
                )
                : null,
        color: backgroundColor,
      ),
    );

    // Wrap with GestureDetector if onTap is provided
    // 如果提供了onTap回调，则用GestureDetector包装
    if (onTap != null) {
      container = GestureDetector(onTap: onTap, child: container);
    }
    return container;
  }
}
