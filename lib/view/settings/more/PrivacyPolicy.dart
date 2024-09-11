import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[800],
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان الصفحة
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 20),
              // مقدمة قصيرة
              Text(
                'This privacy policy explains how our app collects, uses, and protects your personal information. By using the app, you agree to the collection and use of information in accordance with this policy.',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // العناوين الفرعية والمحتوى
              _buildSectionTitle('1. Information Collection'),
              _buildSectionContent(
                  'We collect information that you provide directly to us when using the app. This includes personal details such as your name, email address, and any other information you choose to provide.'),
              _buildSectionTitle('2. Use of Information'),
              _buildSectionContent(
                  'We use the information we collect to provide, maintain, and improve the app. This includes using the information to personalize your experience and respond to your requests.'),
              _buildSectionTitle('3. Sharing of Information'),
              _buildSectionContent(
                  'We do not share your personal information with third parties, except as required by law or to protect the rights and safety of our users.'),
              _buildSectionTitle('4. Data Security'),
              _buildSectionContent(
                  'We take reasonable measures to protect your information from unauthorized access or disclosure. However, no method of transmission over the internet or electronic storage is 100% secure.'),
              _buildSectionTitle('5. Changes to This Policy'),
              _buildSectionContent(
                  'We may update this privacy policy from time to time. We encourage you to review this policy periodically for any changes.'),
              SizedBox(height: 20),
              // تاريخ آخر تحديث
              Text(
                'Last updated: September 11, 2024',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600]),
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
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal[800]),
      ),
    );
  }

  // دالة لإنشاء محتوى القسم
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
      ),
    );
  }
}
