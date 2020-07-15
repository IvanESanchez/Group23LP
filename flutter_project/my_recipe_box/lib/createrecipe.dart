import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar

class CreateRecipe extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.

    return Container(
        color: Colors.green[50], // change this color to change the background color
        //backgroundColor: Colors.white,
        child: Scaffold(
        backgroundColor: Colors.green[50],
        // Appbar
        appBar: AppBar( // NOTE: AppBar is the header of the app
        // Title
        // TODO: use this link to change the title dynamically: https://stackoverflow.com/questions/52333151/how-to-change-the-app-bar-title-in-flutter
        title: Text(
        //userName + spacing + formattedDate,
        formattedDate
        ),

        centerTitle: true,
        backgroundColor: Colors.green,  // Set the background color of the App Bar
        actions: <Widget>[
        // action button
        // TODO: uncomment to add button
        /*IconButton(
        icon: Icon(choices[0].icon),
        tooltip: "My Profile",
        onPressed: () {
        //_select(choices[0]);
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProfile()),
        );
        },
        ),*/
        // action button
        // overflow menu

        ],
        ),
        // Set the TabBar view as the body of the Scaffold

        body:
        ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[


                // TODO: add the text entry boxes here


              ],

        )
        )
    );
  }
}