import 'package:flutter/material.dart';
import 'package:my_recipe_box/createrecipe.dart';
import 'package:my_recipe_box/Recipe.dart';
import 'package:my_recipe_box/globals.dart';
import 'package:my_recipe_box/Data.dart';

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

List<Recipe> allRecipes = [];


class GetRecipes extends StatelessWidget {
  static final createGetUrl = 'https://www.myrecipebox.club/api/recipes';

  Future<bool> retrieveRecipes() async {


    var response = await http.get(createGetUrl,
      headers: {'content-type': 'application/json', 'cookie': 'jwt=' + token},
    );
    print("response is ");
    print(response.statusCode);

    //String decodedJson = jsonDecode(createGetUrl);
    //print("decodedJson is ");
    //print(decodedJson);
    var decodedJson = jsonDecode(response.body);
    //var rec = new Recipe.fromJson(decodedJson);// takes the output of jsondecode(), and creates the recipe object

    print("what we received is ");
    print(decodedJson['data']);

    allRecipes = Data.fromJson(decodedJson['data']).recipes;
    print("our list of recipes is ");
    print(allRecipes);

    // TODO: enter the recipes into the allRecipes list
    return true;
  }



  @override
  Widget build(BuildContext context) {
    allRecipes = [];
    Future<bool> egg = retrieveRecipes();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.
    List<String> recipeTitles = <String>[];
    List<String> recipeDescriptions = <String>[];


    print("allrecipes is ");
    print(allRecipes);
    print("recipes length is ");
    print(allRecipes.length);

    print("recipes length is ");
    print(allRecipes.length);
    //List<String> ingredients = <String>['Ingredient Placeholder 1', 'Recipe Placeholder 2', 'Recipe Placeholder 3'];
    return Scaffold(

    body: FutureBuilder(
        future: retrieveRecipes(),
        builder: (context, snapshot) {
          for (int i = 0; i < allRecipes.length; i++) {
            print("allRecipes[i].title is ");
            print(allRecipes[i].title);
            recipeTitles.add(allRecipes[i].title);
            recipeDescriptions.add(allRecipes[i].instructions);
          }
          //sleep(const Duration(seconds: 1));
          return snapshot.data != null
              ? Container(
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
                    itemCount: recipeTitles.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(

                                leading: Icon(Icons.local_dining),
                                title: Text("\n${recipeTitles[index]}"),
                                subtitle: Text("${recipeDescriptions[index]}"),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  FlatButton.icon(
                                    icon: const Icon(Icons.file_download), // NOTE: button icon
                                    label: Text("Get Recipe"),
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
          )
              : Center(child: CircularProgressIndicator());
        }),

    );
  }
}