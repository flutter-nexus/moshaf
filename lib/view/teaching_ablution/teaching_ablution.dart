import 'package:flutter/material.dart';

import '../../service/navigation_bottom_bar.dart';

class TeachingAblution extends StatelessWidget {
  const TeachingAblution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        title: const Text('Teaching Ablution'),
      ),
      body: const Center(
        child: Text('Teaching Ablution'),
      ),
    );
  }
}
