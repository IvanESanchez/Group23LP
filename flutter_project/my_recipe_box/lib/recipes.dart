import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[50], // change this color to change the background color
        child: Scaffold(
          //backgroundColor: Colors.white,
          body: Container(
            color: Colors.green[50], // change this color to change the background color
            child: Center(
              child: Column(
                // center the children
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.list,
                    size: 160.0,
                    color: Colors.grey,
                  ),
                  Text(
                    "Get Recipes",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}