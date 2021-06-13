import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        if(_firestore.collection("Users").doc(loggedInUser.displayName).get() == null) {
          _firestore
              .collection("Users").doc(loggedInUser.displayName)
              .set({
            'faculty': 'פלוגת איזי',
            'department': 'מדעי הדשא',
            'neighbourhood': 'שכונה',
            'year': 'עתודאי וגאה',
            'photoURL': loggedInUser.photoURL});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  GoogleSignInProvider(){
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async{
    isSigningIn = true;
    final user = await googleSignIn.signIn();
    if (user == null){
      isSigningIn = false;
      return;
    }
    else
      {
        final googleAuth = await user.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        isSigningIn = false;
        getCurrentUser();
      }
  }

  void logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}