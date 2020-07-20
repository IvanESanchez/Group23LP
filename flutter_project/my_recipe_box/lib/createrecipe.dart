import 'package:flutter/material.dart';
import 'package:my_recipe_box/main.dart';
import 'package:my_recipe_box/Recipe.dart';
import 'package:my_recipe_box/Ingredient.dart';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart'; // necessary for getting the current date for the header bar

String currentTitle, currentInstructions, currentUnit, currentIngredientName, currentAmount;

Ingredient currentIngredient;
List<Ingredient> _ingredients = [];

Recipe currentRecipe;

// creates a concrete implementation of _CreateRecipe. effectively just a wrapper
class CreateRecipe extends StatefulWidget {
  CreateRecipe({Key key}) : super(key: key);
  @override
  _CreateRecipe createState() => _CreateRecipe();
}



// this is abstract, but it's where the real magic happens.
class _CreateRecipe extends State<CreateRecipe> {
  static final createPostUrl = 'https://www.myrecipebox.club/api/recipes';

  Widget buildIngredientList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _ingredients.length) {
          return _buildIngredientList(_ingredients[index], index);
        } else return null;
      },
    );
  }

  Widget _buildIngredientList(Ingredient ingredient, int index) {
    return new ListTile(
        title: new Text(ingredient.name),
        onTap: () => _promptRemoveIngredient(index)
    );
  }

  // Much like _addTodoItem, this modifies the array of todo strings and
// notifies the app that the state has changed by using setState
  void _removeTodoItem(int index) {
    setState(() => _ingredients.removeAt(index));
  }

// Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveIngredient(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_ingredients[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  void _addIngredient(Ingredient ingredient) {
    // Only add the ingredient if the user actually entered something
    if (ingredient.name.length > 0 && ingredient.amount.length > 0 && ingredient.unit.length > 0) {
      setState(() => _ingredients.add(ingredient));
    }
    print("ingredients is " );
    print(_ingredients);
  }


  @override
  Widget build(BuildContext context) {

    //DateTime now = DateTime.now();
    //String formattedDate = DateFormat("EEEEEEEE, MMM dd").format(now); // NOTE: the month text will be truncated to 4 characters long.
    String formattedDate = "Recipe Creator";

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(

        color: Colors.green[50], // change this color to change the background color
        //backgroundColor: Colors.white,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Recipe Title',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              currentTitle = newValue;
                            });
                          },
                        ),




                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                            hintText: 'Instructions',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                               return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              setState(() {
                                currentInstructions = newValue;
                              });
                            },
                          ),
                        ),


                      ],
                    ),
                  ),

                  // TODO: add a card where the ingredient list will go
                  // TODO: add buttons and interface for adding ingredient


                  // TODO: add a pop-up menu for adding an ingredient: https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
                  // TODO: use this guide for creating a to-do list (similar): https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190




                ]
            )
          //padding: const EdgeInsets.all(10),



        ),

          //buildIngredientList(), // TODO: figure out why this breaks


          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
                child: RaisedButton.icon(
                  onPressed: () {
                    _pushIngredient();
                  },
                  label: Text("Add Ingredient", style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.add, color: Colors.white),
                  color: Colors.green,
                )
            )
          ),
          ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
          child: DropdownButtonFormField(

            //value: firstDropdownValue,
            //icon: Icon(Icons.arrow_downward), NOTE: could change the icon in the dropdown here
            iconSize: 24,
            elevation: 16,

            style: TextStyle(color: Colors.black), // NOTE: This is the color of the dropdown menu text
            decoration: InputDecoration(labelText: 'View Current Ingredients'),
            onChanged: (String newValue) {
              setState(() {
                _ingredients.remove(newValue);
                //firstDropdownValue = newValue;
              });
            },
            items: _ingredients.map<DropdownMenuItem<String>>((Ingredient value) {
              String allIngredientInfo = value.amount + " " + value.unit + "(s) of " + value.name;
              return DropdownMenuItem<String>(
                value: allIngredientInfo,
                child: Text(allIngredientInfo),
              );
            }).toList(),
          ),

              )
          ),
          ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: RaisedButton.icon(
                    onPressed: () {
                      setState(() => _ingredients.clear());

                    },
                    label: Text("Clear Ingredients", style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.remove, color: Colors.white),
                    color: Colors.red[400],

                  )
              )
          ),
        ]
            )
            )
          ),



        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () async {


              currentRecipe = new Recipe(currentTitle, currentInstructions, _ingredients);
              var response = await http.post(createPostUrl,
              body: {
                'name': currentRecipe.title,
                'ingredients': currentRecipe.ingredients, // TODO: talk to API and figure out how to handle the ingredients properly
                'directions': currentRecipe.instructions,
              });
              //print("response is ");
              //print(response.statusCode);
              if (response.statusCode == 200 || response.statusCode == 201) { // TODO: add loading icon while waiting
                // TODO: take the user back to my recipes or home
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHome()),
                );
              } else {
                // TODO: give error message to user
              }

            },
            child: Icon(Icons.check),
            backgroundColor: Colors.green,

          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );

  }
  void _pushIngredient() {

    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                resizeToAvoidBottomPadding: false,
                  appBar: new AppBar(
                      title: new Text('Add an Ingredient')
                  ),
                  backgroundColor: Colors.green[50],  // Set the background color of the App Bar
                  body: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                    ListTile(
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                    child:
                    TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Ingredient name',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              currentIngredientName = newValue;
                            });
                          },
                        ),
                  )
                    ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child:

                  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ingredient unit',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              setState(() {
                                currentUnit = newValue;
                              });
                            },
                          ),
                        ),
                )
              ),

              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child:
                  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ingredient amount',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              setState(() {
                                currentAmount = newValue;
                              });
                            },

                          ),
                        ),
                )
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child:
                  RaisedButton.icon(
                          label: Text('Add', style: TextStyle(
                              color: Colors.white
                          )),
                          color: Colors.green,
                          icon: const Icon(Icons.add, color: Colors.white), // NOTE: button icon
                          onPressed:() {
                            currentIngredient = new Ingredient(currentIngredientName, currentAmount, currentUnit);
                            _addIngredient(currentIngredient);
                            //print("ingredient name is ");
                            //print(ingredientName);
                            Navigator.pop(context); // Close the add todo screen
                          }

                        )
                )
              )

                      ],
                    ),
                  ),










                  /*
                  new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addIngredient(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter ingredient name',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),

                  )*/
              );
            }
        )
    );
  }
}