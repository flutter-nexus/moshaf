import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../quran/index_quuran.dart';

class home_page_container extends StatelessWidget {
  home_page_container({
    required this.title,
    required this.subtitle,
    super.key,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(1.0),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(fontSize: 20),
                textDirection: TextDirection.rtl,
                softWrap: true,
              ),
              SizedBox(height: 4.0),
              Text(
                '',
                style: TextStyle(fontSize: 16),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 25.0),
        ),
      ),
    );
  }
}
