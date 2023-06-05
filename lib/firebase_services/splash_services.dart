import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_page.dart';
import 'package:firebase_crud/pages/posts/posts_page.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void isLogin(BuildContext context){
    FirebaseAuth _auth= FirebaseAuth.instance;
    final user= _auth.currentUser;
     if(user !=null){
       Timer(Duration(seconds: 3), 
     () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostsPage(),),),
     );
     }
     else{
       Timer(Duration(seconds: 3), 
     () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),),),
     );
     }
    
  }
}