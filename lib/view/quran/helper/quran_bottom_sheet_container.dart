import '../../../imports/imports.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.content,
    required this.icon,
    required this.onTap,
  });
  final String content;
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: icon,
            title: Text(
              content,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              textAlign: TextAlign.right,
            ),
          )),
    );
  }
}
