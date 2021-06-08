import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'course_reviews.dart';
import 'menu/menu_screen.dart';

class CoursePage extends StatefulWidget {
  final String course_name;
  final String course_number;
  final String credit_point;
  final String course_summary;

  CoursePage(
      {this.course_name,
      this.course_number,
      this.credit_point,
      this.course_summary});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[600],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SafeArea(
            child: ListView(
              children: [
                Text(
                  'שם הקורס:\n ${widget.course_name}\n',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'מספר הקורס:\n ${widget.course_number}\n',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.credit_point.isNotEmpty ? 'נק"ז:\n\ ${widget.credit_point}\n' : 'נק"ז: \nיא אללה אין נק"ז ?\n',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.course_summary.isNotEmpty
                      ? 'תקציר:\n\ ${widget.course_summary}\n'
                      : 'תקציר: \nוואלה אין תקציר...',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'השאר ביקורת',
                                textDirection: TextDirection.rtl,
                              ),
                              content: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.question_answer),
                                      hintText: '? מה אומר',
                                      labelText: 'הביקורת שלך כאן',
                                    ),
                                    maxLines: null,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 150.0, top: 40.0),
                                    child: new ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          // Validate returns true if the form is valid, or false otherwise.
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Processing Data')));
                                          FirebaseFirestore.instance
                                              .collection("Reviews")
                                              .doc(widget.course_number +
                                                  " " +
                                                  FirebaseAuth.instance
                                                      .currentUser.displayName)
                                              .set({
                                                'time':
                                                    DateTime.now().toString(),
                                                'name': FirebaseAuth.instance
                                                    .currentUser.displayName,
                                                'course_name':
                                                    widget.course_name,
                                                'email': FirebaseAuth
                                                    .instance.currentUser.email,
                                                'review_content':
                                                    messageController.text,
                                                'course_number':
                                                    widget.course_number
                                              })
                                              .then((_) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Thank you for your Review !'))))
                                              .catchError((_) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Ya Walli, we have a problem.'))));

                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 3;
                                          });
                                        },
                                        child: const Text('שלחחחח')),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: const Text(
                    "לחץ להשארת ביקורת",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CourseReviews(courseName: widget.course_name,)));},
                    child: const Text("לחץ על מנת לראות ביקורות לקורס זה",
                        style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
