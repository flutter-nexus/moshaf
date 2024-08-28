import 'package:flutter/material.dart';

class FullScreenSlider extends StatefulWidget {
  @override
  _FullScreenSliderState createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/slide1.jpg',
      'text': 'This is the first slide',
    },
    {
      'image': 'assets/slide2.jpg',
      'text': 'This is the second slide',
    },
    {
      'image': 'assets/slide3.jpg',
      'text': 'This is the third slide',
    },
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      setState(() {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        _slides[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _slides[index]['text']!,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: _previousPage,
              child: Text('Previous'),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}