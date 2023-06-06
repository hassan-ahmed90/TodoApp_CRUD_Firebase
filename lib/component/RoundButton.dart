import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final  String title ;
  final  VoidCallback onpressed;
  final bool loading;
  ReusableButton({Key? key,required this.title,required this.onpressed,this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child:loading ? CircularProgressIndicator(): Text(title,style: TextStyle(fontSize:20,color: Colors.white),)),

      ),
    );
  }
}
