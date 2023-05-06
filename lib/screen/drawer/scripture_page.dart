import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/screen/web_view_activity.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class scriptureActivity extends StatefulWidget {
  String id, title;
  scriptureActivity(this.id, this.title);
  @override
  State<scriptureActivity> createState() => _scriptureActivity();
}

class Scriptures{
  String id, title, url;
  Scriptures(this.id, this.title, this.url);
}

class _scriptureActivity extends State<scriptureActivity> {

  List<Scriptures> allElems = [];
  String selectedTitle = "";
  String selectedURL = "";

  loadData(){
    allElems = [];
    var elem = {
      "parent_id": widget.id
    };
    CustomHttpRequest.loadScriptures(widget.id).then((value) {
      print(value.body.toString());
      var jsonData = json.decode(value.body.toString());
      //this.selectedTitle = jsonData['title']['rendered'].toString();
      this.selectedTitle = jsonData['title']['rendered'].toString();
      this.selectedURL = selectedTitle.replaceAll(" ", "-")+'-summary';//jsonData['link'].toString();
      selectedTitle=selectedTitle+" Summary";
      //selectedURL = selectedURL.replaceAll("https://", "https://app.");
      var gallery = jsonData['gallery_data']['gallery'];
      for(var elem in gallery){
        Scriptures scriptures = new Scriptures(elem['id'].toString(), elem['title'].toString(), elem['src'].toString());
        allElems.add(scriptures);
      }
      this.setState(() {

      });
    });
  }

  @override
  void initState() {
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(


        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: yellowDark,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text(widget.title, style: TextStyle(
            color: yellowDark
        ),),
        shadowColor: Colors.transparent,
        backgroundColor: blackDark,
        foregroundColor: Colors.white,

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Route route = MaterialPageRoute(builder: (context) => WebViewActivity("https://mysundaynotes.com/"+selectedURL));
                  Navigator.push(context, route);
                },
                child: Text("$selectedTitle", style: TextStyle(
                  fontSize: 22,color: yellowDark,
                  fontWeight: FontWeight.bold,

                ),),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height /2.8),
                ),
                itemCount: allElems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){

                      _showMyDialog(index);
                    },
                    child: Card(
                      color: blackLight,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(image: NetworkImage(allElems[index].url),
                              fit: BoxFit.fill,
                              errorBuilder: (context, exception, stackTrack) => Icon(Icons.error,),
                            ),

                            Text(allElems[index].title, maxLines: 1,style: Theme.of(context).textTheme.titleSmall,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(dynamic index) async {
    int shareIndex =index;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear,
                              color: Colors.white,
                              size: 28,)))),
                Container(
                  margin: EdgeInsets.all(15),
                  child: CarouselSlider.builder(
                    itemCount: allElems.length,
                    options: CarouselOptions(
                      onPageChanged: (index, reason){
                        shareIndex=index;
                      },
                      initialPage: index,
                      enlargeCenterPage: true,
                      height: 200,
                      autoPlay: false,
                      reverse: false,
                      aspectRatio: 5.0,
                    ),
                    itemBuilder: (context, i, id){
                      //for onTap to redirect to another screen
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white,)
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(image: NetworkImage(allElems[i].url,),
                            width: 500,
                            fit: BoxFit.fill,
                            errorBuilder: (context, exception, stackTrack) => Icon(Icons.error,),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(yellowDark),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(
                          color: yellowDark,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                  child: Text('Share'),
                  onPressed: () {
                    shareImage(allElems[shareIndex]);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }



  void shareImage(elem) async {
    final response = await get(Uri.parse(elem.url));
    final bytes = response.bodyBytes;
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/tempImage.png');
    imageFile.writeAsBytesSync(response.bodyBytes);
    //Share.share("text");
    Share.shareFiles(['${temp.path}/tempImage.png'], text: elem.title,);
  }
}
