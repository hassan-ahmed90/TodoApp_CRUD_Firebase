import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_todo/component/RoundButton.dart';
import 'package:firebase_todo/ui/todo_screen.dart';
import 'package:firebase_todo/utils/utils.dart';
import 'package:flutter/material.dart';
class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  final todoController = TextEditingController();
  final dbref= FirebaseDatabase.instance.ref('Todo');

  bool loading= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              controller: todoController,
              decoration: InputDecoration(
                hintText: "Add Task",
                border: OutlineInputBorder()
              ),

            ),
            SizedBox(height: 80,),
            ReusableButton(
                loading: loading,
                title: "Add ", onpressed: (){
              setState(() {
                loading=true;
              });
              String id = DateTime.now().millisecond.toString();
              dbref.child(id).set({
                'id':id,
                 "task":todoController.text.toString(),
              }).then((value) {
                setState(() {
                  loading=false;
                });
                Utils().messegeToast("Task Added");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen()));
              }).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
                Utils().messegeToast(error.toString());
              });
            }),



          ],
        ),
      ),
    );
  }

}
