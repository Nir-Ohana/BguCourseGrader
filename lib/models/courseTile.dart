import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/course.dart';


class CourseTile extends StatelessWidget {

  final Course course;
  CourseTile({this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text('${course.name}       ${course.courseNumber}'),
          subtitle: Text('${course.credits}    ${course.test}   ${course.depName}'),
        ),
      ),
    );
  }
}
