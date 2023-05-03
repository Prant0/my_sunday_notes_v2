import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/nav_bar/nav_bar_page.dart';
import 'package:mysundaynotes/screen/sod_details_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main(){
  HttpOverrides.global = new MyHttpOverrides();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'MySundayNotes',
        routes: {
        //  "SODDetails":(context)=>SODDetailsPage(),

        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

       scaffoldBackgroundColor: blackDark,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: yellowDark
            ),
            color: blackDark,
            elevation: 0,
          ),
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(
            color: yellowDark,
          ),

          textTheme: TextTheme(

            titleLarge:  myStyle(tLarge,yellowDark,FontWeight.w600),
            titleMedium:  myStyle(tMedium,yellowDark,FontWeight.w400),
            titleSmall:  myStyle(tSmall,yellowDark,FontWeight.w600),
          )
        ),
        home: NavBarPage()
      ),
    );
  }
}