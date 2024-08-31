import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:moshaf/service/golobal_variabules.dart';

class QuranPageVersePreview extends StatefulWidget {
  QuranPageVersePreview(
      {Key? key, required this.indexSurah, required this.surahName})
      : super(key: key);
  final int indexSurah;
  final String surahName;

  @override
  _QuranPageVersePreviewState createState() => _QuranPageVersePreviewState();
}

class _QuranPageVersePreviewState extends State<QuranPageVersePreview> {
  List<dynamic> ayahs = [];
  List<dynamic> exegesisList = [];
  bool isLoading = true;
  int ayaNumber = 0;
  Response? exegesis;

  @override
  void initState() {
    super.initState();
    loadQuranData();
    loadQuranExegesis();
    ayahNumber(widget.indexSurah);
  }

  ayahNumber(int index) {
    for (var i = 0; i < index - 1; i++) {
      ayaNumber = surahData[i]["ayahCount"] + ayaNumber;
    }

    ;
    log(ayaNumber.toString());
  }

  Future<void> loadQuranData() async {
    try {
      // Read data from JSON file
      String fileContents = await rootBundle.loadString('assets/quran.json');
      final jsonData = jsonDecode(fileContents);

      setState(() {
        ayahs = jsonData[widget.indexSurah.toString()];
        isLoading = false;
      });
    } catch (e) {
      print("Error loading Quran data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadQuranExegesis() async {
    try {
      // Read data from JSON file
      String fileContents =
          await rootBundle.loadString('assets/ara-jalaladdinalmah.json');
      final jsonExegesis = jsonDecode(fileContents);

      setState(() {
        exegesisList = jsonExegesis["quran"];
        isLoading = false;
      });
    } catch (e) {
      print("Error loading Quran exegesis: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${widget.surahName}',
          style: TextStyle(fontFamily: 'UthmanicHafs'),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ayahs.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                      style: TextStyle(
                          fontFamily: 'UthmanicHafs',
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ayahs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  //moaaaaaaaaaaaaaaaaaaa
                                  //moaaaaaaaaaaaaaaaaaaa
                                  //moaaaaaaaaaaaaaaaaaaa
                                  //moaaaaaaaaaaaaaaaaaaa
                                  //moaaaaaaaaaaaaaaaaaaa
                                  //moaaaaaaaaaaaaaaaaaaa
                                  Dialog(
                                      child: Container(
                                    child: Text(
                                      ' ${exegesisList[ayaNumber + index]["text"]}',
                                      
                                    ),
                                  ));

                                  log('${ayaNumber + index}');
                                },
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/icon_number.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                          ),
                                          Positioned(
                                            child: Text(
                                              '${ayahs[index]['verse']}', // Verse number
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'UthmanicHafs',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          ayahs[index]['text'],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'UthmanicHafs',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 40,
                                endIndent: 40,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(child: Text('No data available')),
    );
  }
}
