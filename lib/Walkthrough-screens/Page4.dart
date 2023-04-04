import 'package:flutter/material.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);
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
            Image.asset('Img/todo3.jpg',
              height: 400.0,width: 400.0,),
            Center(
              child: Text('What one does daily should be staircasing towards the overall accomplishment of the vision and mission of the organization.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}