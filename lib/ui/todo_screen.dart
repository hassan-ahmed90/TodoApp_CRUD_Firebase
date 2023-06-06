import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_todo/ui/add_todo.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final updateController = TextEditingController();
  final ref= FirebaseDatabase.instance.ref("Todo");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            
            Expanded(child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator(),),
              query: ref,
              itemBuilder: (context,snapshot,animation,index){
                final todo = snapshot.child('task').value.toString();
                return ListTile(
                  title: Text(snapshot.child('task').value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context)=>[
                    PopupMenuItem(
                    value: 1,

                child: ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    showMyDialog(todo,snapshot.child('id').value.toString());

                  },
                  title: Text("Update"),
                  leading: Icon(Icons.edit),

                ),
                ),
                      PopupMenuItem(
                        value: 1,

                        child: ListTile(
                          onTap: (){

                            Navigator.pop(context);
                            ref.child(snapshot.child('id').value.toString()).remove();

                          },
                          title: Text("Delete"),
                          leading: Icon(Icons.delete),

                        ),
                      )
                    ],
                  ),
                );
              },
            ))

          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTodo()));

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
  Future<void> showMyDialog(String name,String id)async{
    updateController.text=name;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Update"),
        content: Container(
          child: TextField(
            controller: updateController,
            decoration: InputDecoration(
                hintText: "Edit here"
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              'task': updateController.text.toLowerCase(),
            }).then((value) {
              Utils().messegeToast("Updated Data");
            }).onError((error, stackTrace) {
              Utils().messegeToast("Cann't be updated");
            });
          }, child: Text("Update")),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),

        ],
      );
    });
  }
}
