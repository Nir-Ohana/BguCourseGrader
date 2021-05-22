import 'dart:async';

import 'package:bgu_course_grader/authentication/auth_bloc.dart';
import 'package:bgu_course_grader/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  StreamSubscription<User> loginStateSubscription;
  // void onGoogleSignIn(BuildContext context) async {
  //   var userSignedIn = Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
  // }

  // TextEditingController _emailField = TextEditingController();
  // TextEditingController _passwordField = TextEditingController();
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((user) {
      print(user);
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    loginStateSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(
            Buttons.Google,
            onPressed: () => authBloc.loginGoogle(),
          ),
        ],
      ),
    )

        // body: Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   decoration: BoxDecoration(
        //     color: Colors.orange[700],
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       TextFormField(
        //         controller: _emailField,
        //         decoration: InputDecoration(
        //             hintText: "someone@post.bgu.ac.il",
        //             labelText: "Email",
        //             labelStyle: TextStyle(
        //               color: Colors.black,
        //             )),
        //       ),
        //       TextFormField(
        //         controller: _passwordField,
        //         obscureText: true,
        //         decoration: InputDecoration(
        //           hintText: "password",
        //           labelText: "Password",
        //           labelStyle: TextStyle(
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //       Container(
        //         width: MediaQuery.of(context).size.width / 1.4,
        //         height: 45,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15.0),
        //           color: Colors.white,
        //         ),
        //         child: MaterialButton(
        //           onPressed: () async {
        //             bool shouldNavigate =
        //                 await register(_emailField.text, _passwordField.text);
        //             if (shouldNavigate) {
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (context) => HomeScreen()));
        //             }
        //           },
        //           child: Text("Register"),
        //         ),
        //       ),
        //       Container(
        //         width: MediaQuery.of(context).size.width / 1.4,
        //         height: 45,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15.0),
        //           color: Colors.white,
        //         ),
        //         child: MaterialButton(
        //           onPressed: () async {
        //             onGoogleSignIn(context);
        //           },
        //           child: Text("Login"),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
