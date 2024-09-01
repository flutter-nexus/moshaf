import '../../../imports/imports.dart';

Widget buildGridItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required double width,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(Get.context!).size.height * 0.17,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/peakpx.jpg"),
          fit: BoxFit.fill,
        ),
        boxShadow: [BoxShadow(color: tealBlue2, blurRadius: 10)],
        color: tealBlue5, // لون الخلفية
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.white),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "UthmanicHafs"),
          ),
        ],
      ),
    ),
  );
}
