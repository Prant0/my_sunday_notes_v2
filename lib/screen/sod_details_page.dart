import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/sod_model.dart';
import 'package:mysundaynotes/model/user_model.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class SODDetailsPage extends StatefulWidget {
  SODModel sodModel;


  SODDetailsPage({Key? key, required this.sodModel}) : super(key: key);

  @override
  State<SODDetailsPage> createState() => _SODDetailsPageState();
}

class _SODDetailsPageState extends State<SODDetailsPage> {
  @override
  void initState() {
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    var sodData = Provider.of<HomeProvider>(context).allSODData;
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back,color: yellowDark,),
        title: Text(
          "The Title Church",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Icon(
            Icons.share,
            color: yellowDark,
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: userModel != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            //radius: 50,
                            maxRadius: 50,
                            backgroundImage: NetworkImage(
                                "${imageUrl}${userModel!.avatar_thumb}"),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "${userModel!.display_name}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "${userModel!.bio}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("upcoming",
                            style: myStyle(tSmall, grayClr, FontWeight.w700)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(bodyPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${userModel!.first_name ??""}",
                              style: myStyle(tSmall, yellowLight, FontWeight.w700)),
                          Text("" + userModel!.service_time,
                              style: myStyle(tSmall, yellowLight, FontWeight.w700)),
                          Text( "${userModel!.church_address??""}",
                              style: myStyle(tSmall, yellowLight, FontWeight.w700)),

                          Text( "${userModel!.email??""}",
                              style: myStyle(tSmall, yellowLight, FontWeight.w700)),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: yellowDark,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Come Join Us at Church",
                        style: myStyle(tSmall, blackDark),
                      ),
                    ),
                    Container(
                      height: 120,
                      color: Colors.white,
                      child: Html(
                        data: "${jsonData['_oembed_9d87a71b9eb5dd957f85182e00f94b05']??""}",
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: blackDark,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Today's Scripture of the day",
                        style: myStyle(tSmall, yellowLight),
                      ),
                    ),
                    Container(
                      color: yellowLight,
                      padding: EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "${widget.sodModel.guid}",
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: blackLight,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.sodModel.post_title??""}",
                            style:
                                myStyle(tMedium, yellowDark, FontWeight.bold),
                          ),
                          Text(
                            "${widget.sodModel.c_date}",
                            style: myStyle(tSmall, grayClr, FontWeight.bold),
                          ),
                          Text(
                            "${widget.sodModel.c_day}",
                            style: myStyle(tSmall, grayClr, FontWeight.bold),
                          ),
                          Text(
                            "${jsonData['c_s_title']??""}",
                            style: myStyle(tSmall, grayClr, FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: yellowLight,
                      child: Html(
                        data: "${widget.sodModel.post_content??""}",
                        style: {
                          'html': Style(
                              fontSize: FontSize.large,
                              fontWeight: FontWeight.w600),
                          'h1': Style(color: Colors.blue),
                          'p': Style(color: Colors.black),
                        },
                      ),
                    ),

                    /*Html(
                      data: "${widget.sodModel.post_content}",
                    ),*/
                    Container(
                      width: double.infinity,
                      color: blackLight,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Related SOD",
                              style: myStyle(tLarge, yellowDark,FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 12,),

                          Container(height: 170,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:5,
                                  itemBuilder: (context, index) {

                                    return InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 12),
                                        width: 140,
                                        child: Column(
                                          children: [


                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ClipRRect(
                                                  child: Image(image: NetworkImage("${sodData[index].guid}"),
                                                    fit: BoxFit.cover,
                                                    height: 110,
                                                    width: 200,
                                                    errorBuilder: (context, exception, stackTrack) => Image(image: AssetImage('assets/placeholder.png')
                                                      ,fit: BoxFit.cover
                                                      , height: 110,

                                                      width: 200,
                                                    ),
                                                  ),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text("${sodData[index].post_title??""}", maxLines: 1,
                                                style: Theme.of(context).textTheme.titleSmall,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : spinkit,
      ),
    );
  }

  loadUserData() {
    String id = widget.sodModel.id.toString();
    print("xp $id");
    setState(() {
      isLoading = true;
    });
    CustomHttpRequest.loadUserData({'post_id': id}).then((value) {
      print("soddddddddddddddddddddddddddddddddd ${value.statusCode}");
      print("soddddddddddddddddddddddddddddddddd ${value.body}");
      var jsonObject = jsonDecode(value.body.toString());
      print("json data isssssssssssssss$jsonObject");
      UserModel userMeta = UserModel(
          jsonObject['user_id'].toString(),
          jsonObject['username'].toString(),
          jsonObject['email'].toString(),
          jsonObject['first_name'].toString(),
          jsonObject['last_name'].toString(),
          jsonObject['avatar_thumb'].toString(),
          jsonObject['banner_thumb'].toString(),
          jsonObject['display_name'].toString(),
          jsonObject['bio'].toString(),
          jsonObject['service_time'].toString(),
          jsonObject['church_address'].toString(),
          jsonObject['phone'].toString());

      if (mounted) {
        setState(() {
          isLoading = false;
          jsonData = jsonObject['data'];
          userModel = userMeta;
          print("id isssssssssssssssssssssssssss${userModel!.id}");
        });
      }
    });
  }

  UserModel? userModel;
  var jsonData = {};
  bool isLoading = false;
}



