import 'package:flutter/material.dart';

class TradeSlidingButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double buttonHeight;
  final double dragThreshold;

  const TradeSlidingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonHeight = 64,
    this.dragThreshold = 0.7,
  });

  @override
  State<TradeSlidingButton> createState() => _TradeSlidingButtonState();
}

class _TradeSlidingButtonState extends State<TradeSlidingButton> {
  double _dragPosition = 0;
  bool _isDragging = false;
  double _maxDragDistance = 0;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(
        0,
        _maxDragDistance,
      );
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragPosition / _maxDragDistance > widget.dragThreshold) {
      widget.onPressed();
    }
    setState(() {
      _dragPosition = 0;
      _isDragging = false;
    });
  }

  bool get _isThresholdReached =>
      _dragPosition / _maxDragDistance > widget.dragThreshold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxDragDistance = constraints.maxWidth - widget.buttonHeight;
        return Container(
          height: widget.buttonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Color(0xFF9EA3B1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragStart:
                    (_) => setState(() => _isDragging = true),
                child: Container(
                  height: widget.buttonHeight,
                  width: widget.buttonHeight,
                  margin: EdgeInsets.only(left: _dragPosition),
                  decoration: BoxDecoration(
                    gradient:
                        _isThresholdReached
                            ? const LinearGradient(
                              colors: [Color(0xFF4A3F56), Color(0xFF8B7898)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    color: _isThresholdReached ? null : Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child:
                          _isThresholdReached
                              ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                                key: ValueKey('check'),
                              )
                              : const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 32,
                                key: ValueKey('chevron'),
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
