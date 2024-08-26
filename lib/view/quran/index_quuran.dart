import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:moshaf/service/golobal_variabules.dart'; // Assume you have a global file where surah data is stored

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
      appBar: AppBar(
        title: Text('فهرس القرآن الكريم'),
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

class _SurahCard extends StatelessWidget {
  final Map<String, dynamic> surah;
  final int index;

  _SurahCard({required this.surah, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: QuranIndexPage._cardMargin,
          vertical: QuranIndexPage._cardMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(QuranIndexPage._cardRadius),
      ),
      elevation: 10,
      child: Stack(children: <Widget>[
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Image.asset(
        //     width: MediaQuery.of(context).size.width * 0.2,
        //     height: MediaQuery.of(context).size.height * 0.2,
        //     'assets/images/madina.png',
        //   ),
        // ),
        ListTile(
          contentPadding: EdgeInsets.all(1.0),
          leading: CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: QuranIndexPage._avatarFontSize),
            ),
          ),
          title: Text(
            surah['name'],
            style: TextStyle(
              fontSize: QuranIndexPage._titleFontSize,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ترتيب النزول: ${surah['revelationOrder']}',
                style: TextStyle(fontSize: QuranIndexPage._subtitleFontSize),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: QuranIndexPage._subtitleSpacing),
              Text(
                'عدد الآيات: ${surah['ayahCount']}',
                style: TextStyle(fontSize: QuranIndexPage._subtitleFontSize),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: QuranIndexPage._subtitleSpacing),
              Text(
                'مكان النزول: ${surah['revelationPlace']}',
                style: TextStyle(fontSize: QuranIndexPage._subtitleFontSize),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
          onTap: () {
            log('Surah tapped: ${surah['name']} (Index: $index)');
          },
        ),
      ]),
    );
  }
}
