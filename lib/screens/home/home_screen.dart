import 'package:flutter/material.dart';
import 'package:bgu_course_grader/menu/menu_screen.dart';

class HomeScreen extends StatelessWidget {
  // might need to convert to statful
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Center(child: Text('מסך בית')),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Menu()));
              }),
        ],
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(child: Text('ברוך הבא...')),
              SizedBox(height: 20,),
              Center(child: Text('פקולטה:')),
              SizedBox(height: 20,),
              Center(child: Text('מחלקה')),
              SizedBox(height: 20,),
              Center(child: Text('הידעת?')),
            ],
          ),
        ),
      ),
    );
  }
}
