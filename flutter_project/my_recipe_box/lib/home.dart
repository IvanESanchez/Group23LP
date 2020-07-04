import 'package:flutter/material.dart';

// TODO: add a refresh indicator: https://api.flutter.dev/flutter/material/RefreshIndicator-class.html
// NOTE: used this as a starting guide: https://pusher.com/tutorials/flutter-listviews

// TODO: maybe switch to a nested scroll view ()

class Home extends StatelessWidget {


  Widget build(BuildContext context) {
    final titles = ['Grocery List Placeholder', 'Today\'s Recipes Placeholder'];
    final bodies = ['Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'];
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(titles[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text(bodies[index], style: TextStyle(fontSize: 16, )),
          )
        );
      },
    );
  }
}