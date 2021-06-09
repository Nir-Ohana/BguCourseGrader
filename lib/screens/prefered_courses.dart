
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/courseList.dart';

class PrefferedCourses extends StatefulWidget { // TODO maybe delete page
  @override
  _PrefferedCoursesState createState() => _PrefferedCoursesState();
}

class _PrefferedCoursesState extends State<PrefferedCourses> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[300],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: CoursesList(),
        ),
      ),


    );
  }
}
