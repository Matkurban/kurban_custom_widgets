import 'package:flutter/material.dart';

/// A widget that displays an image in a circle shape.
/// 一个在圆形区域内显示图片的组件。
class KurbanCircleImage extends StatelessWidget {
  /// Creates a circle image widget.
  /// 创建一个圆形图片组件。
  const KurbanCircleImage({
    super.key,
    this.size,
    required this.image,
    this.onError,
    this.colorFilter,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.centerSlice,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.scale = 1.0,
    this.opacity = 1.0,
    this.filterQuality = FilterQuality.medium,
    this.invertColors = false,
    this.isAntiAlias = false,
    this.backgroundColor,
    this.border,
  });

  /// The diameter of the circle.
  /// 圆形的直径。
  final double? size;

  /// The image to display.
  /// 要显示的图片。
  ///
  /// Typically this will be an [AssetImage] or a [NetworkImage].
  /// 通常是 [AssetImage] 或 [NetworkImage]。
  final ImageProvider image;

  /// Called when an error occurs while loading the image.
  /// 当图片加载出错时的回调函数。
  final ImageErrorListener? onError;

  /// A color filter to apply to the image.
  /// 应用于图片的颜色滤镜。
  final ColorFilter? colorFilter;

  /// How the image should be inscribed into the circle.
  /// 图片在圆形内的填充方式。
  final BoxFit? fit;

  /// How to align the image within the circle.
  /// 图片在圆形内的对齐方式。
  final AlignmentGeometry alignment;

  /// The center slice for a nine-patch image.
  /// 九宫格图片的中心切片区域。
  final Rect? centerSlice;

  /// How to paint any portions of the circle not covered by the image.
  /// 如何绘制图片未覆盖到的圆形区域。
  final ImageRepeat repeat;

  /// Whether to match the text direction when painting the image.
  /// 是否根据文字方向绘制图片。
  final bool matchTextDirection;

  /// The scale to apply to the image.
  /// 图片的缩放比例。
  final double scale;

  /// The opacity to apply to the image.
  /// 图片的不透明度。
  final double opacity;

  /// The filter quality to apply to the image.
  /// 图片的过滤质量。
  final FilterQuality filterQuality;

  /// Whether to invert the colors of the image.
  /// 是否反转图片颜色。
  final bool invertColors;

  /// Whether to apply anti-aliasing to the image.
  /// 是否对图片应用抗锯齿。
  final bool isAntiAlias;

  /// The background color of the circle.
  /// 圆形的背景颜色。
  final Color? backgroundColor;

  /// The border to draw around the circle.
  /// 圆形的边框。
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? imageSize = size ?? iconTheme.size;
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: border,
        image: DecorationImage(
          image: image,
          onError: onError,
          colorFilter: colorFilter,
          fit: fit,
          alignment: alignment,
          centerSlice: centerSlice,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          scale: scale,
          opacity: opacity,
          filterQuality: filterQuality,
          invertColors: invertColors,
          isAntiAlias: isAntiAlias,
        ),
      ),
    );
  }
}
