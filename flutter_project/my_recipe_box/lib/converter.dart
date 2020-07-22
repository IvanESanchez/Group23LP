import 'package:flutter/material.dart';
import 'dart:convert';

//import 'package:unit_converter/unit_converter.dart'; // for usage, see: https://pub.dev/packages/unit_converter

class Converter extends StatefulWidget {
  Converter({Key key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  var firstDropdownValue = "Ounces";
  var secondDropdownValue = "Tablespoons";
  var amountEntry = "";
  var resultValue = "";
  String unitConversion(String amountEntry, String firstUnit, String secondUnit) {


    // TODO: check that amountEntry is a valid input (only numeric or period). if not, return "INVALID AMOUNT VALUE"
    // TODO: any other units to support?


    double numericAmount = double.parse(amountEntry);

    double middle;

    // converts to ounces
    switch(firstUnit) {
      case "Ounces":
        middle = numericAmount;
        break;

      case "Teaspoons":
        middle = numericAmount * 0.166667;
        break;

      case "Tablespoons":
        middle = numericAmount * 0.5;
        break;

      case "Cups":
        middle = numericAmount * 8;
        break;

      case "Pints":
        middle = numericAmount * 16;
        break;

      case "Quarts":
        middle = numericAmount * 32;
        break;

      case "Gallons":
        middle = numericAmount * 128;
        break;
    }

    double numericResult;

    switch(secondUnit) {
      case "Ounces":
        numericResult = middle;
        break;

      case "Teaspoons":
        numericResult = middle * 6;
        break;

      case "Tablespoons":
        numericResult = middle * 2;
        break;

      case "Cups":
        numericResult = middle * 0.125;
        break;

      case "Pints":
        numericResult = middle * 0.0625;
        break;

      case "Quarts":
        numericResult = middle * 0.03125;
        break;

      case "Gallons":
        numericResult = middle * 0.0078125;
        break;
    }


    String result = numericResult.toStringAsFixed(2) + " " + secondDropdownValue.toLowerCase();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50], // change this color to change the background color


      child: Column(


        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

        ListTile( // NOTE: DROPDOWN 1
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [

                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Container(

                      width: 100.0,
                      child: TextFormField( // NOTE: text entry for amount

                        decoration: InputDecoration(
                          border: new OutlineInputBorder(borderSide: new BorderSide()),
                          labelText: 'Amount:'
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (newValue) {
                          setState(() {
                            amountEntry = newValue;
                          });
                        },
                      ),

                    ),
                  ),

                  DropdownButton(

                    value: firstDropdownValue,
                    //icon: Icon(Icons.arrow_downward), NOTE: could change the icon in the dropdown here
                    iconSize: 24,
                    elevation: 16,

                    style: TextStyle(color: Colors.black), // NOTE: This is the color of the dropdown menu text
                    underline: Container(
                      height: 2,
                      color: Colors.green, // NOTE: this is the color of the underline of the dropdown
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        firstDropdownValue = newValue;
                      });
                    },
                    items: <String>['Ounces', 'Teaspoons', 'Tablespoons', 'Cups', 'Pints', 'Quarts', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                ]
            )

        ),

        ListTile( // NOTE: DOWN ARROW
          title: Icon(
              Icons.arrow_downward,
              color: Colors.black,
          ),
        ),
        ListTile( // NOTE: DROPDOWN 2
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                DropdownButton(

                  value: secondDropdownValue,
                  //icon: Icon(Icons.arrow_downward), NOTE: could change the icon in the dropdown here
                  iconSize: 24,
                  elevation: 16,

                  style: TextStyle(color: Colors.black), // NOTE: This is the color of the dropdown menu text
                  underline: Container(
                    height: 2,
                    color: Colors.green, // NOTE: this is the color of the underline of the dropdown
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      secondDropdownValue = newValue;
                    });
                  },
                  items: <String>['Ounces', 'Teaspoons', 'Tablespoons', 'Cups', 'Pints', 'Quarts', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),


                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          resultValue = unitConversion(amountEntry, firstDropdownValue, secondDropdownValue);
                        });

                      },
                      textColor: Colors.white,
                      color: Colors.red[400],
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child:
                        const Text('Convert', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                ),


                RichText( // NOTE: result  here
                  text: TextSpan(text: '', style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: resultValue, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ]
            )
        ),
        ],
      ),
    );
  }
}
