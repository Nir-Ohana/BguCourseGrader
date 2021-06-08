import 'package:flutter/material.dart';



class ReviewTile extends StatelessWidget {

  final String userName;
  final String reviewContent;
  final String time;

  ReviewTile({this.userName, this.reviewContent, this.time});





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
              title: Text(userName),
              subtitle: Text(reviewContent),
            ),
            Text(time)
          ],
        ),
      ),
    );
  }
}
