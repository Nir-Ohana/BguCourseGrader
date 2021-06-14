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

    return GestureDetector(
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
        child: Card(
        elevation: 3,
        color: Color(0xE6FFFFFF),
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child:Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        children: [
        Container(
        height: 135.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(233, 233, 233, 0.0),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${course.name}\n',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'מחלקה: ${course.depName}',
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(139, 144, 165, 1),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'נק"ז: ${course.credits}',
              textDirection: TextDirection.rtl,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color.fromRGBO(139, 144, 165, 1),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Row(
              children: [
                Text(
                  'מספר קורס: ${course.courseNumber}',
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(139, 144, 165, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),]),),),);}}




