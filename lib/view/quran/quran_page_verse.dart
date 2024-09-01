import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
import 'package:moshaf/service/golobal_variabules.dart';

import '../../imports/imports.dart';

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
  late AudioPlayer player; // Declare the player once

  @override
  void initState() {
    super.initState();
    player = AudioPlayer(); // Initialize the player once
    loadQuranData();
    loadQuranExegesis();
    calculateAyahNumber(widget.indexSurah);
  }

  @override
  void dispose() {
    player.dispose(); // Dispose of the player when the widget is disposed
    super.dispose();
  }

  void calculateAyahNumber(int index) {
    ayaNumber = surahData.sublist(0, index - 1).fold(0, (prev, element) => prev + element["ayahCount"] as int);
    log(ayaNumber.toString());
  }

  Future<void> loadQuranData() async {
    try {
      String fileContents = await rootBundle.loadString('assets/quran.json');
      final jsonData = jsonDecode(fileContents);

      ayahs = jsonData[widget.indexSurah.toString()];
    } catch (e) {
      print("Error loading Quran data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadQuranExegesis() async {
    try {
      String fileContents = await rootBundle.loadString('assets/ara-jalaladdinalmah.json');
      final jsonExegesis = jsonDecode(fileContents);

      exegesisList = jsonExegesis["quran"];
    } catch (e) {
      print("Error loading Quran exegesis: $e");
    }
  }

  Future<void> playAudio(int index) async {
    try {
      final url = "https://cdn.islamic.network/quran/audio/64/ar.alafasy/${ayaNumber + index + 1}.mp3";
      await player.setUrl(url);
      await player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: tealBlue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '${widget.surahName}',
          style: TextStyle(fontFamily: 'UthmanicHafs', color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ayahs.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(height: 22),
                    Text(
                      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                      style: TextStyle(
                          fontFamily: 'UthmanicHafs',
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 22),
                    Expanded(
                      child: ListView.separated(
                        itemCount: ayahs.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                          thickness: 2,
                          indent: 40,
                          endIndent: 40,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              Get.bottomSheet(
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    ' ${exegesisList[ayaNumber + index]["text"]},',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "UthmanicHafs",
                                        color: navyBlue),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                isScrollControlled: true,
                              );
                              await playAudio(index);
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
                                          '${ayahs[index]['verse']}',
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
