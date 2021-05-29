import 'package:bgu_course_grader/provider/google_sign_in.dart';
import 'package:bgu_course_grader/screens/home/home_screen.dart';
import 'package:bgu_course_grader/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
        Scaffold(
          body: ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
            child: StreamBuilder<Object>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  if (provider.isSigningIn) {
                    return buildLoading();
                  } else if (snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return SignUpWidget();
                  }
                }),
          ),
        );

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
