// import 'package:flutter/material.dart';
// import 'package:todo_list_makeing_app/login-screen.dart';
//
// class SignupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         leading:
//         IconButton( onPressed: (){
//           Navigator.pop(context);
//         },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text ("Sign up", style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),),
//                         SizedBox(height: 20,),
//                         Text("Create an Account,Its free",style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey[700],
//                         ),),
//                         SizedBox(height: 30,)
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 40
//                       ),
//                       child: Column(
//                         children: [
//                           makeInput(label: "Email"),
//                           makeInput(label: "Password",obsureText: true),
//                           makeInput(label: "Confirm Pasword",obsureText: true)
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 40),
//                       child: Container(
//                         padding: EdgeInsets.only(top: 3,left: 3),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.black),
//                                 top: BorderSide(color: Colors.black),
//                                 right: BorderSide(color: Colors.black),
//                                 left: BorderSide(color: Colors.black)
//                             )
//                         ),
//                         child: MaterialButton(
//                           minWidth: double.infinity,
//                           height:60,
//                           onPressed: (){
//
//                           },
//                           color: Color(0xFF1A237E),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40)
//                           ),
//                           child: Text("Sign Up",style: TextStyle(
//                             fontWeight: FontWeight.w600,fontSize: 16,
//
//                           ),),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account? "),
//                         Text("Login",style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                         ),),
//                       ],
//                     )
//                   ],
//
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget makeInput({label,obsureText = false}){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(label,style:TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//           color: Colors.black87
//       ),),
//       SizedBox(height: 5,),
//       TextField(
//         obscureText: obsureText,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.black45,
//             ),
//           ),
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black45)
//           ),
//         ),
//       ),
//       SizedBox(height: 30,)
//
//     ],
//   );
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_makeing_app/reusable_widgets/reusable_widgets.dart';
import 'login-screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.blue.shade900),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignInScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    })
                  ],
                ),
              ))),
    );
  }

// Future saveUserInfoToFireStore(FirebaseUser fUser) async{
//   FirebaseFirestore.instance.collection("users").documents(fUser.uid).setData({
//     "uid":fUser.uid,
//     "email":fUser.email,
//     "name": _userNameTextController.text.trim(),
//     "url":userImageUrl,
//   });
//   await Ecomm
// }
}