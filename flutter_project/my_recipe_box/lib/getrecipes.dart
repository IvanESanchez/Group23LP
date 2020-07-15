import 'package:flutter/material.dart';
import 'package:my_recipe_box/createrecipe.dart';

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar

class GetRecipes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.
    List<String> recipes = <String>["Recipe Placeholder 1", "Recipe Placeholder 2", "Recipe Placeholder 3"];
    //List<String> ingredients = <String>['Ingredient Placeholder 1', 'Recipe Placeholder 2', 'Recipe Placeholder 3'];
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

        body: ListView.separated(
          //padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          itemCount: recipes.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(

                      leading: Icon(Icons.local_dining),
                      title: Text("\n${recipes[index]}"),
                      subtitle: Text("More information can go here, such as author name, or ingredients"),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text("Get Recipe"),
                          color: Colors.red[400],
                          onPressed: () {
                            // NOTE: this is what happens when the "Get Recipe" button is pressed
                          },
                        ),
                        /*FlatButton(
                          child: const Text('another button could go here'),
                          onPressed: () {/* ... */},
                        ), */
                      ],
                    ),
                  ],
                ),
              ),

            );
          },

        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0.0,
          icon: const Icon(Icons.create), // NOTE: button icon
          backgroundColor: Colors.red[400], // NOTE: button color
          onPressed: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateRecipe()),
            );
          },
          label: Text('Create'),
        )
      )
    );
  }
}