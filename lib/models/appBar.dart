import 'package:bgu_course_grader/provider/google_sign_in.dart';
import 'package:bgu_course_grader/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:bgu_course_grader/screens/settings/settings_main.dart';
import 'package:provider/provider.dart';

import 'inputDec.dart';







class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return AppBar(
        backgroundColor: Colors.orangeAccent[400],
      title: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),

      ),
      leading: BackButton(
        color: Colors.white,
        onPressed: (){Navigator.canPop(context)? Navigator.of(context).pop(): Navigator.push(context,
            MaterialPageRoute(builder: (context) => Menu()));},
      ),
      actions: [
        // Directionality(
        //   textDirection: TextDirection.rtl,
        //   child: ElevatedButton.icon(
        //       style: ButtonStyle(
        //         backgroundColor:  MaterialStateProperty.all<Color>(Colors.orangeAccent[400]),
        //       ),
        //       onPressed: () {
        //         final provider = Provider.of<GoogleSignInProvider>(
        //             context, listen: false);
        //         provider.logout();
        //       },
        //       icon: Icon(Icons.person),
        //       label: Text('התנתקות')
        //   ),
        // ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(Colors.orangeAccent[400]),
              ),
              onPressed:  (){ Navigator.push(context,
    MaterialPageRoute(builder: (context) => SettingsMenu()));},
              // Scaffold(
              //   drawer: SettingsMenu()
              // ),
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



class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
            decoration: textInputDecoration,
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val ),
          ),
          SizedBox(height: 10.0),
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            min: 100.0,
            max: 900.0,
            divisions: 8,
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          ElevatedButton(
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              }
          ),
        ],
      ),
    );
  }
}



