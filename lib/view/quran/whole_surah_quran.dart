import 'package:moshaf/imports/imports.dart';
import 'package:quran/quran.dart' as quran;

class WholeQuranSurah extends StatelessWidget {
   WholeQuranSurah({super.key});
 String text = '${quran.getVerse(18, 1, verseEndSymbol: true)}';
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(text),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
