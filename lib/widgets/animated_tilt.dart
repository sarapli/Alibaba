import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class AnimatedTilt extends StatefulWidget {
  const AnimatedTilt({
    super.key,
    required this.child,
    this.maxTilt = 0.14,
    this.perspective = 0.0016,
    this.duration = const Duration(milliseconds: 450),
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final double maxTilt;
  final double perspective;
  final Duration duration;
  final Curve curve;

  @override
  State<AnimatedTilt> createState() => _AnimatedTiltState();
}

class _AnimatedTiltState extends State<AnimatedTilt> {
  Offset _target = Offset.zero;

  void _setTarget(Offset localPosition, Size size) {
    final dx = ((localPosition.dx / size.width) - 0.5) * 2;
    final dy = ((localPosition.dy / size.height) - 0.5) * 2;
    setState(() {
      _target = Offset(dx.clamp(-1, 1), dy.clamp(-1, 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final tiltX = -_target.dy * widget.maxTilt;
        final tiltY = _target.dx * widget.maxTilt;

        return MouseRegion(
          onHover: (e) => _setTarget(e.localPosition, size),
          onExit: (_) => setState(() => _target = Offset.zero),
          child: GestureDetector(
            onPanDown: (d) => _setTarget(d.localPosition, size),
            onPanUpdate: (d) => _setTarget(d.localPosition, size),
            onPanEnd: (_) => setState(() => _target = Offset.zero),
            onPanCancel: () => setState(() => _target = Offset.zero),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: widget.duration,
              curve: widget.curve,
              builder: (context, t, child) {
                final m = Matrix4.identity()
                  ..setEntry(3, 2, widget.perspective)
                  ..rotateX(tiltX)
                  ..rotateY(tiltY)
                  ..translateByVector3(
                    Vector3(0.0, 0.0, 6.0 * (1 - math.min(1, t))),
                  );

                return Transform(
                  alignment: Alignment.center,
                  transform: m,
                  child: child,
                );
              },
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
