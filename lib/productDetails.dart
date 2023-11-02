import 'package:admin_shoe/constants.dart';
import 'package:admin_shoe/constants1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'modelClass.dart';

class productDetails extends StatefulWidget {
  const productDetails({super.key});

  @override
  State<productDetails> createState() => _productDetailsState();
}

getProduct(){
  return FirebaseFirestore.instance.collection(Constants.product)
      .where("delete",isEqualTo: false)
      .orderBy("date",descending: true)
      .snapshots().map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
}

class _productDetailsState extends State<productDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ProductModel>>(
                      stream: getProduct(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        List<ProductModel> productList =snapshot.data!;
                        return ListView.builder(
                            itemCount: productList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext,int index){
                              ProductModel product = productList[index];
                              return InkWell(
                                onTap: (){

                                  var a = product.copyWith(
                                    delete: true,
                                  );


                                  productList[index].reference.update(a.toJson());


                                },
                                child: Container(
                                  color: Colors.blue,
                                  height: 120,
                                  child: Column(
                                    children: [
                                      Text(DateFormat("dd-MMM-yyyy hh:mm a").format(product.date)),
                                      Text(product.prdctName),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                  ),
                ),
              ],
            ),
                  ));
  }
}

