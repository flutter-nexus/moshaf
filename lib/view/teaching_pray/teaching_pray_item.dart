import 'package:flutter/material.dart';

class TeachingPrayItem extends StatelessWidget {
  const TeachingPrayItem({
    super.key,
    required this.text,
    required this.image,
  });
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/teaching_pray_images/$image.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
            softWrap: true,
            overflow: TextOverflow.visible,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
