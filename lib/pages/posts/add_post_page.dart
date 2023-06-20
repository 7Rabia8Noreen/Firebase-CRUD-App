import 'package:firebase_crud/utils/constants.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  bool loading=false;
  final postController=TextEditingController();
  final databaseRef= FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
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
              databaseRef.child(id).set({
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