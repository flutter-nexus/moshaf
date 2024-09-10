import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../imports/imports.dart';

class WholeQuranSurah extends StatefulWidget {
  WholeQuranSurah(
      {super.key, this.intialPageNumber = 0, required this.surahNumber});
  int intialPageNumber;
  int surahNumber;
  @override
  State<WholeQuranSurah> createState() => _WholeQuranSurahState();
}

class _WholeQuranSurahState extends State<WholeQuranSurah> {
  final PdfViewerController _pdfViewerController =
      PdfViewerController(); // Controller for PDF library

  static const double _zoomLevel = 1; // Constant for zoom level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: tealBlue,
        title: const Text(
          'القرآن الكريم',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily:
                "UthmanicHafs", // Ensure the font is added to the project
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use LayoutBuilder to determine the Container size based on screen size
          return SfPdfViewer.asset(
            'assets/quran.pdf',
            controller: _pdfViewerController,
            maxZoomLevel: _zoomLevel,
            initialPageNumber: widget.intialPageNumber,

            initialZoomLevel:
                _zoomLevel, // Initial zoom level (can be adjusted as needed)
            pageLayoutMode: PdfPageLayoutMode.single, // Single page mode
            pageSpacing: 0, // Remove spacing between pages
            scrollDirection:
                PdfScrollDirection.horizontal, // Horizontal scrolling
            enableDoubleTapZooming: true, // Enable zoom on double tap
          );
        },
      ),
    );
  }
}
