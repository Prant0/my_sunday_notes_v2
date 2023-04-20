

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


const String baseUrl="https://mysundaynotes.com/wp-json/wp/v2/";

const Color blackCLr =Colors.black;
const Color blackDark =Color(0xff231f20);
const Color blackLight =Color(0xff3d423e);
const Color yellowDark =Color(0xfffff200);
const Color yellowLight =Color(0xfff9f4a8);
const Color grayClr =Color(0xffe6e7e8);


const double bodyPadding=16;


const spinkit = SpinKitRotatingCircle(
color: yellowDark,
size: 50.0,
);

myStyle(double size,[Color ?clr,FontWeight ?fw]){
  return GoogleFonts.roboto(
    fontSize: size,
    color: clr,
    fontWeight: fw
  );
}
