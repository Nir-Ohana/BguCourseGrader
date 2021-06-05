import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'google_signup_button_widget.dart';
class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp();

  Widget buildSignUp() => Stack(children: [
        new Positioned.fill(
          child: Image.asset(
            'images/bgu_course.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 400,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AnimatedTextKit(
                      animatedTexts: [TypewriterAnimatedText("ברוכים הבאים למדרג הקורסים",
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ))],

                    ),
                  ),
                ),
              ),
              Spacer(),
              GoogleSignupButtonWidget(),
              SizedBox(height: 5),
            ],
          ),
        ),
      ]);
}
