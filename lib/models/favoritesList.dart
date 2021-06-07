import 'package:bgu_course_grader/models/favoriteTile.dart';
import 'package:bgu_course_grader/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'course.dart';


class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final loggedInUser = FirebaseAuth.instance.currentUser;


    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Favorites').snapshots(),
        builder: (context, favSnapshot){
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('courses').snapshots(),
            builder:(context, courseSnapshot){
              List<FavoriteTile> favoriteTiles = [];
              List<dynamic> favorites = [];
              if(favSnapshot.hasData){
                if(courseSnapshot.hasData){
                  final courses = courseSnapshot.data.docs;
                  final favoriteUsers = favSnapshot.data.docs;
                  for (var favoriteDoc in favoriteUsers){
                    if(favoriteDoc.id == loggedInUser.email){
                      favorites = favoriteDoc['liked'];
                      break;
                    }
                  }
                  for (var course in courses){
                    final courseData = (course.data() as Map<String, dynamic>);
                    final courseName = courseData['course_name'];
                    if(favorites.contains(courseName)){
                      final courseName = courseData['course_name'];
                      final courseNum = courseData['course_number'];
                      final courseCredit = courseData['credit_point'];
                      final courseDepName = courseData['department_name'];
                      final courseTest = courseData['test_exists'];
                      final courseSummary = courseData['course_summary'];
                      final Course courseToBuild = Course(
                          name: courseName,
                          courseNumber: courseNum,
                          credits: courseCredit,
                          depName: courseDepName,
                          test: courseTest,
                          courseSummary: courseSummary);
                      final favoriteWidget = FavoriteTile(
                        course: courseToBuild,
                      );
                      favoriteTiles.add(favoriteWidget);
                    }

                  }

                  return ListView(
                    children: favoriteTiles,
                  );
                } else { return Loading();}
              } else { return Loading();}
            } ,
          );
        }
    );
  }
}





