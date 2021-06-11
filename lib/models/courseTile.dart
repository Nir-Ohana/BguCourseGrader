import 'package:bgu_course_grader/screens/course_page.dart';
import 'package:bgu_course_grader/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/course.dart';

class CourseTile extends StatefulWidget {
  final Course course;
  bool favorite;
  CourseTile({this.course, this.favorite});

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  final loggedUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore_instance = FirebaseFirestore.instance;
  double course_rating = 2.5;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore_instance.collection('Favorites').snapshots(),
        builder: (context, snapshot) {
          List<dynamic> favorites = [];
          if (snapshot.hasData) {
            final favoriteUsers = snapshot.data.docs;

            for (var user in favoriteUsers) {
              if (user.id == loggedUser.email) {
                favorites = user['liked'];
              }
            }
            return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  title: Text(
                    '${widget.course.name}\n',
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    'מספר קורס: ${widget.course.courseNumber}',
                    textDirection: TextDirection.rtl,
                  ),
                  trailing: TextButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    onPressed: (){
                      setState(() {
                        widget.favorite = !widget.favorite;
                        if (widget.favorite) {
                          favorites.add(widget.course.name);
                          firestore_instance
                              .collection("Favorites")
                              .doc(loggedUser.email)
                              .set({'liked': favorites});
                        } else {
                          favorites.remove(widget.course.name);
                          firestore_instance
                              .collection("Favorites")
                              .doc(loggedUser.email)
                              .set({'liked': favorites});
                        }
                      });

                    },
                    child: Icon(
                      widget.favorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  tileColor: Colors.orange[400],
                  onTap: () {

                    firestore_instance
                        .collection('course_popularity')
                        .doc(widget.course.courseNumber)
                        .get()
                        .then((snapshot) => {
                      if (snapshot.exists)
                        {
                          course_rating =
                          snapshot.data()['course_rating']
                        }
                    })
                        .then((value) =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CoursePage(
                                    course_name: widget.course.name,
                                    course_number: widget.course.courseNumber,
                                    credit_point: widget.course.credits,
                                    course_summary:
                                    widget.course.courseSummary,
                                    course_page_rating: course_rating,
                                  )))
                    });

                  },
                  onLongPress: () {
                  },
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
