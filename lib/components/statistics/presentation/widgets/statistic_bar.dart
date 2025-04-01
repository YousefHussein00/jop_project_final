import 'package:flutter/material.dart';

class StatisticBar extends StatelessWidget {
  final String label;
  final int value;
  final int total;

  const StatisticBar({
    super.key,
    required this.label,
    required this.value,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: total > 0 ? value / total : 0,
              minHeight: 20,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[300]!),
            ),
          ),
          const SizedBox(height: 5),
          Text(value.toString(), textAlign: TextAlign.end),
        ],
      ),
    );
  }
}
