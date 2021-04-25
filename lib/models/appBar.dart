import 'package:flutter/material.dart';


final appBar = AppBar(
  title: Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),

  ),
  actions: [
    Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
          onPressed: (){},
          icon: Icon(Icons.person),
          label: Text('התנתקות')
      ),
    ),
    Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
          onPressed: (){},
          icon: Icon(Icons.settings),
          label: Text('הגדרות')
      ),
    ),
  ],
);