import 'package:flutter/material.dart';

//import 'package:unit_converter/unit_converter.dart'; // for usage, see: https://pub.dev/packages/unit_converter

class Converter extends StatefulWidget {
  Converter({Key key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  Widget build(BuildContext context) {
    //List<String> units = <String>["Unit Placeholder 1", "Unit Placeholder 2", "Unit Placeholder 3"]; // TODO: add more
    String dropdownValue = "Teaspoons";
    return Container(


      child: Column(


        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

            ListTile(
              // contentPadding: , // TODO: add padding

              //leading: Icon(Icons.local_dining), // NOTE: could add an icon here
              //title: Text("\n${units[index]}"),
              subtitle: Text(
                  "\nPlease enter the amount you would like to convert:",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
            ),

            ListTile( // NOTE: DROPDOWN 1
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                    DropdownButton(

                      value: dropdownValue,
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
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Teaspoons', 'Tablespoons', 'Cups', 'Pints'].map<DropdownMenuItem<String>>((String value) {
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

                      value: dropdownValue,
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
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Teaspoons', 'Tablespoons', 'Cups', 'Pints'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                  ]
              )

          ),
        ],
      ),

    );
  }
}