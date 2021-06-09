import 'package:bgu_course_grader/provider/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatelessWidget {

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: OutlinedButton.icon(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();


        },
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.black),
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'התחברו עם משתמש ה- BGU שלכם',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(
            side: BorderSide(width: 20, color: Colors.black),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}
