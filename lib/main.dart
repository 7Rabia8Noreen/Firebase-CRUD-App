import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    //use this for web
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //      apiKey: "AIzaSyB4h5YDqNi-8fsc3whWIjIJ8_qpkXJKVl0",
  // authDomain: "fir-crud-1bd0d.firebaseapp.com",
  // projectId: "fir-crud-1bd0d",
  // storageBucket: "fir-crud-1bd0d.appspot.com",
  // messagingSenderId: "364279780392",
  // appId: "1:364279780392:web:55a2345f1b56485c1e511d",
  // measurementId: "G-BQWHK0GG08"
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.pink,
      ),
      home: SplashPage(),
    );
  }
}

