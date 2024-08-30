import 'dart:developer';

import 'package:moshaf/imports/imports.dart';

import 'package:moshaf/view/quran/whole_surah_quran.dart';
// Assume you have a global file where surah data is stored

class QuranIndexPage extends StatelessWidget {
  static const double _cardMargin = 5.0;
  static const double _cardRadius = 15.0;
  static const double _avatarFontSize = 18.0;
  static const double _titleFontSize = 18.0;
  static const double _subtitleFontSize = 12.0;
  static const double _subtitleSpacing = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealBlue,
        title: Text(
          'فهرس القرآن الكريم',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: surahData.length,
        itemBuilder: (context, index) {
          final surah = surahData[index];
          return _SurahCard(surah: surah, index: index);
        },
      ),
    );
  }
}

class _SurahCard extends StatefulWidget {
  final Map<String, dynamic> surah;
  final int index;

  _SurahCard({required this.surah, required this.index});

  @override
  State<_SurahCard> createState() => _SurahCardState();
}

class _SurahCardState extends State<_SurahCard> {
  String? surahImage;

  @override
  Widget build(BuildContext context) {
    if (widget.surah['revelationPlace'] == "مكية") {
      surahImage = 'mecca';
    } else {
      surahImage = 'madina';
    }
    ;

    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: QuranIndexPage._cardMargin,
          vertical: QuranIndexPage._cardMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(QuranIndexPage._cardRadius),
      ),
      elevation: 10,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage('assets/images/${surahImage}.jpg'),
                fit: BoxFit.fitWidth),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(1.0),
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                '${widget.index + 1}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: QuranIndexPage._avatarFontSize),
              ),
            ),
            title: Text(
              widget.surah['name'],
              style: TextStyle(
                color: Colors.white,
                fontSize: QuranIndexPage._titleFontSize,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ترتيب النزول: ${widget.surah['revelationOrder']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: QuranIndexPage._subtitleFontSize),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: QuranIndexPage._subtitleSpacing),
                Text(
                  'عدد الآيات: ${widget.surah['ayahCount']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: QuranIndexPage._subtitleFontSize),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: QuranIndexPage._subtitleSpacing),
                Text(
                  'مكان النزول: ${widget.surah['revelationPlace']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: QuranIndexPage._subtitleFontSize),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
            onTap: () async {
              Get.bottomSheet(
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      BottomSheetContainer(
                        content: 'السورة كاملة ',
                        icon: Icon(
                          FlutterIslamicIcons.quran,
                          color: Colors.white,
                          size: 25,
                        ),
                        onTap: () {
                          Get.back();
                          Get.to(() => WholeQuranSurah());
                        },
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      BottomSheetContainer(
                        content: "آيات السورة بالتفسير",
                        icon: Icon(
                          FlutterIslamicIcons.quran2,
                          color: Colors.white,
                          size: 25,
                        ),
                        onTap: () async {
                          Get.back();
                          log('Surah tapped: ${widget.surah['name']} (Index: ${widget.index})');
                          Get.to(() => QuranPageVersePreview(
                              indexSurah: widget.index + 1,
                              surahName: widget.surah['name']));
                        },
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                isScrollControlled: true,
                enableDrag: true,
              );
            },
          ),
        ),
      ]),
    );
  }
}
