import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mysundaynotes/http_request/custom_http_request.dart';
import 'package:mysundaynotes/model/author_model.dart';
import 'package:mysundaynotes/widget/widget.dart';

class SearchChurchList extends StatefulWidget {
  @override
  State<SearchChurchList> createState() => _SearchChurchListState();
}

class _SearchChurchListState extends State<SearchChurchList> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: grayClr,
        appBar: AppBar(
          backgroundColor: grayClr,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back,),
            color: blackCLr,
          ),
          centerTitle: true,
          title: Text(
            "Find Church",
            style: myStyle(20, blackDark),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    hintText: "Type search name",
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        searchNode=[];
                        searchController.clear();
                      });
                    },
                    icon: Icon(Icons.cancel),
                  )
                  ),

                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  obscureText: false,
                  style: myStyle(20,blackDark,FontWeight.w600),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onSubmitted: (search) {
                    searchChurches(search);
                  },
                ),
              ),

              Flexible(
                child: GridView.builder(

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.0),
                  ),
                  itemCount: searchNode.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                child: Image.network( searchNode[index].avatar_thumb.toString()),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("${searchNode[index].firstname ?? ""}",
                                maxLines: 2,textAlign: TextAlign.center,
                                style: myStyle(tMedium,blackDark,FontWeight.w800)),
                            Align(
                              alignment: Alignment.center,
                              child:  Text("${searchNode[index].bio ?? ""}",
                                  maxLines: 1,textAlign: TextAlign.center,
                                  style: myStyle(tSmall,blackDark,FontWeight.bold)),
                            ),

                          ],
                        ),
                      ),
                    );


                  },
                ) ,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Authors> searchNode = [];

  FocusNode emailFocusNode = new FocusNode();

  TextEditingController searchController = new TextEditingController();

  bool isLoading=false;
  searchChurches(searches) {
    searchNode = [];
   // var query = {'search': searches};
    setState(() {
      isLoading=true;
    });
    CustomHttpRequest.searchAuthors(searches).then((value) {
      setState(() {
        isLoading=false;
      });

       print(value.body.toString());
      List elem = json.decode(value.body.toString());
      if(elem.isEmpty){
      showInToast("Opps ! No Data Found");
      }else{
        for (var individual in elem) {
          //  print(elem);
          Authors auth = Authors(
              id: individual['id'].toString(),
              firstname:  individual['name'].toString(),
              lastname:  individual['last_name'].toString(),
              bio: individual['description'].toString(),
              avatar_thumb:  individual['avatar_urls']['96'].toString());
          if (individual['simple_local_avatar'] != null) {
            photoList.add(individual['simple_local_avatar']["full"].toString());
          } else {
            showInToast("Opps! No Data Found");

            photoList.add(null);
          }
          searchNode.add(auth);

        }
      }

      if (mounted) {
        this.setState(() {});
      }
    });
  }
  List photoList = [];
}
