import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tilt3DContainer extends StatefulWidget {
  final Widget child;
  const Tilt3DContainer({super.key, required this.child});

  @override
  State<Tilt3DContainer> createState() => _Tilt3DContainerState();
}

class _Tilt3DContainerState extends State<Tilt3DContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  double _tiltX = 0.0;
  double _tiltY = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationX = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _animationY = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addListener(() {
      setState(() {
        _tiltX = _animationX.value;
        _tiltY = _animationY.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;

    // Convert local position to -1.0 to 1.0 percent values
    final percentX = (dx / size.width) * 2 - 1.0;
    final percentY = (dy / size.height) * 2 - 1.0;

    // Limit maximum tilt angle to ~8 degrees (0.14 radians)
    setState(() {
      _tiltX = -percentY.clamp(-1.0, 1.0) * 0.12;
      _tiltY = percentX.clamp(-1.0, 1.0) * 0.12;
    });
  }

  void _onPanEnd() {
    _animationX = Tween<double>(begin: _tiltX, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _animationY = Tween<double>(begin: _tiltY, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onPanUpdate: (details) => _onPanUpdate(details, size),
          onPanEnd: (_) => _onPanEnd(),
          onPanCancel: _onPanEnd,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective coefficient
              ..rotateX(_tiltX)
              ..rotateY(_tiltY),
            alignment: FractionalOffset.center,
            child: Stack(
              children: [
                widget.child,
                // Moving shine/reflection overlay
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          begin: Alignment(
                            _tiltY * 2.5 - 0.5,
                            _tiltX * 2.5 - 0.5,
                          ),
                          end: Alignment(
                            -_tiltY * 2.5 + 0.5,
                            -_tiltX * 2.5 + 0.5,
                          ),
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.08),
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.08),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
