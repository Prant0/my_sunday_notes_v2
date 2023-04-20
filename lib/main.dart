import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/nav_bar/nav_bar_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'MySundayNotes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

       scaffoldBackgroundColor: blackDark,
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(
            color: yellowDark,
          ),

          textTheme: TextTheme(

            titleLarge:  myStyle(22,yellowDark,FontWeight.w600),
            titleMedium:  myStyle(18,yellowLight,FontWeight.w400),
            titleSmall:  myStyle(16,yellowDark,FontWeight.w600),
          )
        ),
        home: NavBarPage()
      ),
    );
  }
}