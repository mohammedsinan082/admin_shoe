import 'dart:html' as html;
import 'dart:typed_data';

import 'package:admin_shoe/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';
import 'categoryModel.dart';
import 'constants1.dart';
import 'main.dart';

class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {

  String? imageUrl1;
  String? imageUrl;
  html.File? file;
  Uint8List webImage = Uint8List(8);

  uploadImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput = html
          .FileUploadInputElement();
      uploadInput.accept = "image/*";
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        if (uploadInput.files != null && uploadInput.files!.isNotEmpty) {
          file = uploadInput.files![0];
          imageUrl1 = html.Url.createObjectUrlFromBlob(file!);
          setState(() {

          });
        }
      });


      setState(() {

      });
    }
  }


  TextEditingController nameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: themeColor.iconRed,
            title: Text('ADD CATEGORY'),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(w*0.03),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Name of the product",
                      constraints: BoxConstraints(
                        maxHeight: w*0.05,
                        maxWidth: w*0.24,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.iconRed),
                      )
                  ),
                ),
                SizedBox(height: w*0.03,),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Enter the price",
                      constraints: BoxConstraints(
                        maxHeight: w*0.05,
                        maxWidth: w*0.24,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.iconRed),
                      )
                  ),
                ),
                SizedBox(height: w*0.03,),
                Stack(
                    children: [
                      imageUrl1!=null?
                      Container(
                        height: w*0.2,
                        width: w*0.5,
                        child:Image(image: NetworkImage(imageUrl1!),fit: BoxFit.fill,) ,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w*0.03),
                            border: Border.all()
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
                SizedBox(height: w*0.03,),
                InkWell(
                  onTap: () {
                    if(nameController.text.isNotEmpty&&
                        descriptionController.text.isNotEmpty &&
                    imageUrl!.isNotEmpty){
                      addProduct();

                    }else{
                      nameController.text.isEmpty?showMessage(context,text: "Please Enter Name",color: Colors.red):
                      descriptionController.text.isEmpty?showMessage(context,text: "Please Enter Description",color: Colors.red):
                      showMessage(context,text: "Please upload image",color: Colors.red);

                    }
                    // Navigator.
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
          ),
        )
    );

  }
}
