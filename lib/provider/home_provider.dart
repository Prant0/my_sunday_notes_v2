import 'package:flutter/material.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/author_model.dart';
import 'package:mysundaynotes/model/sod_model.dart';

class HomeProvider with ChangeNotifier{


  List<SODModel> allSODData = [];
  List<Authors> allChurchList = [];

  getSODData(int limit, page)async{
  //  allSODData=await CustomHttpRequest.loadSODData(limit, page);
    allSODData.addAll(await CustomHttpRequest.loadSODData(limit, page));
    notifyListeners();
    print("Total length of all sod is ${allSODData.length}");
  }

  getAllChurchData(int limit, page)async{
    allChurchList=await CustomHttpRequest.loadAllChurchData(limit, page);
    notifyListeners();
  }

}