import 'package:flutter/material.dart';
import 'package:mysundaynotes/model/category_model.dart';
import 'package:mysundaynotes/screen/author_sod_page.dart';
import 'package:mysundaynotes/screen/nav_bar/sub_categories_show.dart';
import 'package:mysundaynotes/widget/widget.dart';

class CategoriesShow extends StatelessWidget {
  List<CategoryModel> categories;

  CategoriesShow({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            color: yellowDark,
          ),
          centerTitle: true,
          title: Text(
            "SOD Studys",
            style: myStyle(25, yellowDark, FontWeight.w800),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                print("id isssssssss${categories[index].id}");
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Sub_Categories_Show(
                          id: int.parse(categories[index].id.toString()),
                          title: categories[index].title,
                        )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                    child: Text(
                      "${categories[index].title}",
                      style: myStyle(22, yellowDark, FontWeight.w900),
                    ),
                    decoration: BoxDecoration(
                        color: blackLight,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: NetworkImage(""), fit: BoxFit.cover)),
                  ),
                );
              }),
        ));
  }
}
