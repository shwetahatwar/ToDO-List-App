import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'HomePage.dart';
import 'login-screen.dart';

void main() {
	SystemChrome.setSystemUIOverlayStyle(
		SystemUiOverlayStyle(statusBarColor: Colors.transparent));
runApp(MyApp());
}

class MyApp extends StatelessWidget {

// This widget is the root of your application.
@override
Widget build(BuildContext context) {

	return MaterialApp(
	debugShowCheckedModeBanner: false,
		
	// Title of App
	title: 'TODO List APP',
	theme: ThemeData(
		primaryColor: Color.fromARGB(111, 111, 111, 111)
	),

		
	//First Screen of Slider App
	home: HomePage(),
	 // routes: {
		//  '/Login': (context) => const Login(),
	 // },
   // routes: <String, WidgetBuilder>{
   //      '/login': (BuildContext context) => new Login(),
   //    }
	);
}
}
