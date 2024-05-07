import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/utils.dart';

class AuthService{

  Future<UserCredential?> signInWithGoogle() async {

    try{
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }catch(error){
      return null;
    }

  }

  Future<String?> getIdToken() async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return await user.getIdToken();
    }
    else{
      Utils.toastMsg('User not logged in');
      // throw Exception('User not logged in');
      return null;
    }
  }

}