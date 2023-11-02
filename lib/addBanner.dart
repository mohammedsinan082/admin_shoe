import 'dart:html' as html;
import 'dart:typed_data';

import 'package:admin_shoe/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants1.dart';
import 'main.dart';
import 'modelClass.dart';

class addBanner extends StatefulWidget {
  const addBanner({super.key});

  @override
  State<addBanner> createState() => _addBannerState();
}

class _addBannerState extends State<addBanner> {



  String? imageUrl1;
  String? imageUrl;
  html.File? file;
  Uint8List webImage = Uint8List(8);
  
  void uploadImages() async{
    if(file==null) return;

    final storageRef = firebase_storage.FirebaseStorage.instance.ref("banners/").child("${DateTime.now()}");

    final uploadTask = storageRef.putBlob(file!);
    final snapshot = await uploadTask.whenComplete(() {});

    if(snapshot.state == firebase_storage.TaskState.success){
      final downloadUrl = await storageRef.getDownloadURL();
      print(downloadUrl);
      imageUrl1 = downloadUrl;
      setState(() {

      });
    }}
  
  
  
  uploadImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput = html
          .FileUploadInputElement();
      uploadInput.accept = "image/*";
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        if (uploadInput.files != null && uploadInput.files!.isNotEmpty) {
          file = uploadInput.files![0];
          imageUrl = html.Url.createObjectUrlFromBlob(file!);
          setState(() {

          });
        }
      });


      setState(() {

      });
    }
  }

  addProduct(){

    FirebaseFirestore.instance.collection(Constants.banner).add({
      "image":imageUrl1,
    });

    showMessage(context, text: "Product Added...", color: Colors.green);
  }
  
  
  
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
                Stack(
                  children: [
                    imageUrl!=null?
                    Container(
                      height: w*0.2,
                      width: w*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w*0.03),
                          border: Border.all(),
                          image: DecorationImage(image: NetworkImage(imageUrl!),fit: BoxFit.fill)
                      ),
                    ):
                    Container(
                      height: w*0.2,
                      width: w*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w*0.03),
                          border: Border.all()
                      ),
                    ),
                    Positioned(
                      right: w*0.02,
                      bottom: w*0.01,
                      child: InkWell(
                        onTap: () {
                          uploadImage();
                        },
                        child: CircleAvatar(
                          radius: w*0.04,
                          child: Icon(Icons.add_a_photo_outlined,size: w*0.05),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    uploadImages();
                  },
                  child: Container(
                    height: w*0.1,
                    width: w*0.2,
                    child: Center(child: Text("Save Image")),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(w*0.03)
                    ),
                  ),
                ),

                imageUrl1 == null ? Center(child: CircularProgressIndicator(),):
                InkWell(
                  onTap: () {
                    addProduct();
                  },
                  child: Container(
                    width: w*0.12,
                    height: w*0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.03),
                        color: themeColor.iconRed
                    ),
                    child: Center(
                      child: Text("ADD",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: w*0.03,
                            color: themeColor.black
                        ),
                      ),
                    ),
                  ),
                ),



              ],
            ),
    ));
            }
}

