import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

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
            Image.asset('Img/todo1.png',
              height: 400.0,width: 400.0,),
            Center(
              child: Text('When there is so much to be done, our “To do list” never see an action due to the confusion on where to start, we keep wasting time in making changes to the list and not working on the list, and there comes a time when confusion overpowers the intention to start.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}