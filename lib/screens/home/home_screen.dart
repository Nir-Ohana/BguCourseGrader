import 'package:bgu_course_grader/models/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/menu/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
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

  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
        .collection('Users')
        .snapshots(),
    builder: (context, snapshot) {
      List<String> fields = [];
      if (snapshot.hasData) {
        final reviews = snapshot.data.docs;
        for (var review in reviews) {
          if (review.id == loggedInUser.displayName) {
            final reviewData = (review.data() as Map<String, dynamic>);
            final department = reviewData['department'];
            final faculty = reviewData['faculty'];
            fields.add(department);
            fields.add(faculty);
          }
        }
      }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(loggedInUser.photoURL),
                ),
                Divider(
                  height: 60.0,
                  color: Colors.grey[800],
                ),
                Text(
                  'שם:',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  loggedInUser.displayName,
                  style: TextStyle(
                    color: Colors.purpleAccent[800],
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'פקולטה',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  fields[1]!=null? fields[1].toString() : 'מדעי הדשא' ,
                  style: TextStyle(
                    color: Colors.purpleAccent[800],
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'מחלקה',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  fields[0]!=null? fields[0].toString() : 'פלוגת איזי',
                  style: TextStyle(
                    color: Colors.purpleAccent[800],
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orange[800]),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Menu()));
                        },
                        child: Text(
                          'לתפריט',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  });
}}
