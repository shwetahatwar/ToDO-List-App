//state managment
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
//instead of doing everything from UI we do this from here
  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async{
    googleAccount.value = await _googleSignIn.signIn();
  }

  logout() async{
    googleAccount.value = await _googleSignIn.signOut();
  }
}
