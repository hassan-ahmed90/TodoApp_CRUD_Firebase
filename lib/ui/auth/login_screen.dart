

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/component/RoundButton.dart';
import 'package:firebase_todo/ui/auth/signUp_screen.dart';
import 'package:firebase_todo/ui/todo_screen.dart';
import 'package:firebase_todo/utils/utils.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _auth= FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("LOGIN",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.deepPurpleAccent,fontSize: 30),)),
            SizedBox(height: 40,),
            Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email,),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter email";
                      }else{
                        return null;
                      }
                    },

                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock,),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Password";
                      }else{
                        return null;
                      }
                    },
                  ),
            ],)),

            SizedBox(height: 60,),
            ReusableButton(
                loading: loading,
                title: "Login", onpressed: (){
              setState(() {
                loading=true;
              });
              if(_formKey.currentState!.validate()){
                _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen()));
                }).onError((error, stackTrace) {
                  setState(() {
                    loading=false;
                  });
                  Utils().messegeToast(error.toString());
                });
              }
            }),
            SizedBox(height: 10,),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){}, child: Text("Forget Password"))),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an acount"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                }, child: Text("SignUp"))
              ],
            ),

          ],
        ),
      ) ,
    );
  }
}
