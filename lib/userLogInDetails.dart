import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_makeing_app/login-screen.dart';

import 'loggedInWidget.dart';

class LoginUserDetails extends StatelessWidget {
  const LoginUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return LoggedInWidget();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        }
        return SignInScreen();
      },
    )
  ) ;
}
