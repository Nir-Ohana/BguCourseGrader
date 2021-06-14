import 'package:bgu_course_grader/models/show_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTile extends StatelessWidget {
  final String userName;
  final String reviewContent;
  final String time;
  final String photo;
  final double user_rating;

  ReviewTile(
      {this.userName,
      this.reviewContent,
      this.time,
      this.photo,
      this.user_rating});

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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile(userName)));
              },
              trailing: ClipOval(
                  child: Image.network(photo) != null
                      ? Image.network(photo)
                      : Image.network(
                          "https://cdn3.iconfinder.com/data/icons/users-outline/60/50_-Blank_Profile-_user_people_group_team-512.png")),
              title: Text(
                userName,
                textDirection: TextDirection.rtl,
              ),
              subtitle: Text(
                reviewContent,
                textDirection: TextDirection.rtl,
              ),
            ),
            RatingBarIndicator(
              rating: user_rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 30.0,
              direction: Axis.horizontal,
            ),
            Text(
              time,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
