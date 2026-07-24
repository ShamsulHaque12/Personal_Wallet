import 'package:flutter/material.dart';

class Flipping3DListItem extends StatefulWidget {
  final Widget child;
  final int index;
  const Flipping3DListItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<Flipping3DListItem> createState() => _Flipping3DListItemState();
}

class _Flipping3DListItemState extends State<Flipping3DListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // Stagger delay based on list index to create a cascading entrance!
    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value;
        final angle = (1.0 - value) * 0.4; // 3D rotate on X-axis from ~23 degrees
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.9 + 0.1 * value,
            alignment: Alignment.center,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(angle),
              alignment: Alignment.center,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
