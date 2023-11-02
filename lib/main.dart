import 'package:admin_shoe/firstPage.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

var h;
var w;
final GlobalKey<NavigatorState>navigatorKey =GlobalKey<NavigatorState>();


void main(){
  initFirebase();
  runApp(homePage());
}

class homePage extends StatefulWidget {

  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    h=MediaQuery.of(context).size.height;
    w=MediaQuery.of(context).size.width;
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/ProductLis',
       home: firstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

