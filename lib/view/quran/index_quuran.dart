import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moshaf/service/golobal_variabules.dart'; // Assume you have a global file where surah data is stored

class QuranIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فهرس القرآن الكريم'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: surahData
            .length, // Using surahData list containing more detailed information
        itemBuilder: (context, index) {
          final surah = surahData[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: ListTile(
              contentPadding: EdgeInsets.all(1.0),
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              title: Text(
                surah['name'],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    'عدد الآيات: ${surah['ayahCount']}',
                    style: TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'مكان النزول: ${surah['revelationPlace']}',
                    style: TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
              onTap: () {
                log('surah tapped: ${surah['name']}');
              },
            ),
          );
        },
      ),
    );
  }
}
