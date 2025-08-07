import 'package:flutter/material.dart';

// The Painter class does the actual drawing on the canvas.
class _DecorativePainter extends CustomPainter {
  final Animation<double> animation;

  _DecorativePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final dot1 =
        Paint()
          ..color = const Color(0xFFFED883)
          ..style = PaintingStyle.fill;

    final dot2 =
        Paint()
          ..color = const Color(0xFFC6C3FB)
          ..style = PaintingStyle.fill;

    final dot3 =
        Paint()
          ..color = const Color(0xFFFEB5BD)
          ..style = PaintingStyle.fill;

    // The animation value goes from 0.0 to 1.0, representing one full loop.
    final horizontalShift = animation.value * size.width;

    // Helper to calculate the wrapped horizontal position.
    // Using different speed factors for a parallax effect.
    double getLoopedX(double initialX, double shift, double speedFactor) {
      final position = initialX + shift * speedFactor;
      // Ensure the result is always positive for the modulo operation.
      return (position % size.width + size.width) % size.width;
    }

    canvas.drawCircle(
      Offset(
        getLoopedX(size.width * 0.76, horizontalShift, 1.0),
        size.height * 0.10,
      ),
      4,
      dot1,
    );

    canvas.drawCircle(
      Offset(
        getLoopedX(size.width * 0.90, -horizontalShift, 0.8),
        size.height * 0.15,
      ),
      6,
      dot2,
    );

    canvas.drawCircle(
      Offset(
        getLoopedX(size.width * 0.875, horizontalShift, 0.5),
        size.height * 0.22,
      ),
      2,
      dot3,
    );

    canvas.drawCircle(
      Offset(
        getLoopedX(size.width * 0.10, -horizontalShift, 1.2),
        size.height * 0.32,
      ),
      3,
      dot3,
    );
  }

  @override
  bool shouldRepaint(covariant _DecorativePainter oldDelegate) {
    // The painter should repaint if the animation object itself is different.
    return oldDelegate.animation != animation;
  }
}

// This is the widget you will use in your UI.
class DecorativeCirclesWidget extends StatefulWidget {
  final double width;
  final double height;
  final int speedFactor;

  const DecorativeCirclesWidget({
    super.key,
    this.width = 100,
    this.height = 100,
    this.speedFactor = 25,
  });

  @override
  State<DecorativeCirclesWidget> createState() =>
      _DecorativeCirclesWidgetState();
}

class _DecorativeCirclesWidgetState extends State<DecorativeCirclesWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.speedFactor),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        // The painter now uses the animation value to draw.
        painter: _DecorativePainter(animation: _animation),
      ),
    );
  }
}
