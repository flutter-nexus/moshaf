import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  bool isLoading = true;
   Map<String, dynamic> exegesis = {};

  @override
  void initState() {
    super.initState();
    loadQuranData();
    fetchExegesis();
  }

  Future<Map<String, dynamic>> getExegesisSurah() async {
    final dio = Dio();
    final response = await dio.get(
      'https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/ara-jalaladdinalmah.min.json',
    );
     exegesis =await response.data;
    return response.data;
  }

  Future<void> fetchExegesis() async {
    try {
      exegesis = await getExegesisSurah();
      setState(() {}); // Refresh UI after fetching data
    } catch (e) {
      print("Error fetching exegesis data: $e");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.surahName}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ayahs.isNotEmpty
              ? ListView.builder(
                  itemCount: ayahs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                             
                              if (exegesis != null) {
                                var quranText = exegesis['quran'][ayahs[index]]['text'];
                                log(quranText);
                              } else {
                                log('Exegesis data not available');
                              }
                            } catch (e) {
                              log('Error accessing exegesis data: $e');
                            }
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    Positioned(
                                      child: Text(
                                        '${ayahs[index]['verse']}', // Verse number
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
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
                                    style: TextStyle(fontSize: 24),
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
                )
              : Center(child: Text('No data available')),
    );
  }
}
