import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth  = FirebaseAuth.instance;
  Future<UserCredential?> loginWithGoogle() async {
    try{
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken
      );

      return await _auth.signInWithCredential(cred);
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  Future<String?> loggedIn() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final username = user.email; // Assuming username is the email address
      // Display the username using Text widget or other UI elements
      return username;
    } else {
    // Handle the case where the user is not signed in
      return 'Please Login';
    }
  }


}