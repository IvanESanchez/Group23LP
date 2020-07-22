import 'package:flutter/material.dart';
import 'package:my_recipe_box/getrecipes.dart';

class MyRecipes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<String> recipes = <String>["Recipe Placeholder 1", "Recipe Placeholder 2", "Recipe Placeholder 3"];
    //List<String> ingredients = <String>['Ingredient Placeholder 1', 'Recipe Placeholder 2', 'Recipe Placeholder 3'];
    return Container(
        color: Colors.green[50], // change this color to change the background color
        //backgroundColor: Colors.white,

        child: new Scaffold (
          backgroundColor: Colors.green[50],
          body: ListView.separated(
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
                            child: const Text("View Recipe"),
                            color: Colors.red[400],
                            onPressed: () {
                              // NOTE: this is what happens when the "View Recipe" button is pressed
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                  height: 600.0, // NOTE: THIS IS THE HEIGHT OF THE RECIPE POP-UP WINDOW
                                  width: 400.0,
                                  child: ListView(
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Recipe Title Placeholder",
                                        style: TextStyle(fontSize: 24, /*color: Colors.blue,*/ fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(child: Text("Recipe Ingredients Placeholder")),
                                    SizedBox(height: 20),
                                      Center(child: Text("Recipe Instructions Placeholder")),
                                  ]
                                  )
                                  )
                                  );
                                }

                              );
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
                icon: const Icon(Icons.add), // NOTE: button icon
                backgroundColor: Colors.red[400], // NOTE: button color
                onPressed: ()
                {
                  // TODO: open the getrecipes.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetRecipes()),
                  );
                },
                label: Text('New Recipe'),
            )
        )





    );
  }


}

/*

        FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Approve'),
          icon: Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
        ),
 */

