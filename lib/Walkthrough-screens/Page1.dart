import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A237E),
              Color(0xFF1A237E),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('Img/todomain.jpg',
              height: 400.0,width: 400.0,),
            Center(
              child: Text('The only thing more important than your to-do list is your to-be list. The only thing more important than your to-be list is to be.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}