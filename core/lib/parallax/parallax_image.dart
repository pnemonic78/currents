import 'package:flutter/widgets.dart';

import 'parallax_delegate.dart';

/// https://docs.flutter.dev/cookbook/effects/parallax-scrolling
class ParallaxImage extends StatelessWidget {
  final double extent;
  final Widget child;

  const ParallaxImage({
    super.key,
    required this.extent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scrollable = Scrollable.maybeOf(context);

    return SizedBox(
      height: extent,
      child: (scrollable != null)
          ? Flow(
              delegate: ParallaxFlowDelegate(
                scrollable: scrollable,
                listItemContext: context,
              ),
              children: [child],
            )
          : child,
    );
  }
}
