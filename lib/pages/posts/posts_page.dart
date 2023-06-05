import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_page.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts page'),
        actions: [
          IconButton(
            onPressed: (){
             auth.signOut().then((value){
               Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => LoginPage())
                );
             }).onError((error, stackTrace) {
              Constants().showToastMessage(error.toString());
             });
          }, 
          icon: Icon(Icons.logout_outlined)
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}