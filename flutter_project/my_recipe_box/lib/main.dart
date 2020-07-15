import 'package:flutter/material.dart';
import 'package:my_recipe_box/grocerylist.dart';
import 'package:my_recipe_box/todaysrecipes.dart';
import 'package:my_recipe_box/myprofile.dart';
import 'package:my_recipe_box/getrecipes.dart';
import 'package:my_recipe_box/myrecipes.dart';
import 'package:my_recipe_box/createrecipe.dart';
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
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
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


  //Choice _selectedChoice = choices[0]; // The app's "state".

  //void _select(Choice choice) {
  // Causes the app to rebuild with the new _selectedChoice.
  //setState(() {
 //   _selectedChoice = choice;
  //});
  //}
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.
    //String userName = '<Name of User>'; // TODO: get the actual user's name
    //String spacing = "                 ";
    return Scaffold(
      // Appbar
      appBar: AppBar( // NOTE: AppBar is the header of the app
        // Title
        // TODO: use this link to change the title dynamically: https://stackoverflow.com/questions/52333151/how-to-change-the-app-bar-title-in-flutter
        title: Text(
          //userName + spacing + formattedDate,
          formattedDate,
        ),

        centerTitle: true,
        backgroundColor: Colors.green,  // Set the background color of the App Bar
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(choices[0].icon),
            tooltip: "My Profile",
            onPressed: () {
              //_select(choices[0]);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfile()),
              );
            },
          ),
          // action button
          // overflow menu

        ],
      ),
      // Set the TabBar view as the body of the Scaffold
      body: TabBarView( // NOTE: TabBarView is the footer of the app
        // Add tabs as widgets
        children: <Widget>[GroceryList(), TodaysRecipes(), MyRecipes(), Calendar(), Converter()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.green,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          // setup the controller
          controller: controller,

          labelPadding: const EdgeInsets.all(8.0),
          indicatorColor: Colors.white, // this sets the color for the glowing line under the current tab
          indicatorWeight: 5,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(),

          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.local_grocery_store),
              text: "Grocery\n    List",
            ),
            Tab(
              icon: Icon(Icons.today),
              text: "Today's\nRecipes",
            ),
            Tab(
              icon: Icon(Icons.list),
              text: "    My\nRecipes",
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              text: "  Weekly\nCalendar",
            ),
            Tab(
              icon: Icon(Icons.loop),
              text: "     Unit\nConverter",
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
const List<Choice> choices = const <Choice>[
  const Choice(title: "My Profile", icon: Icons.person),


];
