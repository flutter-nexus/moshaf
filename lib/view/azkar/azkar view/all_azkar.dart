import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:moshaf/imports/imports.dart';

class AzkaeAlSabahScreen extends StatefulWidget {
  AzkaeAlSabahScreen({super.key, required this.fileName});
  String fileName;
  String title = '';
  @override
  _AzkaeAlSabahScreenState createState() => _AzkaeAlSabahScreenState();
}

class _AzkaeAlSabahScreenState extends State<AzkaeAlSabahScreen> {
  List<ZekrModel> azkarList = [];

  @override
  void initState() {
    super.initState();
    loadAzkar();
  }

  Future<void> loadAzkar() async {
    // تحميل بيانات JSON من الملف
    final jsonData = await rootBundle.rootBundle
        .loadString('assets/json/${widget.fileName}.json');
    final decodedData = json.decode(jsonData);

    setState(() {
      widget.title = decodedData['title'];
      azkarList = (decodedData['content'] as List)
          .map((item) => ZekrModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '${widget.title}',
          style: TextStyle(color: Colors.white, fontFamily: "UthmanicHafs"),
        ),
        backgroundColor: tealBlue,
      ),
      body: azkarList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: azkarList.length,
              itemBuilder: (context, index) {
                final zekr = azkarList[index];
                return ZekrWidget(zekr: zekr);
              },
            ),
    );
  }
}

class ZekrModel {
  String zekr;
  int repeat;
  String bless;

  ZekrModel({required this.zekr, required this.repeat, required this.bless});

  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(
      zekr: json['zekr'],
      repeat: json['repeat'],
      bless: json['bless'],
    );
  }
}

class ZekrWidget extends StatelessWidget {
  final ZekrModel zekr;

  ZekrWidget({required this.zekr});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              zekr.zekr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              "عدد التكرار: ${zekr.repeat}",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
            if (zekr.bless.isNotEmpty) ...[
              SizedBox(height: 10),
              Text(
                zekr.bless,
                style: TextStyle(fontSize: 14, color: Colors.green),
                textAlign: TextAlign.right,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
