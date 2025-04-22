import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final String label;
  final Color color;

  const Chips({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      shape: const StadiumBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
