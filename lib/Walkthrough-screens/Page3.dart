import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

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
            Image.asset('Img/todo2.png',
              height: 400.0,width: 400.0,),
            Center(
              child: Text('To stay focused means that the daily to-do list comes from goals that are generated from the personal or institutional vision and mission.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}