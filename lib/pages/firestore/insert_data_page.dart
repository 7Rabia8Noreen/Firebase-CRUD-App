import 'package:firebase_crud/utils/constants.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsertDataPage extends StatefulWidget {
  const InsertDataPage({super.key});

  @override
  State<InsertDataPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<InsertDataPage> {
  bool loading=false;
  final postController=TextEditingController();
  final firestorePosts = FirebaseFirestore.instance.collection('Posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data into firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Whats\'s in your mind?'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Add',loading: loading, onTap: (){
              setState(() {
                loading=true;
              });
              String id= DateTime.now().millisecondsSinceEpoch.toString();
              firestorePosts.doc(id).set({
                'id':id,
                'title': postController.text
              }).then((value) {
                setState(() {
                loading=false;
              });
              Constants().showToastMessage('Post Added');
              }).onError((error, stackTrace){
                 setState(() {
                loading=false;
              });
              Constants().showToastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}