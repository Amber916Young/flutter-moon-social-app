import 'package:flutter/material.dart';

const redOrange = Color(0xffb93303);

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    this.size = 25,
  });

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: redOrange.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
