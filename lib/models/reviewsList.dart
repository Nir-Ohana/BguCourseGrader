import 'package:bgu_course_grader/models/reviewTile.dart';
import 'package:bgu_course_grader/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class reviewsList extends StatelessWidget {


  
  final _firestore = FirebaseFirestore.instance;
  final String courseName;
  reviewsList({this.courseName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Reviews').snapshots(),
      builder: (context, snapshot){
        List<ReviewTile> reviewTiles = [];
        if(snapshot.hasData) {
          final reviews = snapshot.data.docs;
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          for(var review in reviews){
            if(review['course_name'] == this.courseName){
              final String userName = review['name'];
              final String content = review['review_content'];
              final String photo = review['user_photo'];
              final double user_rating = review['user_rating'];
              final String formatted = formatter.format(DateTime.parse(review['time']));
              reviewTiles.add(ReviewTile(userName: userName, reviewContent: content, time: formatted, photo: photo, user_rating: user_rating,));
            }
          }
          return ListView(
            children: reviewTiles,
          );
        } else{return Loading();}
      }
      );
  }
}
