
import 'package:bgu_course_grader/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:bgu_course_grader/screens/loading.dart';
import 'package:bgu_course_grader/models/courseTile.dart';

class CoursesList extends StatefulWidget {
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





  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('courses').snapshots(),
          builder: (context, snapshot) {
          List<CourseTile> coursesList = [];
          if (snapshot.hasData) {
            final courses = snapshot.data.docs;
            for (var course in courses) {
              final courseData = (course.data() as Map<String, dynamic>);
              final courseName = courseData['course_name'];
              final courseNum = courseData['course_number'];
              final courseCredit = courseData['credit_point'];
              final courseDepName = courseData['department_name'];
              final courseTest = courseData['test_exists'];
              final Course courseToBuild = Course(name: courseName,
              courseNumber: courseNum, credits: courseCredit, depName: courseDepName,
              test: courseTest);
              final courseWidget = CourseTile(course: courseToBuild,);
              coursesList.add(courseWidget);
            }
          } else {
            return Loading();
          }
          return ListView(
              children: coursesList,
          );
        });
  }
}

















// class CoursesList extends StatefulWidget {
//   @override
//   _CoursesListState createState() => _CoursesListState();
// }
//
// class _CoursesListState extends State<CoursesList>{
//
//   @override
//   Widget build(BuildContext context) {
//
//     final courses = Provider.of<List<Course>>(context); // can also solve with ?? []
//     if (courses == null){
//       return Loading();
//     } else {
//       courses.forEach((element) {
//         print(element.name);
//         print(element.courseNumber);
//         print(element.openIn);
//       }
//       );
//     }
//     return ListView.builder(
//       itemCount: courses.length,
//       itemBuilder: (context, index){
//         return CourseTile(course: courses[index]);
//       },
//     );
//   }
// }
