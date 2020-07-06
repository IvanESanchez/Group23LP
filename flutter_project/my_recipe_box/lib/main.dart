import 'package:flutter/material.dart';
import 'package:my_recipe_box/home.dart';
import 'package:my_recipe_box/myprofile.dart';
import 'package:my_recipe_box/recipes.dart';
import 'package:my_recipe_box/calendar.dart';
import 'package:my_recipe_box/converter.dart';

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar

// figma prototype for reference: https://www.figma.com/file/YY8KiR8jFirvmOcPsZyNer/Untitled

void main() {
  runApp(MaterialApp(
    // Title
      title: "MyRecipeBox",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // Home
      home: MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEEEEEE, MMMM dd').format(now); // NOTE: the month text will be truncated to 4 characters long.
    return Scaffold(
      // Appbar
      appBar: AppBar( // NOTE: AppBar is the header of the app
        // Title
        title: Text("<Name of User>                 " + formattedDate), // TODO: use this link to change the title dynamically: https://stackoverflow.com/questions/52333151/how-to-change-the-app-bar-title-in-flutter
        centerTitle: true,
        backgroundColor: Colors.green,  // Set the background color of the App Bar
      ),
      // Set the TabBar view as the body of the Scaffold
      body: TabBarView( // NOTE: TabBarView is the footer of the app
        // Add tabs as widgets
        children: <Widget>[Home(), MyProfile(), Recipes(), Calendar(), Converter()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.green,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'My Profile',
            ),
            Tab(
              icon: Icon(Icons.list),
              text: 'Recipes',
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              text: 'Calendar',
            ),
            Tab(
              icon: Icon(Icons.loop),
              text: 'Converter',
            ),
          ],
          // setup the controller
          controller: controller,

          labelPadding: const EdgeInsets.all(8.0),
          indicatorColor: Colors.white, // this sets the color for the glowing line under the current tab
        ),
      ),
    );
  }
}
