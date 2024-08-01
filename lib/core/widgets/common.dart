import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kText(
  String text, {
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = 'Ubuntu Mono',
  TextAlign textAlign = TextAlign.left,
  int? maxLines,
  Color color = Colors.black,
  TextOverflow textOverflow = TextOverflow.ellipsis,
}) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: textOverflow,
    style: GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget kHeight(double height) => SizedBox(height: height);

Widget kWidth(double width) => SizedBox(width: width);
