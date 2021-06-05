import 'package:bgu_course_grader/screens/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/appBar.dart';
import 'package:bgu_course_grader/models/courseList.dart';
import 'package:provider/provider.dart';
import 'package:bgu_course_grader/DataBase.dart';
import 'package:bgu_course_grader/models/course.dart';



class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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
