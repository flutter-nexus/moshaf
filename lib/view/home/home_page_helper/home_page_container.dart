import '../../../imports/imports.dart';

Widget buildGridItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(Get.context!).size.height * 0.19,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: tealBlue2, blurRadius: 10)],
        color: tealBlue5, // لون الخلفية
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: navyBlue),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
                color: navyBlue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
