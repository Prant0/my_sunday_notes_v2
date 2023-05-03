import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mysundaynotes/model/author_model.dart';
import 'package:mysundaynotes/model/sod_model.dart';
import 'package:mysundaynotes/widget/widget.dart';

class CustomHttpRequest {
  static Future<dynamic> loadSODData(int limit, int page) async {
    print("Page no isssssssssssssssssssss$page");
    List<SODModel> allObjectsList = [];


    var url =
        "${baseUrl}posts?per_page=$limit&page=$page"; //Constants.baseURL + "explore_frame.php";
    var responce = await http.get(Uri.parse(url));


   // print("all SOD data areeeeeeeee$data");

    return responce;
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


  static Future loadUserData(queryParams) {
    var url = baseUrl2 + "load_usermeta.php";
    return http.post(Uri.parse(url), body: queryParams);
  }

  static Future searchAuthors(queryParams) {
    //var url="https://mysundaynotes.com/wp-json/wp/v2/users?per_page=2&page=3";
    var url = "https://mysundaynotes.com/wp-json/wp/v2/users?search=$queryParams";//Constants.baseURL + "search_authors.php";
    return http.get(Uri.parse(url));
  }

}
