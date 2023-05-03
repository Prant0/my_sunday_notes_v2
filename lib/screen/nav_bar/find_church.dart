import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/search_church_List_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class FindChurchPage extends StatefulWidget {
  const FindChurchPage({Key? key}) : super(key: key);

  @override
  _FindChurchPageState createState() => _FindChurchPageState();
}

class _FindChurchPageState extends State<FindChurchPage> {
  @override
  Widget build(BuildContext context) {
    var churchList = Provider.of<HomeProvider>(context).allChurchList;
    return Scaffold(
      backgroundColor: grayClr,
      appBar: AppBar(
        backgroundColor: grayClr,
        leading: Icon(Icons.arrow_back,color: blackCLr,),
        centerTitle: true,
        title: Text("Find Church",style: myStyle(20,blackDark),),
      ),
      body: Container(

        child: Column(
          children: [
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  labelStyle: TextStyle(
                      color: !emailFocusNode.hasFocus
                          ? Colors.grey
                          : Colors.blueGrey),
                  labelText: 'Search',
                ),
                textInputAction: TextInputAction.search,
                autocorrect: false,
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: searchController,
                onSubmitted: (search) {
                  //searchChurches(search);
                },
              ),
            ),*/
            MaterialButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchChurchList()));
            },
              color: blackDark,
              padding: EdgeInsets.symmetric(horizontal: 26,vertical: 10),
            child: Text("Search Find Church",style: Theme.of(context).textTheme.titleLarge,),
            ),
            Flexible(
              child: GridView.builder(
                controller: controller,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.0),
                ),
                itemCount: churchList.length,
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
                              child: Image.network( churchList[index].avatar_thumb.toString()),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                      Text("${churchList[index].firstname ?? ""}",
                        maxLines: 2,textAlign: TextAlign.center,
                        style: myStyle(tMedium,blackDark,FontWeight.w800)),
                          Align(
                            alignment: Alignment.center,
                            child:  Text("${churchList[index].bio ?? ""}",
                              maxLines: 1,textAlign: TextAlign.center,
                                style: myStyle(tSmall,blackDark,FontWeight.bold)),
                            ),

                        ],
                      ),
                    ),
                  );


                },
              ),
            )
          ],
        ),
      ),
    );
  }
  final controller = ScrollController();
  FocusNode emailFocusNode = new FocusNode();
  TextEditingController searchController = new TextEditingController();
}
