import 'package:bgu_course_grader/screens/course_page.dart';
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
          title: Text(
            '${course.name}\n',
            textDirection: TextDirection.rtl,
          ),
          subtitle:
              // ${course.test}   ${course.depName}
              // (course.test ? 'קיים מבחן: כן' : 'קיים מבחן: לא') //TODO: enter in a separate page
              //'נק"ז: ${course.credits}'
              Text(
            'מספר קורס: ${course.courseNumber}',
            textDirection: TextDirection.rtl,
          ),
          tileColor: Colors.orange[400],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursePage(
                          course_name: course.name,
                          course_number: course.courseNumber,
                          credit_point: course.credits,
                        )));
          },
        ),
      ),
    );
  }
}
