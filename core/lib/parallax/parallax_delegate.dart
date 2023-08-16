import 'package:flutter/widgets.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;

  static const _childFirst = 0;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      Offset.zero,
      ancestor: scrollableBox,
    );

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final viewportHeight = viewportDimension - listItemBox.size.height;
    final scrollFraction = (listItemOffset.dy / viewportHeight).clamp(0.0, 1.0);
    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final childSize = context.getChildSize(_childFirst)!;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(childSize, Offset.zero & listItemSize);
    // Paint the background.
    context.paintChild(
      _childFirst,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext;
  }
}
