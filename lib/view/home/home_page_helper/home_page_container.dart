import 'package:flutter/material.dart';

class home_page_container extends StatelessWidget {
  home_page_container({
    required this.title,
    required this.subtitle,
    super.key,
    required this.onTap,
    required this.image,
    required this.titleColor,
  });
  final String title;
  final String subtitle;
  final Function() onTap;
  final String image;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: AssetImage('assets/slider_images/${image}.jpg'),
                fit: BoxFit.cover),
            color: Colors.white),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(1.0),
          title: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 20,
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
            softWrap: true,
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 25.0),
        ),
      ),
    );
  }
}
