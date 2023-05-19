import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/category_model.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/categories_show.dart';
import 'package:mysundaynotes/screen/drawer/custom_drawer.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  int id;
  CategoriesPage({Key? key,required this.id}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
 // List<CategoryModel> allCategories = [];

  List newArray = [
    'Matthew',
    'Mark',
    'Luke',
    'John',
    'Acts',
    'Romans',
    '1 Corinthians',
    '2 Corinthians',
    'Galatians',
    'Ephesians',
    'Philippians',
    'Colossians',
    'Thessalonians',
    'Timothy',
    'Titus',
    'Philemon',
    'Hebrews',
    'James',
    'Peter',
    '1-2-3 John',
    'Jude',
    'Revelation'
  ];


  List<CategoryModel> newCategories = [];
  List<CategoryModel> oldCategories = [];
  updateCategories() {
    allCategories.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });



    for (int i = 0; i < allCategories.length; i++) {

      newArray.contains(allCategories[i].title)
          ? newCategories.add(allCategories[i])
          : oldCategories.add(allCategories[i]);

    }


    this.setState(() {

    });

    print("Total length of old is ${oldCategories.length}");



  }

  @override
  void initState() {

   allCategories=widget.id==1? Provider.of<HomeProvider>(context,listen: false).sidebarCats:Provider.of<HomeProvider>(context,listen: false).allCategories;
    updateCategories();

  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  final controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
            //Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
          color: yellowDark,
        ),
        centerTitle: true,
        title: Text(
          "SOD Studys",
          style: myStyle(25,yellowDark,FontWeight.w800),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesShow(categories: oldCategories,id: widget.id)));
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Text(
                      widget.id==1?"OLD Testament":"SOD Studies",
                style: TextStyle(
                        inherit: true,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: yellowDark,
                        shadows: [
                          Shadow( // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: blackLight
                          ),
                          Shadow( // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: blackLight
                          ),
                          Shadow( // topRight
                              offset: Offset(1.5, 5.5),
                              color: blackLight
                          ),
                          Shadow( // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: blackLight
                          ),
                        ]
                    ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/old1.png"),fit: BoxFit.fill
                            )),
                  ),
                  Positioned(child: Text(widget.id==1? "":"Old Testament",style:Theme.of(context).textTheme.titleMedium),
                    top: 30,
                    right: 35,
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesShow(categories: newCategories,id: widget.id,)));
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Text(
                      widget.id==1?"New Testament":  "SOD Studies",
                      style: TextStyle(
                          inherit: true,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                          color: yellowDark,
                          shadows: [
                            Shadow( // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: blackLight
                            ),
                            Shadow( // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: blackLight
                            ),
                            Shadow( // topRight
                                offset: Offset(1.5, 5.5),
                                color: blackLight
                            ),
                            Shadow( // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: blackLight
                            ),
                          ]
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/new1.png"),fit: BoxFit.fill)),
                  ),
                  Positioned(child: Text(widget.id==1? "":"New Testament",style:Theme.of(context).textTheme.titleMedium),
                    bottom: 30,
                    right: 35,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<CategoryModel> allCategories = [];
  int page=1;
  bool hasMore=true;
  int limit=40;
  bool isLoading =false;

/*
  loadCategories() {
    if(isLoading) return;
    isLoading=true;
    CustomHttpRequest.loadCategories(limit,page).then((value) {
      //print(value.body.toString());
      var jsonData = json.decode(value.body.toString());
      for (var element in jsonData) {
        CategoryModel cat = new CategoryModel();
        cat.fromJson(element);
        allCategories.add(cat);
        // print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx${cat.title}");
      }
      setState(() {
        page++;

        isLoading=false;
        print("page isssssssss$page");
        print("eeeeeeeeeeee${jsonData}");
        if(jsonData.isEmpty){
          setState(() {
            hasMore=false;
          });
          print("Has no more data $hasMore");
        }

      });

      allCategories.sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });



      for (int i = 0; i < allCategories.length; i++) {

        newArray.contains(allCategories[i].title)
            ? newCategories.add(allCategories[i])
            : oldCategories.add(allCategories[i]);

      }



      if (mounted) {
        this.setState(() {});
      }
      print("Old length is ${oldCategories.length}");
    });
  }

  Future refresh()async{
    setState(() {
      isLoading=false;
      hasMore=false;
      page=1;
      allCategories.clear();
    });
    loadCategories();
  }*/


}
