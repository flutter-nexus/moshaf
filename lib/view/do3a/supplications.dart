import 'package:flutter/material.dart';
import '../../imports/imports.dart';

class Supplications extends StatelessWidget {
  const Supplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Supplications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: tealBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoiceItem(
              context,
              '  Azkar Al-Sabah  ',
              Icons.wb_sunny,
              Colors.orange,
            ),
            const SizedBox(height: 20),
            _buildChoiceItem(
              context,
              'Post Prayer Azkar',
              Icons.access_time,
              Colors.green,
            ),
            const SizedBox(height: 20),
            _buildChoiceItem(
              context,
              '  Azkar Al-Massa  ',
              Icons.nightlight_round,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceItem(
      BuildContext context, String title, IconData icon, Color color) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          // Handle item tap
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: $title')),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
