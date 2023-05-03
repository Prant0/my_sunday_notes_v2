

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


const String baseUrl="https://mysundaynotes.com/wp-json/wp/v2/";
const String baseUrl2 = "https://apis.mysundaynotes.com/apis/";
const String imageUrl = "https://mysundaynotes.com/wp-content/uploads/";

const String demoImage="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80";


const Color blackCLr =Colors.black;
const Color blackDark =Color(0xff231f20);
const Color blackLight =Color(0xff3d423e);
const Color yellowDark =Color(0xfffff200);
const Color yellowLight =Color(0xfff9f4a8);
const Color grayClr =Color(0xffe6e7e8);


const double bodyPadding=16;
const double tSmall=16;
const double tMedium=20;
const double tLarge=20;



List boxColors = [yellowLight,blackLight];
List textColors = [blackDark,yellowDark];

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

showInToast(String text){
  return Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
