import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class WholeQuranSurah extends StatefulWidget {
  const WholeQuranSurah({super.key});

  @override
  State<WholeQuranSurah> createState() => _WholeQuranSurahState();
}

class _WholeQuranSurahState extends State<WholeQuranSurah> {
  final PdfViewerController _pdfViewerController =
      PdfViewerController(); // تعريف الـ Controller لمكتبة الـ PDF

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'القرآن الكريم',
          style: TextStyle(
              fontFamily: "UthmanicHafs"), // تأكد من أن الخط مضاف في المشروع
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // استخدام LayoutBuilder لتحديد حجم الـ Container بناءً على حجم الشاشة
          return SfPdfViewer.asset(
            'assets/quran.pdf',
            controller: _pdfViewerController,
            initialZoomLevel:
                1.0, // مستوى التكبير الابتدائي (يمكنك تعديله حسب الحاجة)
            pageLayoutMode: PdfPageLayoutMode.single, // وضع الصفحة الفردية
            pageSpacing: 0, // إزالة المسافات بين الصفحات
            scrollDirection: PdfScrollDirection.horizontal, // التمرير الأفقي
            enableDoubleTapZooming: true, // تمكين التكبير عند النقر المزدوج
          );
        },
      ),
    );
  }
}
