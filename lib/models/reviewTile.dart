import 'package:bgu_course_grader/models/show_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final String userName;
  final String reviewContent;
  final String time;
  final String photo;

  ReviewTile({this.userName, this.reviewContent, this.time, this.photo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onLongPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile(userName)));
              },
              leading: ClipOval(child: Image.network(photo)!=null?Image.network(photo): Image.network("https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png")),
              title: Text(
                userName,
                textDirection: TextDirection.rtl,
              ),
              subtitle: Text(
                reviewContent,
                textDirection: TextDirection.rtl,
              ),
            ),
            Text(
              time,
              textDirection: TextDirection.rtl,
            )
          ],
        ),
      ),
    );
  }
}
