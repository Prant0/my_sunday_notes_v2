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
  const CategoriesPage({Key? key}) : super(key: key);

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

   allCategories=Provider.of<HomeProvider>(context,listen: false).allCategories;
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesShow(categories: oldCategories)));
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.28,
                child: Text(
                  "OLD Testament",
                  style: myStyle(35, yellowDark, FontWeight.w700),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7uYTAATnDRZFIycfuevfXXzAGREG89LNLM373pVcjxFDw4tJnzKW3nyjo78lLiTk6qZk&usqp=CAU"),
                        fit: BoxFit.cover)),
              ),
            ),
            
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesShow(categories: newCategories)));
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.28,
                child: Text(
                  "New Testament",
                  style: myStyle(35, yellowDark, FontWeight.w700),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8p48xzy332bgmAx4JJnK_9v8fg9W-m-TcEpfFot8yw-3LuG784Mj39XnvOE8BeErrRwA&usqp=CAU"),
                        fit: BoxFit.cover)),
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
