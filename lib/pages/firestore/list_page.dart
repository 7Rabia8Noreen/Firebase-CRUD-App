import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_page.dart';
import 'package:firebase_crud/pages/firestore/insert_data_page.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<ListPage> {
  final auth = FirebaseAuth.instance;
  final firestorePosts = FirebaseFirestore.instance.collection('Posts').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('Posts');
  final searchController= TextEditingController();
  final editController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Get List from firestore'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
             TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder()
              ),
              onChanged: (value){
                setState(() {
                  
                });
              },
             ),
             Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestorePosts,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                   if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                   }
                   else{
                    // Map<dynamic, dynamic> map= snapshot.data!.docs as dynamic;
                    //   List<dynamic> list=[];
                    //   list.clear();
                    //   list = map.values.toList();
                       return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    final title=  snapshot.data!.docs[index]['title'].toString();
                    final id=  snapshot.data!.docs[index]['id'].toString();
                       if(searchController.text.isEmpty){
                        return ListTile(
                title: Text(title),
                subtitle: Text(id),
                trailing: PopupMenuButton(
                  
                  icon: Icon(Icons.more_vert),
                  itemBuilder:(context) => [
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          showMyDialog(title,id);
                        },
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                    
                    ),
                     PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          ref.doc(id).delete();
                        },
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                    
                    )
                  ],
                  ),
                        );
                    }
                    else if(title.toLowerCase().contains(searchController.text.toLowerCase().toString())){
                       return ListTile(
                  title: Text(title),
                         subtitle: Text(id),
                        );
                       
                    }
                    else{
                      return Container();
                    }
                      // return ListTile(
                      //   title: Text(snapshot.data!.docs[index]['title'].toString()),
                      //   subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
      
                      // );
                    },
                  );
              
                   }
                 },
                )
             ),
      
              // Expanded(
              //   child: FirebaseAnimatedList(
              //     query: databaseRef,
              //     defaultChild: Text('Loading'),
              //      itemBuilder: (context, snapshot, animation, index) {
              //       final title=snapshot.child('title').value.toString();
              //       if(searchController.text.isEmpty){
              //           return ListTile(
              //   title: Text(snapshot.child('title').value.toString()),
              //   subtitle: Text(snapshot.child('id').value.toString()),
              //   trailing: PopupMenuButton(
                  
              //     icon: Icon(Icons.more_vert),
              //     itemBuilder:(context) => [
              //       PopupMenuItem(
              //         value: 1,
              //         child: ListTile(
              //           onTap: (){
              //             Navigator.pop(context);
              //             showMyDialog(title,snapshot.child('id').value.toString());
              //           },
              //         leading: Icon(Icons.edit),
              //         title: Text('Edit'),
              //       ),
                    
              //       ),
              //        PopupMenuItem(
              //         value: 2,
              //         child: ListTile(
              //           onTap: (){
              //             Navigator.pop(context);
              //             databaseRef.child(snapshot.child('id').value.toString()).remove();
              //           },
              //         leading: Icon(Icons.delete),
              //         title: Text('Delete'),
              //       ),
                    
              //       )
              //     ],
              //     ),
              //           );
              //       }
              //       else if(title.toLowerCase().contains(searchController.text.toLowerCase().toString())){
              //          return ListTile(
              //   title: Text(snapshot.child('title').value.toString()),
              //   subtitle: Text(snapshot.child('id').value.toString()),
              //           );
                       
              //       }
              //       else{
              //         return Container();
              //       }
              //      },
              //      ),
              // ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertDataPage()));
        }),
    );
  }
  Future<void> showMyDialog(String title, String id){
   editController.text= title;
    return showDialog(
      context: context,
       builder:(context) => AlertDialog(
        title: Text('Update'),
        content: TextFormField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Edit'
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            ref.doc(id).update({
              'title' : editController.text.toString()
            }).then((value) {
                Constants().showToastMessage('Post Updated');
            }).onError((error, stackTrace) {
              Constants().showToastMessage(error.toString());
            });
            Navigator.pop(context);
          }, child: Text('Update'))
        ],
       ),
       );
  }
}