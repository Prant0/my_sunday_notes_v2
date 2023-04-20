import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sodData;

  loadSODData() async {
    await Provider.of<HomeProvider>(context, listen: false).getSODData(20, 1);
  }

  loadAllChurchData() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .getAllChurchData(20, 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSODData();
    loadAllChurchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sodData = Provider.of<HomeProvider>(context).allSODData;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: bodyPadding),
          width: double.infinity,
          child: sodData.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.menu,
                                color: yellowDark,
                                size: 30,
                              )),
                          SizedBox(
                            width: 100,
                          ),
                          Image.asset("assets/app_logo.png"),
                        ],
                      ),
                    ),
                    Divider(
                      color: yellowDark,
                      thickness: 3,
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Today's Scripture of the Day",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      child: Image(
                        image: NetworkImage("${sodData[0].guid}"),
                        fit: BoxFit.cover,
                        errorBuilder: (context, exception, stackTrack) => Image(
                          image: AssetImage('assets/placeholder.png'),
                          height: 140,
                        ),
                      ),
                    ),
                    Divider(
                      color: yellowDark,
                      thickness: 1.5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          text: 'bible ',
                          style:myStyle(30,blackDark,FontWeight.bold),
                          children:   <TextSpan>[
                            TextSpan(text: 'Scriptire', style: myStyle(30,blackLight)),

                          ],
                        ),
                      ),
                      height: 90,
                      decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage("assets/bibleScriptures.jpg",)
                      ,fit: BoxFit.cover),),
                    ),
                    Text(
                      "Find Church",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                )
              : spinkit,
        ),
      ),
    );
  }
}
