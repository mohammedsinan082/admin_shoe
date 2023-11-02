import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future initFirebase() async {
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBIiWc8ywxi8OUq-DJR6jbXdemzP2zp__U",
            authDomain: "shoe-store-5eea1.firebaseapp.com",
            projectId: "shoe-store-5eea1",
            storageBucket: "shoe-store-5eea1.appspot.com",
            messagingSenderId: "322178353011",
            appId: "1:322178353011:web:bb92ad235386ba4622a706"
        )
    );
  }
  else{
    await Firebase.initializeApp();
  }
}






