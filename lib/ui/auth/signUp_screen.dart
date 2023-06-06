import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/component/RoundButton.dart';
import 'package:firebase_todo/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
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
            Center(child: Text("SignUp",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.deepPurpleAccent,fontSize: 30),)),
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
                title: "SignUp", onpressed: (){
              setState(() {
                loading= true;
              });
              if(_formKey.currentState!.validate()){
                _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()
                ).then((value)  {
                  setState(() {
                    loading=false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())).onError((error, stackTrace) {
                    setState(() {
                      loading=false;
                    });
                    Utils().messegeToast(error.toString());
                  });
                });
              }
            }),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an acount"),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: Text("Login"))
              ],
            ),

          ],
        ),
      ) ,
    );
  }
}
