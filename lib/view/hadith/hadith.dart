import '../../imports/imports.dart';

class Hadith extends StatefulWidget {
  const Hadith({super.key});

  @override
  _HadithState createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hadith"),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Center(
          child: Text("Hadith"),
        ));
  }
}
