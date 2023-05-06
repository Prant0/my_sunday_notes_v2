import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/sod_model.dart';
import 'package:mysundaynotes/model/user_model.dart';
import 'package:mysundaynotes/screen/sod_details_page.dart';
import 'package:mysundaynotes/widget/widget.dart';

class AuthorSodPage extends StatefulWidget {
  String? title = "";
  int id;

  AuthorSodPage({Key? key, required this.id, this.title}) : super(key: key);

  @override
  _AuthorSodPageState createState() => _AuthorSodPageState();
}

class _AuthorSodPageState extends State<AuthorSodPage> {
  bool loading = true;
  List litems = [];
  int page = 1;
  bool hasMore = true;
  int limit = 5;
  bool isLoading = false;
  List<SODModel> allObjects = [];
  List<String> linkList = [];

  loadData() {
    if (isLoading) return;
   setState(() {
     isLoading = true;
   });
    CustomHttpRequest.loadSelectedAuthorData(widget.id, limit, page)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      print(value.body.toString());
      var array = json.decode(value.body.toString());
      if (array[0] != null) {

      } else {
        print("No link found");
        showInToast("No More Data Found");


      }
      for (var elem in array) {
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

          allObjects.add(sodModel);

        }

      }

      page++;

      if (mounted) {
        this.setState(() {});
      }

      if (allObjects.length > 0) loadUserData(allObjects[0].id.toString());
      print(array.length);
      if (mounted) this.setState(() {});
    });
  }

  var jsonData = {};
  var location;

  UserModel? userModel;

  loadUserData(String id) {
    CustomHttpRequest.loadUserData({'post_id': id}).then((value) {
      print(value.body.toString());
      var jsonObject = json.decode(value.body.toString());
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
          loading = false;
          jsonData = jsonObject['data'];
          location = jsonObject['google_map'];
          userModel = userMeta;
        });
      }
    });
  }

  @override
  void initState() {
    loadData();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        print("Loadinggggggggggggggggggggggggggggggggg");
        loadData();
      }
    });
  }

  final controller = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back,color: yellowDark,),
        title: Text(
          widget.title ?? "",
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
          controller: controller,
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
                          Text("${userModel!.first_name ?? ""}",
                              style: myStyle(
                                  tSmall, yellowLight, FontWeight.w700)),
                          Text("" + userModel!.service_time,
                              style: myStyle(
                                  tSmall, yellowLight, FontWeight.w700)),
                          Text("${userModel!.church_address ?? ""}",
                              style: myStyle(
                                  tSmall, yellowLight, FontWeight.w700)),
                          Text("${userModel!.email ?? ""}",
                              style: myStyle(
                                  tSmall, yellowLight, FontWeight.w700)),
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
                      color: Colors.white,
                      child: Html(
                        data: location ?? "",
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allObjects.length,
                        itemBuilder: (context, index) {

                          DateTime postDateTime =
                              DateTime.parse(allObjects[index].post_date!);
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SODDetailsPage(
                                      sodModel: allObjects[index],allObjects: allObjects,)));
                            },
                            child: Container(

                              color: boxColors[index % boxColors.length],
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 90,
                                      child:Image(
                                        image: NetworkImage("${allObjects[index].guid}"),
                                        fit: BoxFit.fill,
                                        height: 120,
                                        errorBuilder: (context, exception, stackTrack) => Image(
                                          image: AssetImage('assets/placeholder.png'),
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    flex: 3,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("  ${allObjects[index].post_title}",
                                            style: myStyle(
                                                18,
                                                textColors[
                                                    index % textColors.length],
                                                FontWeight.w800)),

                                        Html(data: "${ allObjects[index]
                                            .post_content}",
                                          style: {
                                            'html': Style(
                                                height: 65,

                                                padding: EdgeInsets.all(0),
                                                color:  textColors[
                                                index % textColors.length],
                                                fontSize: FontSize.large,
                                                fontWeight: FontWeight.w600,
                                                maxLines: 2
                                            ),
                                            'h1': Style(color: textColors[
                                            index % textColors.length],),
                                            'p': Style(color:  textColors[
                                            index % textColors.length],),

                                          },

                                        ),


                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                            Text(
                                                " " +
                                                    postDateTime.month
                                                        .toString() +
                                                    "-" +
                                                    postDateTime.day
                                                        .toString() +
                                                    "-" +
                                                    postDateTime.year
                                                        .toString(),
                                                style: myStyle(
                                                    14,
                                                    textColors[index %
                                                        textColors.length],
                                                    FontWeight.w800))
                                          ],
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                    flex: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    isLoading
                        ? Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: spinkit,
                              ),

                          ],
                        )
                        : SizedBox(
                            height: 100,
                          )

                  ],
                ),
              )
            : spinkit,
      ),
    );
  }

}
