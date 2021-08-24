// This Folder is meant to have all Authentication functions like
// Sign In with Email and Password and Login With Email,Facebook and Google

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  var email;
  var password;
  var uid;
  var userEmail;
  var emailCode;

  Future<String> signIn(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    try {
     final newUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email, password: password);
     if(newUser.user.emailVerified)
       {
         FirebaseAuth.instance.signOut();
         emailCode = "Email Not  Verified";
       }
    } on FirebaseAuthException catch (e) {
      emailCode = e.code;
    }
    return null;
  }

  Future<String> createUserWithEmailAndPassword(String email,
      String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    try {
     final newUser =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     print("User = $newUser");
     await newUser.user.sendEmailVerification();
     await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      emailCode = e.code;
    }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return null;
  }

// Forgot Password Widget

Future<void> forgotPassword(String email) async
{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
}