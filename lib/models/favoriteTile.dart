import 'package:bgu_course_grader/screens/course_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'course.dart';

class FavoriteTile extends StatelessWidget {
  final Course course;
  double course_rating = -1;
  final FirebaseFirestore firestore_instance = FirebaseFirestore.instance;
  FavoriteTile({this.course});


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
        onTap: () {
          firestore_instance
              .collection('course_popularity')
              .doc(course.courseNumber)
              .get()
              .then((snapshot) => {
            if (snapshot.exists)
              {
                course_rating =
                snapshot.data()['course_rating']
              }
          })
              .then((value) =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CoursePage(
                        course_name: course.name,
                        course_number: course.courseNumber,
                        credit_point: course.credits,
                        course_summary: course.courseSummary,
                        course_page_rating: course_rating,
                      ))));
        },
          title: Text(
            '${course.name}\n',
            textDirection: TextDirection.rtl,
          ),
          subtitle:
          Text(
            'מספר קורס: ${course.courseNumber}',
            textDirection: TextDirection.rtl,
          ),

          tileColor: Colors.orange[400],


        ),
      ),
    );
  }
}
