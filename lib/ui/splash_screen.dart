import 'package:firebase_todo/services/splash_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices sp = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sp.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Todo App",style: TextStyle(fontSize:35,color: Colors.white),),
          )
        ],
      ),
    );
  }
}
