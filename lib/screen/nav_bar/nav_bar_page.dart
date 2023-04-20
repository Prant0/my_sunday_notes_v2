import 'package:flutter/material.dart';
import 'package:mysundaynotes/screen/nav_bar/book_page.dart';
import 'package:mysundaynotes/screen/nav_bar/categories_page.dart';
import 'package:mysundaynotes/screen/nav_bar/find_church.dart';
import 'package:mysundaynotes/screen/nav_bar/home_page.dart';
import 'package:mysundaynotes/widget/widget.dart';


class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int selectedItem=0;
  PageController pageController=PageController();
  List<Widget> pages=[
    HomePage(),
    BookPage(),
    FindChurchPage(),
    CategoriesPage()
  ];

  void onPageChange(int index){
    setState(() {
      selectedItem=index;
    });
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
        height: MediaQuery.of(context).size.height *0.1,
        child: BottomAppBar(
          color: blackDark,
          child: Column(
            children: [
              Divider(
                color: yellowDark,
                thickness: 3,
                endIndent: bodyPadding,
                indent: bodyPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      selectedItem=0;
                      pageController.jumpToPage(selectedItem);
                    });
                  }, icon: Icon(Icons.ac_unit)),
                  IconButton(onPressed: (){
                    setState(() {
                      selectedItem=1;
                      pageController.jumpToPage(selectedItem);
                    });
                  }, icon: Icon(Icons.ac_unit)),

                  IconButton(onPressed: (){
                    setState(() {
                      selectedItem=2;
                      pageController.jumpToPage(selectedItem);
                    });
                  }, icon: Icon(Icons.ac_unit)),
                  IconButton(onPressed: (){
                    setState(() {
                      selectedItem=3;
                      pageController.jumpToPage(selectedItem);
                    });
                  }, icon: Icon(Icons.ac_unit)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
