import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final double percent;

  const CircularIndicator({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    this.percent = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 8.0,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      progressColor: color,
    );
  }
}