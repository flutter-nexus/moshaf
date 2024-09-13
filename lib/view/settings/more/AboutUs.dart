import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moshaf/service/Kvariables.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealBlue,
        title: Text(
          'About Us',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            // صورة عن الفريق أو الشركة
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a/ACg8ocLmeu1YUOEliGPUURTaVmTCa9gU6sSI7z5p0DkOYl7JYshJ-sA=s96-c-rg-br100'), // ضع الصورة المناسبة هنا
            ),
            SizedBox(height: 20),
            // عنوان
            Text(
              'Flutter Nexus',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: tealBlue,
              ),
            ),
            SizedBox(height: 10),
            // الوصف
            Text(
              'We are a tech-driven company focused on delivering high-quality solutions and exceptional experiences. Our mission is to innovate and create value for our customers worldwide.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            // قسم أيقونات السوشيال ميديا
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook,
                      color: Colors.blue[800], size: 30),
                  onPressed: () {
                    // رابط الفيسبوك
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter,
                      color: Colors.lightBlue, size: 30),
                  onPressed: () {
                    // رابط تويتر
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram,
                      color: Colors.pinkAccent, size: 30),
                  onPressed: () {
                    // رابط انستغرام
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin,
                      color: Colors.blueAccent, size: 30),
                  onPressed: () {
                    // رابط لينكد إن
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            // معلومات التواصل
            Card(
              color: Colors.teal[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email, color: tealBlue),
                      title: Text('Email Us', style: TextStyle(fontSize: 18)),
                      subtitle: Text('flutternexus@gmail.com'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
