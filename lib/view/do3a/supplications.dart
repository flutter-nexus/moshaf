import '../../imports/imports.dart';

class Supplications extends StatelessWidget {
  const Supplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        title: const Text('Supplications'),
      ),
      body: const Center(
        child: Text('Supplications'),
      ),
    );
  }
}
