import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/author_sod_page.dart';
import 'package:mysundaynotes/screen/drawer/custom_drawer.dart';
import 'package:mysundaynotes/screen/nav_bar/find_church.dart';
import 'package:mysundaynotes/screen/sod_details_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  loadSODData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<HomeProvider>(context, listen: false).getSODData(
      10,
    );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    //await CustomHttpRequest.loadSODData(20, 1);
  }

  loadAllChurchData() async {
    await Provider.of<HomeProvider>(context, listen: false).getAllChurchData(
      20,
    );
    /*await Provider.of<HomeProvider>(context, listen: false)
        .loadDrawerCategories();*/
  }

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    loadSODData();
    loadAllChurchData();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        Provider.of<HomeProvider>(context, listen: false).incrementSOD();
        /*setState(() {
          pageNo= pageNo+1;
        });*/
        loadSODData();
      }
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var sodData = Provider.of<HomeProvider>(context).allSODData;
    var churchList = Provider.of<HomeProvider>(context).allChurchList;
   // var drawerList = Provider.of<HomeProvider>(context).sidebarCats;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(

        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: bodyPadding),
          width: double.infinity,
          child: sodData.isNotEmpty
              ? SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          "Today's Scripture of the Day",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SODDetailsPage(
                                    sodModel: sodData[0],
                                    allObjects: sodData,
                                  )));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Image(
                            image: NetworkImage("${sodData[0].guid}"),
                            fit: BoxFit.fill,
                            height: 120,
                            errorBuilder: (context, exception, stackTrack) =>
                                Image(
                              image: AssetImage('assets/placeholder.png'),
                              height: 100,
                            ),
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
                            style: myStyle(30, blackDark, FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Scriptire',
                                  style: myStyle(30, blackLight)),
                            ],
                          ),
                        ),
                        height: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/bibleScriptures.jpg",
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      churchList.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 150,
                              width: double.infinity,
                              color: grayClr,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Find Church",
                                    style: myStyle(25, blackDark),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  AuthorSodPage(
                                                                    id: int.parse(
                                                                        churchList[index]
                                                                            .id
                                                                            .toString()),
                                                                    title: churchList[
                                                                            index]
                                                                        .firstname,
                                                                  )));
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 35,
                                                        child: ClipRRect(
                                                          child: Container(
                                                              child: Image.network(
                                                                  churchList[
                                                                          index]
                                                                      .avatar_thumb
                                                                      .toString())),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${churchList[index].firstname ?? ""}",
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FindChurchPage()));
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 44,
                                              color: blackDark,
                                            ),
                                            Text("See all  ")
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 10,
                            ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        color: blackLight,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Most recent sods",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sodData.length,
                          itemBuilder: (context, index) {
                            DateTime postDateTime =
                                DateTime.parse(sodData[index].post_date!);
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SODDetailsPage(
                                          sodModel: sodData[index],
                                          allObjects: sodData,
                                        )));
                              },
                              child: Container(
                                color: boxColors[index % boxColors.length],
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 90,
                                        child: Image(
                                          image: NetworkImage(
                                              sodData[index].guid.toString()),
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, exception,
                                                  stackTrack) =>
                                              Image(
                                            image: AssetImage(
                                                'assets/placeholder.png'),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      flex: 3,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("  ${sodData[index].post_title}",
                                              style: myStyle(
                                                  18,
                                                  textColors[index %
                                                      textColors.length],
                                                  FontWeight.w800)),
                                          Html(
                                            data:
                                                "${sodData[index].post_content}",
                                            style: {
                                              'html': Style(
                                                  height: 65,
                                                  padding: EdgeInsets.all(0),
                                                  color: textColors[index %
                                                      textColors.length],
                                                  fontSize: FontSize.large,
                                                  fontWeight: FontWeight.w600,
                                                  maxLines: 2),
                                              'h1': Style(
                                                color: textColors[
                                                    index % textColors.length],
                                              ),
                                              'p': Style(
                                                color: textColors[
                                                    index % textColors.length],
                                              ),
                                            },
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                  " " +
                                                      postDateTime.month
                                                          .toString() +
                                                      "-" +
                                                      postDateTime.day
                                                          .toString() +
                                                      "-" +
                                                      postDateTime.year
                                                          .toString(),
                                                  style: myStyle(
                                                      14,
                                                      textColors[index %
                                                          textColors.length],
                                                      FontWeight.w800))
                                            ],
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                      flex: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: spinkit,
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                            )
                    ],
                  ),
                )
              : spinkit,
        ),
      ),
    );
  }

/*  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString =
        parse(document.body?.text).documentElement?.text;

    return parsedString;
  }*/
// df

}
