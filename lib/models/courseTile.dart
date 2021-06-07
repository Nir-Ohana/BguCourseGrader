import 'package:bgu_course_grader/screens/course_page.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/models/course.dart';

class CourseTile extends StatefulWidget {
  final Course course;
  bool favorite;
  CourseTile({this.course, this.favorite});

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(
            '${widget.course.name}\n',
            textDirection: TextDirection.rtl,
          ),
          subtitle:
              Text(
            'מספר קורס: ${widget.course.courseNumber}',
            textDirection: TextDirection.rtl,
          ),
          trailing: Icon(widget.favorite ?
              Icons.favorite : Icons.favorite_border,
          color: Colors.red,),
          tileColor: Colors.orange[400],
          onTap: (){
            setState(() {
              widget.favorite = !widget.favorite;
            });
            },
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursePage(
                          course_name: widget.course.name,
                          course_number: widget.course.courseNumber,
                          credit_point: widget.course.credits,
                          course_summary: widget.course.courseSummary,
                        )));
          },
        ),
      ),
    );
  }
}
