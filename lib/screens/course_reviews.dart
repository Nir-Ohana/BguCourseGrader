
import 'package:bgu_course_grader/models/reviewsList.dart';
import 'package:flutter/material.dart';





class CourseReviews extends StatelessWidget {

  final String courseName;

  CourseReviews({this.courseName});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[300],
      body: Container(
        child: reviewsList(courseName: courseName,)
      ),


    );
  }
}
