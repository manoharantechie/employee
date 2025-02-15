import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomWidget {
  final BuildContext context;

  CustomWidget({required this.context});


  TextStyle CustomTextStyle(Color color, FontWeight weight, String family) {
    return GoogleFonts.roboto(
        fontWeight: weight, color: color, fontSize: 13.0);
  }

  TextStyle CustomSizedTextStyle(
      double size, Color color, FontWeight weight, String family) {
    return GoogleFonts.roboto(
        fontWeight: weight, color: color, fontSize: size);
  }


}
