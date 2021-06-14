
import 'package:bgu_course_grader/models/favoritesList.dart';
import 'package:flutter/material.dart';

import 'package:bgu_course_grader/models/courseList.dart';




class CourseList extends StatefulWidget {
  final bool filtered;
  final String department;
  final String courseName;
  final String courseNum;
  final bool finalExam;
  final bool favorites;





  CourseList({this.filtered, this.department, this.courseNum, this.courseName, this.finalExam, this.favorites});




  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orangeAccent[100],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: widget.favorites ? FavoriteList() : CoursesList(filtered: widget.filtered,dep: widget.department,
          courseName: widget.courseName, courseNum: widget.courseNum,
          hasTest: !widget.finalExam),
        ),
      ),


    );
  }
}





















// class CourseList extends StatefulWidget {
//   @override
//   _CourseListState createState() => _CourseListState();
// }
//
// class _CourseListState extends State<CourseList> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Course>>.value(
//       initialData: [],
//       value: DataBaseService().courses,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.orange[300],
//         appBar: MyAppBar(),
//         body: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Container(
//             child: CoursesList(),
//           )
//         ),
//       ),
//     );
//   }
// }
