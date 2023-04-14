import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_list_makeing_app/sign_in_controller.dart';
import 'package:todo_list_makeing_app/todo_list.dart';

class SignIn extends StatefulWidget {
  final controller = Get.put(LoginController());
  //const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Log In Details'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Obx(() {
          if (controller.googleAccount.value == null)
            return buildLoginButton();
          else
            return buildProfileView();
        }),
      ),
    );
  }

  //Profile login details funtion
  Column buildProfileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: Image
              .network(controller.googleAccount.value?.photoUrl ?? '').image,
          radius: 100,
        ),
        Text(controller.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headline3,),
        Text(controller.googleAccount.value?.email ?? '',
            style: Get.textTheme.bodyText1),
        SizedBox(height: 16),
        ActionChip(
          avatar: Icon(Icons.logout),
          label: Text('Logout'),
          onPressed: (){
            controller.logout();
          },
        ),
        ActionChip(
          avatar: Icon(Icons.dashboard_customize),
            label: Text('Dashboard'),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyTODOPage(title: '')));
        },)
      ],
    );
  }

  //Sign in with Google button Ui
  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended
      (onPressed: () {
      controller.login();
    },
      icon: Image.asset('Img/google_logo.png',
        height: 32,
        width: 32,
      ),
      label: Text('Sign in with Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,);
  }
}
