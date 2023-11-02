import 'package:admin_shoe/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class viewBanner extends StatefulWidget {
  const viewBanner({super.key});

  @override
  State<viewBanner> createState() => _viewBannerState();
}

class _viewBannerState extends State<viewBanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Banner",style: TextStyle(
              color: themeColor.iconRed,
              fontSize: w*0.07,
              fontWeight: FontWeight.w700
          ),),
          elevation: 0,
          backgroundColor: themeColor.white,

        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("banner").snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData) {
                      return Center(child: Text("no image"));

                    }
                    var data=snapshot.data?.docs;
                    return data?.length==0
                        ? Center(child: Text(" no image")):
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:data!.length ,
                      physics:BouncingScrollPhysics() ,
                      itemBuilder:(context, index) {
                        return ListTile(
                          title:Image.network(data[index]["image"],height: 100,),
                          trailing: InkWell(
                              onTap:(){
                                FirebaseFirestore.instance.collection("banner").doc(data[index].id).delete();

                              },
                              child: Icon(Icons.delete,color: themeColor.black,)),
                        );

                      },

                    );


                  }
                  ,)



              ],
            ),
    ));
  }
}

