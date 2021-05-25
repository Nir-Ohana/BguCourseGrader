
import 'package:bgu_course_grader/models/course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bgu_course_grader/screens/loading.dart';
import 'package:bgu_course_grader/models/courseTile.dart';

class CoursesList extends StatefulWidget {
  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList>{

  @override
  Widget build(BuildContext context) {

    final courses = Provider.of<List<Course>>(context); // can also solve with ?? []
    if (courses == null){
      return Loading();
    } else {
      courses.forEach((element) {
        print(element.name);
        print(element.courseNumber);
        print(element.openIn);
      }
      );
    }
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index){
        return CourseTile(course: courses[index]);
      },
    );
  }
}
