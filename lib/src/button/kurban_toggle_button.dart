import 'package:flutter/material.dart';

/// A customizable toggle button group widget that supports horizontal scrolling
/// 一个可自定义的支持水平滚动的切换按钮组组件
class KurbanToggleButton extends StatefulWidget {
  /// List of labels to display on the buttons
  /// 按钮上显示的标签列表
  final List<String> labels;

  /// Index of the currently selected button
  /// 当前选中按钮的索引
  final int selectedIndex;

  /// Callback function when a button is selected
  /// 按钮被选中时的回调函数
  final Function(int index) onSelected;

  /// Background color of the selected button
  /// 选中按钮的背景颜色
  final Color selectedColor;

  /// Background color of unselected buttons
  /// 未选中按钮的背景颜色
  final Color unselectedColor;

  /// Text style for the selected button
  /// 选中按钮的文本样式
  final TextStyle selectedTextStyle;

  /// Text style for unselected buttons
  /// 未选中按钮的文本样式
  final TextStyle unselectedTextStyle;

  /// Padding for each button
  /// 每个按钮的内边距
  final EdgeInsetsGeometry padding;

  /// Border radius for each button
  /// 每个按钮的圆角半径
  final BorderRadius borderRadius;

  /// Height of the toggle button group container
  /// 切换按钮组容器的高度,横向时为高度，竖向时为宽度。
  final double size;

  /// Margin for each button
  /// 每个按钮的外边距
  final EdgeInsetsGeometry itemMargin;

  /// Duration for the scroll animation
  /// 滚动动画的持续时间
  final Duration animationDuration;

  /// Curve for the scroll animation
  /// 滚动动画的曲线
  final Curve animationCurve;

  final AlignmentGeometry labelAlignment;

  final Widget Function(BuildContext context, int index, bool isSelected)?
  itemBuilder;

  final Axis axis;

  final double inkWellRadius;

  @override
  State createState() => _KurbanToggleButtonState();

  const KurbanToggleButton({
    super.key,
    required this.labels,
    required this.onSelected,
    this.selectedIndex = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.black12,
    this.selectedTextStyle = const TextStyle(color: Colors.white),
    this.unselectedTextStyle = const TextStyle(color: Colors.black),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.size = 50.0,
    this.itemMargin = const EdgeInsets.symmetric(
      horizontal: 4.0,
      vertical: 4.0,
    ),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.labelAlignment = Alignment.center,
    this.itemBuilder,
    this.axis = Axis.horizontal,
    this.inkWellRadius = 10,
  });
}

class _KurbanToggleButtonState extends State<KurbanToggleButton> {
  late int _currentIndex;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
    _itemKeys.addAll(
      List.generate(widget.labels.length, (index) => GlobalKey()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedItem(int index) {
    if (!_scrollController.hasClients) return;

    final RenderBox? renderBox =
        _itemKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final double itemLeftPosition = renderBox.localToGlobal(Offset.zero).dx;
    final double itemWidth = renderBox.size.width;
    final double screenWidth = MediaQuery.of(context).size.width;

    double targetScroll =
        _scrollController.offset +
        itemLeftPosition -
        (screenWidth / 2) +
        (itemWidth / 2);
    targetScroll = targetScroll.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetScroll,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.axis == Axis.horizontal
        ? SizedBox(height: widget.size, child: _buildListView())
        : SizedBox(width: widget.size, child: _buildListView());
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: widget.axis,
      itemCount: widget.labels.length,
      itemBuilder: (context, index) {
        final isSelected = _currentIndex == index;

        return Container(
          key: _itemKeys[index],
          margin: widget.itemMargin,
          child: InkWell(
            radius: widget.inkWellRadius,
            borderRadius: widget.borderRadius,
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              widget.onSelected(index);
              _scrollToSelectedItem(index);
            },
            child:
                widget.itemBuilder != null
                    ? widget.itemBuilder!(context, index, isSelected)
                    : Container(
                      padding: widget.padding,
                      alignment: widget.labelAlignment,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? widget.selectedColor
                                : widget.unselectedColor,
                        borderRadius: widget.borderRadius,
                      ),
                      child: Text(
                        widget.labels[index],
                        style:
                            isSelected
                                ? widget.selectedTextStyle
                                : widget.unselectedTextStyle,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
