import 'package:flutter/material.dart';

// TODO: add a refresh indicator: https://api.flutter.dev/flutter/material/RefreshIndicator-class.html
// NOTE: used this as a starting guide: https://pusher.com/tutorials/flutter-listviews

// TODO: maybe switch to a nested scroll view ()

class Home extends StatelessWidget {


  Widget build(BuildContext context) {
    final titles = ['Grocery List', 'Today\'s Recipes'];
    final bodies = ['\nThis is just some placeholder text.\nEggs\nPeanut Butter\nOne grocery will go here\nChicken Tender Sub\nBread\nHopefully I can figure out how to make this look more like a grocery list and less like a sticky note', '\nHere\'s more placeholder text:\nBread Pudding\nKit Kat Lasagna\n3-Day Potato Salad\nPickled Watermelon Rind'];
    return Container(
      color: Colors.green[50], // change this color to change the background color
      child: ListView.builder(

        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(

            color: Colors.white, // Change this color to change the color of the card
            child: ListTile(
              title: Text(titles[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(bodies[index], style: TextStyle(fontSize: 16, )),
            )
          );
        },
      )
    );
  }
}