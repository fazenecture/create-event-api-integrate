import 'package:flutter/material.dart';

Widget heading(BuildContext context,
    {String text = "",
    Color? color,
    double opacity = 1,
    double txtSize = 15,
    double height = 1,
    int maxLines = 100,
    TextDecoration textDecoration = TextDecoration.none,
    FontWeight weight = FontWeight.w400,
    TextAlign align = TextAlign.left,
    double scale = 1}) {
  return Opacity(
    opacity: opacity,
    child: Text("$text",
        overflow: TextOverflow.ellipsis,
        textAlign: align,
        maxLines: maxLines,
        textScaleFactor: scale,
        style: TextStyle(
            decoration: textDecoration,
            height: height,
            fontSize: txtSize,
            color: color == null ? Colors.black : color,
            fontWeight: weight)),
  );
}

PageController controller = PageController(
  initialPage: 0,
);

Widget txtFieldContainer(BuildContext context,
    {String hintText = "",
    Function()? onEnable,
    Color color = Colors.black12,
    TextEditingController? controller,
    Color borcolor = Colors.black12,
    Widget? suffixIcon,
    FontWeight hintWeight = FontWeight.w600,
    Widget? prefixIcon,
    int maxLines = 1,
    double borthickness = 1.0,
    bool obsecure = false,
    double hintSize = 12,
    Color hintColor = Colors.black26}) {
  bool isSelected = false;
  return Row(
    children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: color == null ? hexColor("f5f5f5") : color,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: borcolor == null ? hexColor("f5f5f5") : borcolor,
                      width: borthickness == null ? 0 : borthickness)),
              child: Padding(
                padding: EdgeInsets.only(left: prefixIcon == null ? 10 : 0),
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, prefixIcon == null ? 0.0 : 3.0, 0.0),
                  child: TextField(
                    onTap: onEnable,
                    controller: controller,
                    minLines: maxLines,
                    maxLines: maxLines,
                    obscureText: obsecure,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        suffixIcon: suffixIcon,
                        prefixIcon: prefixIcon,
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                            color: hintColor,
                            fontWeight: hintWeight,
                            fontSize: hintSize)),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              )))
    ],
  );
}

Widget button1(Widget child, double radius,
    {Color color = Colors.blueAccent,
    VoidCallback? onTap,
    Color borColor = Colors.transparent,
    Color shadowColor = Colors.transparent,
    double borthickness = 0.6}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: child,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: borColor, width: borthickness),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                blurRadius: 30,
                spreadRadius: 1,
                offset: Offset(0, 30))
          ],
          borderRadius: BorderRadius.circular(radius),
          color: color),
    ),
  );
}

Widget hPadding({Widget? child}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: child,
  );
}

Color hexColor(String color) {
  int c = int.parse("0xff$color");
  return Color(c);
}

Widget navigate(
    {required BuildContext context,
    required Widget page,
    required Widget child}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: child,
  );
}

Widget SBox(BuildContext context, double hght) {
  var height = MediaQuery.of(context).size.height;
  return SizedBox(height: height * hght);
}

Widget aimage(String name, {double scale = 1, Color? color}) {
  return Image.asset(
    "images/$name.png",
    scale: scale,
    color: color,
  );
}

// var mq = MediaQuery.of(context).size;
