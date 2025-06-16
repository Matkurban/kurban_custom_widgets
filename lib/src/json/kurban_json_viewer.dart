import 'package:flutter/material.dart';

class KurbanJsonViewer extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  /// 卡片周围的边距
  final EdgeInsetsGeometry margin;

  /// 行间距
  final double rowSpacing;

  /// key颜色
  final Color keyColor;

  /// 字符串value颜色
  final Color stringColor;

  /// 数字value颜色
  final Color numberColor;

  /// 布尔value颜色
  final Color boolColor;

  /// 普通value颜色
  final Color valueColor;

  /// 行文字大小
  final double fontSize;

  /// 左侧缩进量
  final double indentWidth;

  final double elevation;

  /// 行内自定义构建
  final Widget Function(
    BuildContext context,
    String keyName,
    dynamic value,
    JsonType type,
    String path,
    TextStyle keyStyle,
    TextStyle valueStyle,
  )?
  rowBuilder;

  final VoidCallback? onTap;

  final VoidCallback? onDoubleTap;

  final VoidCallback? onLongPress;

  const KurbanJsonViewer({
    super.key,
    required this.jsonData,
    this.margin = EdgeInsets.zero,
    this.rowSpacing = 2.0,
    this.keyColor = const Color(0xff1dbaf6),
    this.stringColor = const Color(0xfff3821c),
    this.numberColor = const Color(0xff4bc015),
    this.boolColor = Colors.purple,
    this.valueColor = Colors.black,
    this.fontSize = 14,
    this.indentWidth = 10,
    this.rowBuilder,
    this.onLongPress,
    this.onTap,
    this.onDoubleTap,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildJsonView(
            keyName: '',
            value: jsonData,
            path: '',
            context: context,
            level: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildJsonView({
    required String keyName,
    required dynamic value,
    required String path,
    required BuildContext context,
    required int level,
    bool isLast = false,
  }) {
    if (value is Map) {
      return _buildJsonObject(
        keyName: keyName,
        jsonObject: value,
        path: path,
        context: context,
        level: level,
      );
    } else if (value is List) {
      return _buildJsonArray(
        keyName: keyName,
        jsonArray: value,
        path: path,
        context: context,
        level: level,
      );
    } else {
      return _buildJsonPrimitive(
        keyName: keyName,
        value: value,
        path: path,
        context: context,
        level: level,
        isLast: isLast,
      );
    }
  }

  Widget _buildJsonObject({
    required String keyName,
    required Map jsonObject,
    required String path,
    required BuildContext context,
    required int level,
  }) {
    /// 空对象，直接一行显示 {}
    if (jsonObject.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: indentWidth * level),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: fontSize),
            children: [
              if (keyName.isNotEmpty)
                TextSpan(
                  text: '"$keyName" : ',
                  style: TextStyle(color: keyColor, fontSize: fontSize),
                ),
              TextSpan(
                text: "{ }",
                style: TextStyle(color: valueColor, fontSize: fontSize),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> children = [];

    if (keyName.isNotEmpty) {
      children.add(
        _buildJsonRow(
          context: context,
          keyName: keyName,
          value: '{',
          type: JsonType.objectStart,
          path: path,
          level: level,
        ),
      );
    } else {
      children.add(
        _buildJsonRow(
          context: context,
          keyName: '',
          value: '{',
          type: JsonType.objectStart,
          path: path,
          level: level,
        ),
      );
    }

    int index = 0;
    jsonObject.forEach((key, value) {
      children.add(
        _buildJsonView(
          keyName: key.toString(),
          value: value,
          path: '$path/$key',
          context: context,
          level: level + 1,
          isLast: index == jsonObject.length - 1,
        ),
      );
      index++;
    });

    children.add(
      _buildJsonRow(
        context: context,
        keyName: '',
        value: '}',
        type: JsonType.objectEnd,
        path: path,
        level: level,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          children.map((child) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: rowSpacing / 2),
              child: child,
            );
          }).toList(),
    );
  }

  Widget _buildJsonArray({
    required String keyName,
    required List jsonArray,
    required String path,
    required BuildContext context,
    required int level,
  }) {
    List<Widget> children = [];

    if (keyName.isNotEmpty) {
      children.add(
        _buildJsonRow(
          context: context,
          keyName: keyName,
          value: '[',
          type: JsonType.arrayStart,
          path: path,
          level: level,
        ),
      );
    } else {
      children.add(
        _buildJsonRow(
          context: context,
          keyName: '',
          value: '[',
          type: JsonType.arrayStart,
          path: path,
          level: level,
        ),
      );
    }

    for (int i = 0; i < jsonArray.length; i++) {
      children.add(
        _buildJsonView(
          keyName: '',
          value: jsonArray[i],
          path: '$path/$i',
          context: context,
          level: level + 1,
          isLast: i == jsonArray.length - 1,
        ),
      );
    }

    children.add(
      _buildJsonRow(
        context: context,
        keyName: '',
        value: ']',
        type: JsonType.arrayEnd,
        path: path,
        level: level,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          children.map((child) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: rowSpacing / 2),
              child: child,
            );
          }).toList(),
    );
  }

  Widget _buildJsonPrimitive({
    required String keyName,
    required dynamic value,
    required String path,
    required BuildContext context,
    required int level,
    required bool isLast,
  }) {
    return _buildJsonRow(
      context: context,
      keyName: keyName,
      value: value,
      type: JsonType.primitive,
      path: path,
      level: level,
      isLast: isLast,
    );
  }

  Widget _buildJsonRow({
    required BuildContext context,
    required String keyName,
    required dynamic value,
    required JsonType type,
    required String path,
    required int level,
    bool isLast = false,
  }) {
    final TextStyle keyStyle = TextStyle(color: keyColor, fontSize: fontSize);

    Color vColor = valueColor;
    String displayValue = value.toString();

    if (type == JsonType.primitive) {
      if (value is String) {
        displayValue = '"$value"${isLast ? '' : ','}';
        vColor = stringColor;
      } else if (value is num) {
        displayValue = '$value${isLast ? '' : ','}';
        vColor = numberColor;
      } else if (value is bool) {
        displayValue = '$value${isLast ? '' : ','}';
        vColor = boolColor;
      }
    } else if (type == JsonType.objectStart) {
      displayValue = '{';
    } else if (type == JsonType.objectEnd) {
      displayValue = '}';
    } else if (type == JsonType.arrayStart) {
      displayValue = '[';
    } else if (type == JsonType.arrayEnd) {
      displayValue = ']';
    }

    final TextStyle valueStyle = TextStyle(color: vColor, fontSize: fontSize);

    if (rowBuilder != null) {
      return rowBuilder!(
        context,
        keyName,
        value,
        type,
        path,
        keyStyle,
        valueStyle,
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: indentWidth * level),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: fontSize), // 默认样式
          children: [
            if (type != JsonType.objectEnd &&
                type != JsonType.arrayEnd &&
                keyName.isNotEmpty)
              TextSpan(text: '"$keyName" : ', style: keyStyle),
            TextSpan(text: displayValue, style: valueStyle),
          ],
        ),
        softWrap: true,
      ),
    );
  }
}

enum JsonType { objectStart, objectEnd, arrayStart, arrayEnd, primitive }
