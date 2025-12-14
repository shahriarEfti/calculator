import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback? buttonTapped;

  const MyButton({
    super.key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    this.buttonTapped,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.92),
      onTapUp: (_) {
        setState(() => scale = 1.0);
        widget.buttonTapped?.call();
      },
      onTapCancel: () => setState(() => scale = 1.0),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: widget.color,
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
