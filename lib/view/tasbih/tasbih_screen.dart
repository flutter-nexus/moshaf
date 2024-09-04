import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moshaf/service/Kvariables.dart';

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen>
    with TickerProviderStateMixin {
  bool isPlaying = true;
  int counter = 0;
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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -0.1), end: Offset.zero).animate(
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
    super.dispose();
  }

  void incrementCounter() {
    HapticFeedback.lightImpact(); // Haptic feedback for better interaction
    _controller.forward(from: 0.0);
    setState(() {
      counter++;
      isPlaying ? alignmentController.forward() : alignmentController.reverse();
      isPlaying = !isPlaying;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
      alignmentController.reset();
      _controller.reset();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Dropdown for selecting tasbeeh
                DropdownButtonFormField<String>(
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

                SizedBox(height: 40),

                // Animated Counter
                SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      '$counter',
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
          ],
        ),
      ),
    );
  }
}
