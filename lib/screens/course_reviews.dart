import 'package:bgu_course_grader/models/appBar.dart';
import 'package:bgu_course_grader/models/reviewsList.dart';
import 'package:flutter/material.dart';





class CourseReviews extends StatelessWidget {

  final String courseName;

  CourseReviews({this.courseName});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[300],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: reviewsList(courseName: courseName,)
        ),
      ),


    );
  }
}
