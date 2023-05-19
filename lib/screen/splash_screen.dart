import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/nav_bar/nav_bar_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String notificationAlert = "";
  loadDrawer() async {
    await Provider.of<HomeProvider>(context, listen: false).getSODData(
      15,
    );
    await Provider.of<HomeProvider>(context, listen: false).getAllChurchData(
      20,
    );
    await Provider.of<HomeProvider>(context, listen: false)
        .loadDrawerCategories();
    await Provider.of<HomeProvider>(context, listen: false).loadCategories();
  }

  @override
  void initState() {
    loadDrawer();
    Future.delayed(Duration(seconds: 3), () {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>NavBarPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackDark,


        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/app_logo.png",
                  height: 180,
                ),

                SizedBox(
                  height:20,
                ),

                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NavBarPage()));
                  },
                  child: Text(
                    "enter",
                    style: myStyle(25,yellowDark,FontWeight.w800),
                  ),


                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
