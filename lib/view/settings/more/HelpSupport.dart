import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[800],
        title: Text(
          'Help & Support',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان الرئيسي
              Text(
                'How can we help?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 20),
              // وصف مختصر
              Text(
                'If you need any assistance or have questions about our services, please check our FAQ section or contact our support team.',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
              
              // قسم الأسئلة الشائعة FAQ
              _buildSectionTitle('Frequently Asked Questions (FAQ)'),
              _buildFAQItem('How do I reset my password?', 
                'To reset your password, go to the login screen, click "Forgot Password," and follow the instructions.'),
              _buildFAQItem('How do I contact support?', 
                'You can contact support through email or by calling us directly using the details below.'),
              
              SizedBox(height: 30),
              // قسم تواصل معنا
              _buildSectionTitle('Contact Us'),
              
              Card(
                color: Colors.teal[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.email, color: Colors.teal[800]),
                        title: Text('Email Support', style: TextStyle(fontSize: 18)),
                        subtitle: Text('support@company.com'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone, color: Colors.teal[800]),
                        title: Text('Call Support', style: TextStyle(fontSize: 18)),
                        subtitle: Text('+123 456 789'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // قسم متابعة على وسائل التواصل الاجتماعي
              _buildSectionTitle('Follow Us'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue[800], size: 30),
                    onPressed: () {
                      // رابط الفيسبوك
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue, size: 30),
                    onPressed: () {
                      // رابط تويتر
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pinkAccent, size: 30),
                    onPressed: () {
                      // رابط انستغرام
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blueAccent, size: 30),
                    onPressed: () {
                      // رابط لينكد إن
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal[800]),
      ),
    );
  }

  // دالة لإنشاء عنصر في قسم FAQ
  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              answer,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
