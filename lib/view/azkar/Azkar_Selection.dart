import 'package:flutter/material.dart';
import 'package:moshaf/view/azkar/azkar%20view/all_azkar.dart';
import '../../imports/imports.dart';

class Supplications extends StatelessWidget {
  Supplications({super.key});
  List<String> choices = ['azkar_sabah', 'PostPrayer_azkar', 'azkar_massa'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأذكار',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: tealBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoiceItem(
                context, '  أذكار الصباح  ', Icons.wb_sunny, Colors.orange, () {
              Get.to(AzkaeAlSabahScreen(
                fileName: choices[0],
              ));
            }),
            const SizedBox(height: 20),
            _buildChoiceItem(
                context, 'أذكار الصلاة', Icons.access_time, Colors.green, () {
              Get.to(AzkaeAlSabahScreen(
                fileName: choices[1],
              ));
            }),
            const SizedBox(height: 20),
            _buildChoiceItem(context, '  أذكار المساء  ',
                Icons.nightlight_round, Colors.blue, () {
              Get.to(AzkaeAlSabahScreen(
                fileName: choices[2],
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceItem(BuildContext context, String title, IconData icon,
      Color color, Function onTap) {
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
          onTap();
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
