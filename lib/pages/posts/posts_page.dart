import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_page.dart';
import 'package:firebase_crud/pages/posts/add_post_page.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final auth = FirebaseAuth.instance;
  final databaseRef= FirebaseDatabase.instance.ref('Post');
  final searchController= TextEditingController();
  final editController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
            //  Expanded(
            //   child: StreamBuilder(
            //     stream: databaseRef.onValue,
            //     builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
            //        if(!snapshot.hasData){
            //           return Center(child: CircularProgressIndicator());
            //        }
            //        else{
            //         Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
            //           List<dynamic> list=[];
            //           list.clear();
            //           list = map.values.toList();
            //            return ListView.builder(
            //             itemCount: snapshot.data!.snapshot.children.length,
            //         itemBuilder: (context, index) {
            //            debugPrint(list.toString());
            //           return ListTile(
            //             title: Text(list[index]['title'].toString()),
            //             subtitle: Text(list[index]['id'].toString()),
      
            //           );
            //         },
            //       );
              
            //        }
            //      },
            //     )
            //  ),
      
              Expanded(
                child: FirebaseAnimatedList(
                  query: databaseRef,
                  defaultChild: Text('Loading'),
                   itemBuilder: (context, snapshot, animation, index) {
                    final title=snapshot.child('title').value.toString();
                    if(searchController.text.isEmpty){
                        return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                subtitle: Text(snapshot.child('id').value.toString()),
                trailing: PopupMenuButton(
                  
                  icon: Icon(Icons.more_vert),
                  itemBuilder:(context) => [
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          showMyDialog(title,snapshot.child('id').value.toString());
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
                          databaseRef.child(snapshot.child('id').value.toString()).remove();
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
                title: Text(snapshot.child('title').value.toString()),
                subtitle: Text(snapshot.child('id').value.toString()),
                        );
                       
                    }
                    else{
                      return Container();
                    }
                   },
                   ),
              ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage()));
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
            databaseRef.child(id).update({
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