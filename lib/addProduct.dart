
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:admin_shoe/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'categoryModel.dart';
import 'constants1.dart';
import 'main.dart';
import 'modelClass.dart';

class addProduct extends StatefulWidget {
  const addProduct({super.key});

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {

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
          imageUrl = html.Url.createObjectUrlFromBlob(file!);
          setState(() {

          });
        }
      });


      setState(() {

      });
    }
  }

  List <CategoryModel> category=[];
  var dropdownvalue;

  getCategory() async {
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection(Constants.category)
        .where("delete",isEqualTo: false).get();
    if(snapshot.docs.isNotEmpty){
      category.clear();
      for(DocumentSnapshot doc in snapshot.docs){
        category.add(CategoryModel.fromjson(doc.data()));
      }
    }
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    getCategory();
    // TODO: implement initState
    super.initState();
  }





  TextEditingController nameController=TextEditingController();
  TextEditingController amtController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  addProduct(){
    int id =Timestamp.now().seconds;

    DocumentReference ref = FirebaseFirestore.instance.collection(Constants.product).doc("FLIT$id");
    final product =ProductModel(
      image: imageUrl1 ?? "",
      prdctName: nameController.text??'',
      amount: double.tryParse(amtController.text)??0,
      delete: false,
      description: descriptionController.text??'',
      id: ref.id,
      reference: ref,
      date: DateTime.now(),
      category:dropdownvalue,
      banner: ""
    );
    ref.set(product.toJson());
    nameController.clear();
    amtController.clear();
    brandController.clear();
    descriptionController.clear();
    showMessage(context, text: "Product Added...", color: Colors.green);
    }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeColor.iconRed,
          title: const Text("ADD PRODUCT",style: TextStyle(color: themeColor.white),),
          actions: [
            IconButton(onPressed: () {
              navigatorKey.currentState!.pushNamed("/productList");
            },
                icon: Icon(Icons.list)
            )
          ],
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
                    controller: amtController,
                    decoration: InputDecoration(
                        hintText: "Amount of the product",
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
                    controller: brandController,
                    decoration: InputDecoration(
                        hintText: "Brand of the product",
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
                        hintText: "Description of the product",
                        constraints: BoxConstraints(
                          maxHeight: w*0.05,
                          maxWidth: w*0.24,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor.iconRed),
                        )
                    ),
                  ),
                  SizedBox(height: w*0.1,),
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
                  SizedBox(height: w*0.03,),
                  Container(
                    height: w*0.06,
                    width: w*0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.02),
                        border: Border.all()
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: Text("select Category"),
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      value: dropdownvalue,
                      items: category.map((e) =>
                          DropdownMenuItem(
                              value: e.name,
                              child: Text(e.name,style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w*0.04,
                                  fontWeight: FontWeight.w500
                              ),))
                      ).toList() ,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue=newValue;
                        });
                      },),
                  ),
                  imageUrl1 == null ? Center(child: CircularProgressIndicator(),) : InkWell(
                    onTap: () {
                      if(nameController.text.isNotEmpty&&
                          amtController.text.isNotEmpty&&
                          descriptionController.text.isNotEmpty&&
                          brandController.text.isNotEmpty&&
                      imageUrl1!=null){
                        addProduct();

                      }else{
                        nameController.text.isEmpty?showMessage(context,text: "Please Enter Name",color: Colors.red):
                        amtController.text.isEmpty?showMessage(context,text: "Please Enter Amount",color: Colors.red):
                        descriptionController.text.isEmpty?showMessage(context,text: "Please Enter Description",color: Colors.red):
                        descriptionController.text.isEmpty?showMessage(context,text: "Please Enter brand",color: Colors.red):
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
            ),));

  }
}
