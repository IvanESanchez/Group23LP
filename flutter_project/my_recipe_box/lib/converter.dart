import 'package:flutter/material.dart';

import 'package:unit_converter/unit_converter.dart'; // for usage, see: https://pub.dev/packages/unit_converter

class Converter extends StatelessWidget {
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
                    Icons.loop,
                    size: 160.0,
                    color: Colors.grey,
                  ),
                  Text(
                    "Converter",
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