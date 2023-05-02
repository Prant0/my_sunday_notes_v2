import 'package:flutter/material.dart';
import 'package:mysundaynotes/model/sod_model.dart';
import 'package:mysundaynotes/widget/widget.dart';

class SODDetailsPage extends StatelessWidget {
  SODModel sodModel;
   SODDetailsPage({Key? key,required this.sodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back,color: yellowDark,),
        title: Text("The Title Church",style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          Icon(Icons.share,color: yellowDark,),
          SizedBox(width: 12,)
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(

                children: [
                  Center(
                    child: CircleAvatar(
                      //radius: 50,
                      maxRadius: 50,
                      backgroundImage: NetworkImage("${demoImage}"),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text("The Life Church",style: Theme.of(context).textTheme.titleLarge,),
                  Text("Bobby Lee",style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: 8,),
                  Text("MySundaynotes.com.etc",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                ],
              ),

               Padding(
                 padding: const EdgeInsets.all(bodyPadding),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                   children: [
                     Text("Read your bilble everycay",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                     Text("Saturday 6.00 PM",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                     Text("Sunday 6.00 PM",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                     Text("Uttara dhaka 1230, dakkhin dhan",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                     Text("99012993849",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                     Text("Thug@gmail.com",style: myStyle(tSmall,grayClr,FontWeight.w700)),
                   ],
                 ),
               ),
          Container(
            alignment: Alignment.center,
            color: yellowDark,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("Come Join Us at Church",style: myStyle(tSmall,blackDark),),
          ),
          Container(
            height: 120,
            color: Colors.white,
          ),
              Container(
                alignment: Alignment.center,
                color: blackDark,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("Today's Scripture of the day",style: myStyle(tSmall,yellowLight),),
              ),
          Container(
            color: yellowLight,
            padding: EdgeInsets.all(bodyPadding),
            child: Image.network("$demoImage",height: 120,width: double.infinity,fit: BoxFit.cover,),
          ),
              Text("Today's Scripture of the day",style: myStyle(tSmall,yellowLight),),
              Text("Related SOD",style: myStyle(tSmall,yellowLight),),


              /*    Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 280,
                        color: Colors.blue,
                        width: 80,
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 280,
                        color: Colors.blue,
                        width: 80,
                      ),
                      SizedBox(height: 20,),   Container(
                        height: 280,
                        color: Colors.blue,
                        width: 80,
                      ),
                      SizedBox(height: 20,),   Container(
                        height: 280,
                        color: Colors.blue,
                        width: 80,
                      ),
                      SizedBox(height: 20,),
                      Text("The Title Church",style: Theme.of(context).textTheme.titleLarge,),
                      Text("The Title Church",style: Theme.of(context).textTheme.titleLarge,),
                      Text("The Title Church",style: Theme.of(context).textTheme.titleLarge,),
                    ],
                  ),
                ),
              )*/

            ],
          ),
        ),
      ),
    );
  }
}
