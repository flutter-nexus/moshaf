<<<<<<< HEAD
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
=======
>>>>>>> 41662ca83b452c35fccf34b7caed4d7ef308e954
import 'package:moshaf/imports/imports.dart';
import 'package:pdfrx/pdfrx.dart';

class WholeQuranSurah extends StatefulWidget {
  const WholeQuranSurah({super.key});

  @override
  State<WholeQuranSurah> createState() => _WholeQuranSurahState();
}

class _WholeQuranSurahState extends State<WholeQuranSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdfrx example'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: PdfViewer.asset(
                initialPageNumber: 2,
                params: PdfViewerParams(
                  
                ),
            'assets/quran.pdf',
            controller: PdfViewerController(),
          ))),
    );
  }
}