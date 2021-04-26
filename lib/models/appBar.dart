import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/settings/settings_main.dart';









class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.orange[800],
      title: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),

      ),
      actions: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange[800]),
              ),
              onPressed: (){},
              icon: Icon(Icons.person),
              label: Text('התנתקות')
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange[800]),
              ),
              onPressed:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsMenu())),
              icon: Icon(Icons.settings),
              label: Text('הגדרות')
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
}


