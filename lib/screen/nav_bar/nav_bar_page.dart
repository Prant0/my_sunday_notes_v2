import 'package:flutter/material.dart';
import 'package:mysundaynotes/screen/nav_bar/book_page.dart';
import 'package:mysundaynotes/screen/nav_bar/categories_page.dart';
import 'package:mysundaynotes/screen/nav_bar/find_church.dart';
import 'package:mysundaynotes/screen/nav_bar/home_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';

class NavBarPage extends StatefulWidget {

  const NavBarPage({Key? key}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int selectedItem = 0;
  PageController pageController = PageController();
  List<Widget> pages = [
    HomePage(),
    CategoriesPage(id: 1),
    FindChurchPage(),
    CategoriesPage(id: 2,)
  ];

  void onPageChange(int index) {
    setState(() {
      selectedItem = index;
    });
  }


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChange,
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: BottomAppBar(
          color: blackDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(
                color: yellowDark,
                thickness: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = 0;
                        pageController.jumpToPage(selectedItem);
                      });
                    },
                    child: Image.asset(
                      "assets/Home.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = 1;
                        pageController.jumpToPage(selectedItem);
                      });
                    },
                    child: Image.asset(
                      "assets/BibleScripture.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = 2;
                        pageController.jumpToPage(selectedItem);
                      });
                    },
                    child: Image.asset(
                      "assets/Find-Church.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = 3;
                        pageController.jumpToPage(selectedItem);
                      });
                    },
                    child: Image.asset(
                      "assets/SOD.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
