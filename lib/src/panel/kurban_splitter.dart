import 'package:flutter/material.dart';

class KurbanSplitter extends StatefulWidget {
  const KurbanSplitter({
    super.key,
    this.direction = Axis.horizontal,
    required this.child1,
    required this.child2,
    this.initialFirstFraction = 0.5,
    this.minFirstFraction = 0.1,
    this.maxFirstFraction = 0.9,
    this.splitterThickness = 4.0,
    this.splitterColor,
    this.splitterDecoration,
    this.enabled = true,
    this.onResizeStart,
    this.onResizeUpdate,
    this.onResizeEnd,
    this.resizeCursor,
    this.onResetSize,
  }) : assert(
         splitterColor == null || splitterDecoration == null,
         'Cannot provide both splitterColor and splitterDecoration',
       );

  final Axis direction;
  final Widget child1;
  final Widget child2;
  final double initialFirstFraction;
  final double minFirstFraction;
  final double maxFirstFraction;
  final double splitterThickness;
  final Color? splitterColor;
  final Decoration? splitterDecoration;
  final bool enabled;
  final ValueChanged<double>? onResizeStart;
  final ValueChanged<double>? onResizeUpdate;
  final ValueChanged<double>? onResizeEnd;
  final MouseCursor? resizeCursor;
  final VoidCallback? onResetSize;

  @override
  State<KurbanSplitter> createState() => _KurbanSplitterState();
}

class _KurbanSplitterState extends State<KurbanSplitter> {
  late final ValueNotifier<double> _firstFractionNotifier;
  double? _startPosition;
  double? _lastFraction;

  @override
  void initState() {
    super.initState();
    _firstFractionNotifier = ValueNotifier(widget.initialFirstFraction);
  }

  @override
  void didUpdateWidget(KurbanSplitter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFirstFraction != oldWidget.initialFirstFraction) {
      _firstFractionNotifier.value = widget.initialFirstFraction;
    }
  }

  @override
  void dispose() {
    _firstFractionNotifier.dispose();
    super.dispose();
  }

  void _handleDragStart(double position) {
    if (!widget.enabled) return;
    _startPosition = position;
    _lastFraction = _firstFractionNotifier.value;
    widget.onResizeStart?.call(_firstFractionNotifier.value);
  }

  void _handleDragUpdate(double position, double size) {
    if (!widget.enabled || _startPosition == null) return;
    final delta = position - _startPosition!;

    _firstFractionNotifier.value = (_lastFraction! + delta / size).clamp(
      widget.minFirstFraction,
      widget.maxFirstFraction,
    );
    widget.onResizeUpdate?.call(_firstFractionNotifier.value);
  }

  void _handleDragEnd() {
    if (!widget.enabled || _startPosition == null) return;
    widget.onResizeEnd?.call(_firstFractionNotifier.value);
    _startPosition = null;
    _lastFraction = null;
  }

  void _handleDoubleTap() {
    if (!widget.enabled) return;
    _firstFractionNotifier.value = widget.initialFirstFraction;
    widget.onResetSize?.call();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size =
            widget.direction == Axis.horizontal
                ? constraints.maxWidth
                : constraints.maxHeight;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragStart:
              widget.direction == Axis.horizontal
                  ? (details) => _handleDragStart(details.localPosition.dx)
                  : null,
          onVerticalDragStart:
              widget.direction == Axis.vertical
                  ? (details) => _handleDragStart(details.localPosition.dy)
                  : null,
          onHorizontalDragUpdate:
              widget.direction == Axis.horizontal
                  ? (details) =>
                      _handleDragUpdate(details.localPosition.dx, size)
                  : null,
          onVerticalDragUpdate:
              widget.direction == Axis.vertical
                  ? (details) =>
                      _handleDragUpdate(details.localPosition.dy, size)
                  : null,
          onHorizontalDragEnd:
              widget.direction == Axis.horizontal
                  ? (_) => _handleDragEnd()
                  : null,
          onVerticalDragEnd:
              widget.direction == Axis.vertical
                  ? (_) => _handleDragEnd()
                  : null,
          onDoubleTap: _handleDoubleTap,
          child: ValueListenableBuilder<double>(
            valueListenable: _firstFractionNotifier,
            builder: (context, firstFraction, child) {
              return Flex(
                direction: widget.direction,
                children: [
                  Flexible(
                    flex: (firstFraction * 1000).round(),
                    child: widget.child1,
                  ),
                  MouseRegion(
                    cursor:
                        widget.enabled
                            ? widget.resizeCursor ??
                                (widget.direction == Axis.horizontal
                                    ? SystemMouseCursors.resizeColumn
                                    : SystemMouseCursors.resizeRow)
                            : SystemMouseCursors.basic,
                    child: Container(
                      width:
                          widget.direction == Axis.horizontal
                              ? widget.splitterThickness
                              : null,
                      height:
                          widget.direction == Axis.vertical
                              ? widget.splitterThickness
                              : null,
                      decoration:
                          widget.splitterDecoration ??
                          BoxDecoration(
                            color: widget.splitterColor ?? Colors.grey,
                          ),
                    ),
                  ),
                  Flexible(
                    flex: ((1 - firstFraction) * 1000).round(),
                    child: widget.child2,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
