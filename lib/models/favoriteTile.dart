import 'package:flutter/material.dart';
import 'course.dart';

class FavoriteTile extends StatelessWidget {
  final Course course;
  FavoriteTile({this.course});


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
