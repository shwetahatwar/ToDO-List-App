// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:todo_list_makeing_app/Walkthrough-screens/Page2.dart';
// import 'package:todo_list_makeing_app/sign_in_controller.dart';
// import 'SignUp.dart';
//
// void main() => runApp(const Login());
//
// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);
//
//   static const String _title = 'TODO LIST App';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title),backgroundColor: Colors.blue.shade900,),
//         body: const MyStatefulWidget(),
//       ),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final controller = Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'ToDo List App',
//                   style: TextStyle(
//                       color: Color(0xFF1A237E),
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30),
//                 )),
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Sign in',
//                   style: TextStyle(fontSize: 20),
//                 )),
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'User Name',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: TextField(
//                 obscureText: true,
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 //forgot password screen
//               },
//               style: TextButton.styleFrom(
//                 primary: Colors.blue.shade900, // Text Color
//               ),
//               child: const Text('Forgot Password',),
//             ),
//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   child: const Text('Login'),
//                   onPressed: () {
//                     print(nameController.text);
//                     print(passwordController.text);
//                     Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                             builder: (context) => Page2()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.blue.shade900
//                   ),
//                 )
//             ),
//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   child: const Text('Google Sign In'),
//                   onPressed: () {
//                   controller.login();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.blue.shade900
//                   ),
//                 )
//             ),
//             Row(
//               children: <Widget>[
//                 const Text('Does not have account?'),
//                 TextButton(
//                   child: const Text(
//                     'Sign in',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: () {
//                     Timer(Duration(seconds: 3), () {
//                       Navigator.of(context)
//                           .pushReplacement(MaterialPageRoute(builder: (_) => SignupPage()));
//                     });
//                   },
//                   style: TextButton.styleFrom(
//                     primary: Colors.blue.shade900, // Text Color
//                   ),
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ],
//         ));
//   }
// }
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_makeing_app/HomePage.dart';
import 'package:todo_list_makeing_app/reset_password.dart';
import 'package:todo_list_makeing_app/reusable_widgets/reusable_widgets.dart';
import 'package:todo_list_makeing_app/signIn.dart';
import 'package:todo_list_makeing_app/sign_in_controller.dart';
import 'package:todo_list_makeing_app/todo_list.dart';

import 'SignUp.dart';
import 'Utils/colors_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final controller = Get.put(LoginController());
  bool isLoggedIn = false;
  late String name, image;

  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ]
  );

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
           color: Colors.blue.shade900),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("Img/todocover.png"),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Log In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTODOPage(title: '',)));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                // RaisedButton(onPressed: () {
                //   facebookSignIn();
                // }),


                //_buildWidget(),
                //googleSignIn(),
                buildLoginButton(),
                signUpOption(),
                //googleSignIn(),
              ],
            ),
          ),
        ),
      ),
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
      label: Text(''),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,);
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row googleSignIn() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(5.0),
            child: Container(
              // decoration: BoxDecoration(color: Colors.blue),
              child:GestureDetector(
                onLongPress: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Image.asset(
                  'Img/google_logo.png',
                  height: 44,
                  width: 44,
                  //  fit: BoxFit.cover,
                ),
              ),
            ),
          ),]
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

  Widget _buildWidget(){
    GoogleSignInAccount? user = _currentUser;
    if(user != null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
        child: Column(
          children: [
            ListTile(
              leading: GoogleUserCircleAvatar(identity: user),
              title:  Text(user.displayName ?? '', style: TextStyle(fontSize: 22),),
              subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Signed in successfully',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signOut,
                child: const Text('Sign out')
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signIn,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign in', style: TextStyle(fontSize: 30)),
                )
            ),
          ],
        ),
      );
    }
  }

  void signOut(){
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try{
      await _googleSignIn.signIn();
    }catch (e){
      print('Error signing in $e');
    }
  }
}