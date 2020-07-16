import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar



// creates a concrete implementation of _CreateRecipe. effectively just a wrapper
class CreateRecipe extends StatefulWidget {
  CreateRecipe({Key key}) : super(key: key);



  @override
  _CreateRecipe createState() => _CreateRecipe();
}


// this is abstract, but it's where the real magic happens.
class _CreateRecipe extends State<CreateRecipe> {
  List<String> _ingredients = [];

  void _addIngredient(String ingredient) {
    // Only add the ingredient if the user actually entered something
    if (ingredient.length > 0) {
      setState(() => _ingredients.add(ingredient));
    }
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.

    return Scaffold(
      body: Container(
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
        ),
        // Set the TabBar view as the body of the Scaffold

        body: Column(


        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        ListTile(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter the recipe title here',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),




                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                            hintText: 'Enter the instructions here',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                               return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),


                      ],
                    ),
                  ),


                  // TODO: add a pop-up menu for adding an ingredient: https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
                  // TODO: use this guide for creating a to-do list (similar): https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190




                ]
            )
          //padding: const EdgeInsets.all(10),



        )
        ]
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              // TODO: add the actual recipe
            },
            child: Icon(Icons.check),
            backgroundColor: Colors.greenAccent,

          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      )
    );
  }
}