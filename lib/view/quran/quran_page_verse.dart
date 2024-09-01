import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
import 'package:moshaf/service/golobal_variabules.dart';

import '../../imports/imports.dart';

class QuranPageVersePreview extends StatefulWidget {
  final int indexSurah;
  final String surahName;

  const QuranPageVersePreview({
    Key? key,
    required this.indexSurah,
    required this.surahName,
  }) : super(key: key);

  @override
  _QuranPageVersePreviewState createState() => _QuranPageVersePreviewState();
}

class _QuranPageVersePreviewState extends State<QuranPageVersePreview> {
  List<dynamic> ayahs = [];
  List<dynamic> exegesisList = [];
  bool isLoading = true;
  int ayaNumber = 0;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    loadQuranData();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> loadQuranData() async {
    setState(() => isLoading = true);

    try {
      // تحميل بيانات القرآن والتفسير في نفس الوقت
      final quranData = await rootBundle.loadString('assets/quran.json');
      final exegesisData =
          await rootBundle.loadString('assets/ara-jalaladdinalmah.json');

      final quranJson = jsonDecode(quranData);
      final exegesisJson = jsonDecode(exegesisData);

      setState(() {
        ayahs = quranJson[widget.indexSurah.toString()] ?? [];
        exegesisList = exegesisJson["quran"] ?? [];
        ayaNumber = calculateAyahNumber(widget.indexSurah);
        isLoading = false;
      });
    } catch (e) {
      log("Error loading data: $e");
      setState(() => isLoading = false);
    }
  }

  int calculateAyahNumber(int index) {
    return surahData
        .sublist(0, index - 1)
        .fold(0, (prev, element) => prev + element["ayahCount"] as int);
  }

  Future<void> playAudio(int index) async {
    if (ayahs.isEmpty) return;

    try {
      final url =
          "https://cdn.islamic.network/quran/audio/64/ar.alafasy/${ayaNumber + index + 1}.mp3";
      await player.setUrl(url);
      await player.play();
    } catch (e) {
      log("Error playing audio: $e");
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
          widget.surahName,
          style: TextStyle(fontFamily: 'UthmanicHafs', color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ayahs.isNotEmpty
              ? ListView.builder(
                  itemCount: ayahs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            Get.bottomSheet(
                              buildBottomSheet(index),
                              isScrollControlled: true,
                            );
                            // await playAudio(index);
                          },
                          title: buildAyahTile(index),
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
                )
              : Center(child: Text('No data available')),
    );
  }

  Widget buildAyahTile(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/icon_number.png',
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
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
    );
  }

  Widget buildBottomSheet(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: ()async {
                    
                    
                    await playAudio(index);
                  },
                  icon: Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: ()async{
                   await  player.pause();
                   
                  } ,
                  icon: Icon(Icons.pause),
                ),
                IconButton(
                  onPressed: ()  async {
                    await player.stop();
                  },
                  icon: Icon(Icons.stop),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6),
        Divider(color: Colors.grey, thickness: 2),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            '${exegesisList[ayaNumber + index]["text"]}',
            style: TextStyle(
              fontSize: 22,
              fontFamily: "UthmanicHafs",
              color: navyBlue,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
