import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/author_model.dart';
import 'package:mysundaynotes/model/sod_model.dart';

class HomeProvider with ChangeNotifier {
  List<SODModel> allSODData = [];
  List<Authors> allChurchList = [];

  int pageNo = 1;

  incrementSOD() {
    pageNo = pageNo + 1;
    notifyListeners();
  }

  Future<dynamic> getSODData(
    int limit,
  ) async {
    //  allSODData=await CustomHttpRequest.loadSODData(limit, page);
    final responce = await CustomHttpRequest.loadSODData(limit, pageNo);
    var data = json.decode(responce.body.toString());

    if (data[0] != null) {
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
          try {
            allSODData.firstWhere((element) => element.post_title ==elem['title']['rendered'].toString());
          } catch (e) {
            allSODData.add(sodModel);
          }

        }
      }
    } else {
      print("No link found");
    }

    //  allSODData.addAll(await CustomHttpRequest.loadSODData(limit, pageNo));
    notifyListeners();
    print("Total length of all sod is ${allSODData.length}");
  }

  getAllChurchData(int limit, page) async {
    allChurchList = await CustomHttpRequest.loadAllChurchData(limit, page);
    notifyListeners();
  }
}
