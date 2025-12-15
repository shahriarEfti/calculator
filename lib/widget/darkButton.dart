import 'package:flutter/material.dart';

class DarkModeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DarkModeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: onPressed,
    );
  }
}
