import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moshaf/service/Kvariables.dart';
import 'package:moshaf/service/shared_prefrece.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> with TickerProviderStateMixin {
  bool isPlaying = true;
  late Map<String, int> counters;
  String selectedTasbeeh = "سبحان الله";
  List<String> tasbeehList = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله"
  ];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController alignmentController;
  late Animation<AlignmentGeometry> alignmentAnimation;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppPreferences().init();
    counters = {}; // Initialize counters with an empty map
    loadCustomTasbeehList().then((_) {
      loadCounters();
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    alignmentController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    alignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
    ).animate(alignmentController);
  }

  @override
  void dispose() {
    _controller.dispose();
    alignmentController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    HapticFeedback.lightImpact(); // Haptic feedback for better interaction
    _controller.forward(from: 0.0);

    setState(() {
      counters[selectedTasbeeh] = (counters[selectedTasbeeh] ?? 0) + 1;
      isPlaying ? alignmentController.forward() : alignmentController.reverse();
      isPlaying = !isPlaying;
      AppPreferences().saveInt(selectedTasbeeh, counters[selectedTasbeeh]!);
    });
  }

  void resetCounter() {
    setState(() {
      counters[selectedTasbeeh] = 0;
      alignmentController.reset();
      _controller.reset();
      AppPreferences().saveInt(selectedTasbeeh, 0);
    });
  }

  void addCustomTasbeeh() async {
    String newTasbeeh = _textEditingController.text.trim();
    if (newTasbeeh.isNotEmpty && !tasbeehList.contains(newTasbeeh)) {
      setState(() {
        tasbeehList.add(newTasbeeh);
        counters[newTasbeeh] = 0;
        _textEditingController.clear();
      });
      await saveCustomTasbeehList();
    }
  }

  Future<void> saveCustomTasbeehList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasbeehList', tasbeehList);
  }

  Future<void> loadCustomTasbeehList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedTasbeehList = prefs.getStringList('tasbeehList');
    if (savedTasbeehList != null) {
      setState(() {
        tasbeehList = savedTasbeehList;
      });
    }
  }

  Future<void> loadCounters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, int> loadedCounters = {};
    for (var tasbeeh in tasbeehList) {
      int? counter = prefs.getInt(tasbeeh);
      loadedCounters[tasbeeh] = counter ?? 0;
    }
    setState(() {
      counters = loadedCounters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التسبيح',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            AlignTransition(
              alignment: alignmentAnimation,
              child: CircleAvatar(
                backgroundColor: tealBlue,
                radius: 30,
                child: Text(
                  selectedTasbeeh,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  // Dropdown for selecting tasbeeh
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedTasbeeh,
                      alignment: Alignment.centerRight,
                      items: tasbeehList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTasbeeh = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'اختر التسبيح',
                        hintText: 'اختر التسبيح',
                        prefixIcon: Icon(Icons.book, color: tealBlue),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // TextField for adding custom tasbeeh
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'أضف تسبيح جديد',
                        hintText: 'أدخل التسبيح الجديد',
                        prefixIcon: Icon(Icons.add, color: tealBlue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Button to add custom tasbeeh
                  ElevatedButton(
                    onPressed: addCustomTasbeeh,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: tealBlue,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: tealBlue.withOpacity(0.5),
                      elevation: 10,
                    ),
                    child: Text(
                      'أضف التسبيح',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Animated Counter
                  SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Text(
                        '${counters[selectedTasbeeh]}',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: tealBlue,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Tasbeeh Button
                  ElevatedButton(
                    onPressed: incrementCounter,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: tealBlue,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: tealBlue.withOpacity(0.5),
                      elevation: 10,
                    ),
                    child: Text(
                      'عدّد التسبيح',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Reset Button
                  OutlinedButton(
                    onPressed: resetCounter,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      side: BorderSide(color: Colors.redAccent, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'إعادة تعيين',
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}