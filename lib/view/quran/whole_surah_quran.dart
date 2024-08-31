import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:moshaf/imports/imports.dart';
import 'package:quran/quran.dart' as quran;

class WholeQuranSurah extends StatefulWidget {
  WholeQuranSurah({super.key});

  @override
  State<WholeQuranSurah> createState() => _WholeQuranSurahState();
}

class _WholeQuranSurahState extends State<WholeQuranSurah> {
  List<String> verses = [];

  @override
  void initState() {
    super.initState();
    fetchQuranPageText();
  }

  Future<void> fetchQuranPageText() async {
    List<String> fetchedVerses = [];
    for (int i = quran.getVerseCountByPage(2) + 1; i <= quran.getVerseCountByPage(3); i++) {
      fetchedVerses.add(await quran.getVerse(2, i, verseEndSymbol: true));
    }

    setState(() {
      verses = fetchedVerses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        centerTitle: true,
      ),
      body: verses.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  textDirection: TextDirection.rtl,
                  children: verses.map((verse) {
                    return Text(
                      verse + ' ',
                      style: GoogleFonts.amiri(fontSize: 15),
                      textAlign: TextAlign.justify,
                    );
                  }).toList(),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
