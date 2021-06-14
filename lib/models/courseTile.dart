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
  double course_rating = -1;

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
            return
              GestureDetector(
                onTap: () {
                  {

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

                  }
                },
                child: Card(
                elevation: 3,
                color: Color(0xE6FFFFFF),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 135.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(233, 233, 233, 0.0),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                        '${widget.course.name}\n',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                                  'מחלקה: ${widget.course.depName}',
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromRGBO(139, 144, 165, 1),
                                  ),
                                ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'נק"ז: ${widget.course.credits}',
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromRGBO(139, 144, 165, 1),
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'מספר קורס: ${widget.course.courseNumber}',
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromRGBO(139, 144, 165, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(
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
                    ],
                  ),
                ),
              ));
          } else {
            return Loading();
          }
        });
  }
}

