import 'package:bgu_course_grader/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bgu_course_grader/screens/loading.dart';
import 'package:bgu_course_grader/models/courseTile.dart';

class CoursesList extends StatefulWidget {
  final bool filtered;
  final String dep;
  final String courseName;
  final String courseNum;
  final bool hasTest;


  CoursesList(
      {this.filtered,
      this.dep,
      this.courseName,
      this.courseNum,
      this.hasTest,
      });

  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
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

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Stream returnAll() {
    return _firestore.collection('courses').snapshots();
  }

  Stream returnFiltered() {
    Query collection = _firestore.collection('courses');
    // List<String> courses_with_rating =
    //     []; // saving courses with equal or greater than provided rating to join on courses Table.

    if (widget.dep != '') {
      collection = collection.where('department_name', isEqualTo: widget.dep);
    }
    if (widget.courseName != '') {
      collection = collection
          .where('course_name', isGreaterThanOrEqualTo: widget.courseName)
          .where('course_name', isLessThan: widget.courseName + '\u0600');
    }
    if (widget.courseNum != '') {
      collection =
          collection.where('course_number', isEqualTo: widget.courseNum);
    }
    if (!widget.hasTest) {
      collection = collection.where('test_exists', isEqualTo: widget.hasTest);
    }

      // _firestore
      //     .collection('course_popularity')
      //     .where('course_rating', isGreaterThanOrEqualTo: widget.rating)
      //     .get()
      //     .then((coursePopularitySnapshots) => {
      //           for (var snapshot in coursePopularitySnapshots.docs.toList())
      //             {print(DateTime.now().toString()), courses_with_rating.add(snapshot.id),},
      //         })
      //     .then((_) => collection =
      //         collection.where('course_number', whereIn: courses_with_rating));

    print("here " + DateTime.now().toString());
    return collection.snapshots();
  }

  Stream returnFavorites() {
    return _firestore.collection('Favorites').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.filtered ? returnFiltered() : returnAll(),
        builder: (context, snapshot1) {
          return StreamBuilder<QuerySnapshot>(
            stream: returnFavorites(),
            builder: (context, snapshot2) {
              List<CourseTile> coursesList = [];
              if (snapshot1.hasData) {
                if (snapshot2.hasData) {
                  final courses = snapshot1.data.docs;
                  final favoriteUsers = snapshot2.data.docs;
                  List<dynamic> favorites = [];
                  for (var favoriteDoc in favoriteUsers) {
                    if (favoriteDoc.id == loggedInUser.email) {
                      favorites = favoriteDoc['liked'];
                      break;
                    }
                  }
                  for (var course in courses) {
                    final courseData = (course.data() as Map<String, dynamic>);
                    final courseName = courseData['course_name'];
                    final courseNum = courseData['course_number'];
                    final courseCredit = courseData['credit_point'];
                    final courseDepName = courseData['department_name'];
                    final courseTest = courseData['test_exists'];
                    final courseSummary = courseData['course_summary'];
                    final Course courseToBuild = Course(
                        name: courseName,
                        courseNumber: courseNum,
                        credits: courseCredit,
                        depName: courseDepName,
                        test: courseTest,
                        courseSummary: courseSummary);
                    final courseWidget = CourseTile(
                      course: courseToBuild,
                      favorite: favorites.contains(courseName),
                    );
                    coursesList.add(courseWidget);
                  }
                } else {
                  return Loading();
                }
              } else {
                return Loading();
              }
              return coursesList.isNotEmpty
                  ? ListView(
                      children: coursesList,
                    )
                  : Text('no courses were found with those attributes');
            },
          );
        });
  }
}
