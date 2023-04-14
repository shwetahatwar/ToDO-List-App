import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_makeing_app/Provider/googleSignInProvider.dart';
import 'HomePage.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
	SystemChrome.setSystemUIOverlayStyle(
		SystemUiOverlayStyle(statusBarColor: Colors.transparent));
		runApp(MyApp());
}

class MyApp extends StatelessWidget {

// This widget is the root of your application.
@override
Widget build(BuildContext context) => ChangeNotifierProvider(
		create: (context) => GoogleSignInProvider(),
		 child: MaterialApp(
		debugShowCheckedModeBanner: false,
			title: 'TODO List APP',
			theme: ThemeData(primaryColor: Colors.blue.shade900),
			home: HomePage(),
			));

}

