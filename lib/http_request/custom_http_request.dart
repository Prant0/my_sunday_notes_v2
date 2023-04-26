import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mysundaynotes/model/author_model.dart';
import 'package:mysundaynotes/model/sod_model.dart';
import 'package:mysundaynotes/widget/widget.dart';

class CustomHttpRequest {
  static Future<dynamic> loadSODData(int limit, int page) async {
    print("Page no isssssssssssssssssssss$page");
    List<SODModel> allObjectsList = [];
    print("starttttttt");

    var url =
        "${baseUrl}posts?per_page=$limit&page=$page"; //Constants.baseURL + "explore_frame.php";
    var responce = await http.get(Uri.parse(url));
    print("responce status code is ${responce.statusCode} ");
    var data = json.decode(responce.body.toString());
    print("all SOD data areeeeeeeee$data");
    if (data[0] != null) {
      print("  link found");
      for (var elem in data) {
        if (elem['x_featured_media_large'] != null) {
          SODModel sodModel = new SODModel(
            id: elem['id'].toString(),
            post_author: elem['author'].toString(),
            post_date: elem['date'].toString(),
            post_content: elem['content']['rendered'].toString(),
            post_title: elem['title']['rendered'].toString(),
            guid: elem['x_featured_media_large'].toString(),
            post_name: elem['x_categories'].toString(),
            c_date: elem['x_metadata']['c_date'].toString(),
            c_day: elem['x_metadata']['c_day'].toString(),
            link: elem["link"],
          );
          allObjectsList.add(sodModel);
        }
      }
    } else {
      print("No link found");
    }
    return allObjectsList;
  }


  static Future<dynamic> loadAllChurchData(int limit, int page) async {
    List<Authors> allChurchList = [];
    var url =
        "https://mysundaynotes.com/wp-json/wp/v2/users?per_page=$limit&page=$page"; //Constants.baseURL + "search_authors.php";
    var responce = await http.get(Uri.parse(url));
    print("responce status code is ${responce.statusCode} ");
    var elem = json.decode(responce.body);
   // print("All church data areee $elem");
    for (var i in elem) {
      Authors auth = Authors(
          id: i['id'].toString(),
          firstname: i['name'].toString(),
          lastname: i['last_name'].toString(),
          bio: i['description'].toString(),
          avatar_thumb: i['avatar_urls']['96'].toString(),
          photo:i['simple_local_avatar']!=null? i['simple_local_avatar']["full"].toString() :"no photo pranto",

      );
      allChurchList.add(auth);
    }
    return allChurchList;
  }
}
