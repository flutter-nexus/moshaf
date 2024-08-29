import 'package:moshaf/imports/imports.dart';

class WholeQuranSurah extends StatelessWidget {
  const WholeQuranSurah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('القرآن الكريم'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
