import '../../imports/imports.dart';

class TeachingPrayScreen extends StatefulWidget {
  @override
  _TeachingPrayScreenState createState() => _TeachingPrayScreenState();
}

class _TeachingPrayScreenState extends State<TeachingPrayScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late String title;
  late List<Map<String, String>> content;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateContent();
  }

  void _updateContent() {
    setState(() {
      title = Get.arguments == 'Teaching Pray'
          ? 'Teaching Pray'
          : 'Ablution Instructions';
      content = Get.arguments == 'Teaching Pray' ? prayList : ablutionList;
    });
  }

  void _nextPage() {
    if (_currentPage < content.length - 1) {
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

  // Function to apply custom text styling for specific items
  RichText _customText(String text) {
    final List<String> highlighted = [
      'استحضار النيّة',
      'غسل الكف ثلاثاً',
      'المضمضة',
      'الاستنشاق',
      'غسل الوجه ثلاثًا',
      'غسل اليدين إلى المرفقين ثلاثًا',
      'الدعاء بعد الوضوء',
      'مسح الرأس والأذنين',
      'التسمية بالله'
    ];

    List<TextSpan> spans = [];
    int start = 0;
    for (var word in highlighted) {
      int index = text.indexOf(word, start);
      if (index != -1) {
        if (index > start) {
          spans.add(TextSpan(
            text: text.substring(start, index),
            style: TextStyle(fontSize: 18),
          ));
        }
        spans.add(TextSpan(
          text: text.substring(index, index + word.length),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ));
        start = index + word.length;
      }
    }
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(fontSize: 18),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Arial'), // Define base style here
      ),
      textDirection: TextDirection.rtl, // Apply text direction here
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateContent();
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        title: Text(title),
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
            itemCount: content.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      content[index]['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _customText(content[index]['text']!),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_currentPage > 0)
            Positioned(
              left: 16,
              bottom: 16,
              child: IconButton(
                  onPressed: _previousPage,
                  icon: Icon(Icons.keyboard_double_arrow_left_rounded)),
            ),
          if (_currentPage < content.length - 1)
            Positioned(
              right: 16,
              bottom: 16,
              child: IconButton(
                  onPressed: _nextPage, icon: Icon(Icons.double_arrow)),
            ),
        ],
      ),
    );
  }
}
