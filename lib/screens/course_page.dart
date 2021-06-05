import 'package:bgu_course_grader/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  final String course_name;
  final String course_number;
  final String credit_point;
  // TODO: leave review button
  //TODO: See reviews for this course
  CoursePage({this.course_name, this.course_number, this.credit_point});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Text('שם הקורס:\n $course_name\n', textDirection: TextDirection.rtl,),
              Text('מספר הקורס:\n $course_number\n', textDirection: TextDirection.rtl,),
              Text('נק"ז:\n\ $credit_point\n', textDirection: TextDirection.rtl,)
            ],
          ),
        ),
      ),
    );
  }
}
