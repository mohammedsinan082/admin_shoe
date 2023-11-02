import 'package:admin_shoe/addBanner.dart';
import 'package:admin_shoe/addCategory.dart';
import 'package:admin_shoe/addProduct.dart';
import 'package:admin_shoe/colors.dart';
import 'package:admin_shoe/productDetails.dart';
import 'package:admin_shoe/viewBanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class firstPage extends StatefulWidget {
  const firstPage({super.key});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeColor.white,
        ),
        body: Container(
            height: w*1.9,
            width: w*1,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(w*0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("E COM",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w*0.15,
                        color: themeColor.iconRed,
                      ),),
                      SizedBox(
                        height: w*0.2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => addBanner(),));
                        },
                        child: Text("Add Banner",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => viewBanner(),));
                        },
                        child:  Text("view Banner",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => addProduct(),));
                        },
                        child:  Text("Add product",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      ),
                      SizedBox(
                        height: w*0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => addCategory(),));
                        },
                        child: Text('Add Catogory',style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,
                        ) ,),
                      ),
                      SizedBox(
                        height: w*0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,CupertinoPageRoute(builder: (context) => productDetails(),));
                        },
                        child: Text("Product Details",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w*0.08,
                          color: themeColor.iconRed,

                        ),),
                      )
                    ],

                  ),
                )
            )
    ));

  }
}
