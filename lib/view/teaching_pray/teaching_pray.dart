import 'package:flutter/material.dart';
import 'package:moshaf/imports/imports.dart';

import 'pray_instructions_list.dart';

class TeachingPrayScreen extends StatefulWidget {
  @override
  _TeachingPrayScreenState createState() => _TeachingPrayScreenState();
}

class _TeachingPrayScreenState extends State<TeachingPrayScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _firstPage() {
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        title: Text('Image Text Slider'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.first_page),
            onPressed: _firstPage,
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      pages[index]['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        pages[index]['text']!,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_currentPage >
              0) // Show Previous button only if not on the first page
            Positioned(
              left: 16,
              bottom: 16,
              child: IconButton(
                  onPressed: _previousPage,
                  icon: Icon(Icons.keyboard_double_arrow_left_rounded)),
            ),
          if (_currentPage <
              pages.length - 1) // Show Next button only if not on the last page
            Positioned(
              right: 16,
              bottom: 16,
              child: IconButton(
                  onPressed: _nextPage, icon: Icon(Icons.double_arrow)),
            ),

          // if (_currentPage ==
          //     _pages.length - 1) // Show First Page button only on the last page
          //   Positioned(
          //     right: 16,
          //     bottom: 16 +
          //         56, // Offset the button to avoid overlap with the Next button
          //     child: ElevatedButton(
          //       onPressed: _firstPage,
          //       child: Text('First Page'),
          //     ),
          //   ), خليه دلوقتيممكن بعد كدا نوديه علي tasbeeh counter
        ],
      ),
    );
  }
}
