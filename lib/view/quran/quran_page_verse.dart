import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuranPageVersePreview extends StatefulWidget {
  QuranPageVersePreview({Key? key, required this.indexSurah}) : super(key: key);
  int indexSurah;
  @override
  _QuranPageVersePreviewState createState() => _QuranPageVersePreviewState();
}

class _QuranPageVersePreviewState extends State<QuranPageVersePreview> {
  List<dynamic> ayahs = [];

  @override
  void initState() {
    super.initState();
    loadQuranData();
  }

  Future<void> loadQuranData() async {
    // قراءة البيانات من ملف JSON
    String fileContents = await rootBundle.loadString('assets/quran.json');
    final jsonData = jsonDecode(fileContents);

    setState(() {
      ayahs = jsonData['${widget.indexSurah}'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran'),
      ),
      body: ayahs.isNotEmpty
          ? ListView.builder(
              itemCount: ayahs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
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
                                  '${ayahs[index]['verse']}', // رقم الآية
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black), // حجم الرقم ولونه
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
          : Center(child: CircularProgressIndicator()),
    );
  }
}
