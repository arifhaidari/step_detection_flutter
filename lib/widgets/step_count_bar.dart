import 'package:flutter/material.dart';

class StepCountBar extends StatelessWidget {
  final int leftValue;
  final int rightValue;

  const StepCountBar({
    super.key,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBar('Left Steps:', leftValue, Colors.redAccent),
        const SizedBox(height: 5),
        _buildBar('Right Steps:', rightValue, Colors.blueAccent),
      ],
    );
  }

  Widget _buildBar(String label, int value, Color color) {
    return Stack(
      children: [
        Container(
          height: 25,
          width: value.toDouble() * 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Positioned(
          left: 10,
          top: 5,
          child: Text(
            '$label $value',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
