import 'package:flutter/material.dart';
import 'package:mysundaynotes/provider/home_provider.dart';
import 'package:mysundaynotes/screen/author_sod_page.dart';
import 'package:mysundaynotes/screen/drawer/custom_drawer.dart';
import 'package:mysundaynotes/screen/search_church_List_page.dart';
import 'package:mysundaynotes/widget/widget.dart';
import 'package:provider/provider.dart';

class FindChurchPage extends StatefulWidget {
  const FindChurchPage({Key? key}) : super(key: key);

  @override
  _FindChurchPageState createState() => _FindChurchPageState();
}

class _FindChurchPageState extends State<FindChurchPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var churchList = Provider.of<HomeProvider>(context).allChurchList;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: grayClr,
      appBar: AppBar(
        backgroundColor: grayClr,
        leading: IconButton(
          onPressed: (){
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,),
          color: blackCLr,
        ),
        centerTitle: true,
        title: Text(
          "Find Church",
          style: myStyle(20, blackDark),
        ),
      ),
      body: Container(
        child: Column(
          children: [

            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchChurchList()));
              },
              color: blackDark,
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              child: Text(
                "Search Find Church",
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AuthorSodPage(
                                id: int.parse(churchList[index].id.toString()),
                                title: churchList[index].firstname,
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 50,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              child: Image.network(
                                  churchList[index].avatar_thumb.toString()),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),

                          Text("${churchList[index].firstname ?? ""}",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style:
                                  myStyle(tMedium, blackDark, FontWeight.w800)),
                          Align(
                            alignment: Alignment.center,
                            child: Text("${churchList[index].bio ?? ""}",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: myStyle(
                                    tSmall, blackDark, FontWeight.bold)),
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

  bool isLoading=false;
  int pageNo=1;
  loadChurchList() async {
    setState(() {
      isLoading=true;
    });
    await Provider.of<HomeProvider>(context, listen: false).getAllChurchData(20,  );
    if(mounted){
      setState(() {
        isLoading=false;
      });
    }
    //await CustomHttpRequest.loadSODData(20, 1);
  }
  @override
  void initState() {
    loadChurchList();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        Provider.of<HomeProvider>(context,listen: false).incrementChurch();

        loadChurchList();
      }
    });
    super.initState();
  }

  final controller = ScrollController();
  FocusNode emailFocusNode = new FocusNode();
  TextEditingController searchController = new TextEditingController();
}
