import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;

// TODO: add a refresh indicator: https://api.flutter.dev/flutter/material/RefreshIndicator-class.html
// NOTE: used this as a starting guide: https://pusher.com/tutorials/flutter-listviews


/*
class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  bool _isSelected = false;

  Widget build(BuildContext context) {
    //final titles = ['Grocery List', 'Today\'s Recipes'];
    //final bodies = ['\nThis is just some placeholder text.\nEggs\nPeanut Butter\nOne grocery will go here\nChicken Tender Sub\nBread\nHopefully I can figure out how to make this look more like a grocery list and less like a sticky note', '\nHere\'s more placeholder text:\nBread Pudding\nKit Kat Lasagna\n3-Day Potato Salad\nPickled Watermelon Rind'];
    return Container(
      color: Colors.green[50], // change this color to change the background color

      child: ListView.builder(

        itemCount: 5, // this determines how many groceries
        itemBuilder: (context, index) {
          return Card(

            color: Colors.white, // Change this color to change the color of the card
            child: LabeledCheckbox(
              label: 'This is the label text',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            )
            /*child: CheckboxListTile(
              value: timeDilation != 1.0,
              title: const Text('Placeholder Grocery'),
              onChanged: (bool value) {
                timeDilation = value ? 2.0 : 1.0;
              },
              //secondary: const Icon(Icons.hourglass_empty),
            ) */
          );
        },
      )
    );
  }
} */
/*
  class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
  return CheckboxListTile(
  title: const Text('Animate Slowly'),

  onChanged: (bool value) {
  setState(() {

  });
  },
  secondary: const Icon(Icons.hourglass_empty),
  );
  }
  }*/

// Flutter code sample for CheckboxListTile

// ![Custom checkbox list tile sample](https://flutter.github.io/assets-for-api-docs/assets/material/checkbox_list_tile_custom.png)
//
// Here is an example of a custom LabeledCheckbox widget, but you can easily
// make your own configurable widget.
/*
import 'package:flutter/material.dart';

/// This Widget is the main application widget.
class Home extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}*/

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GroceryList extends StatefulWidget {
  GroceryList({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<GroceryList> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /*Container(
          child: Text("Groceries:"), // TODO: place a title here
        ), */
        Container(
            color: Colors.green[50], // change this color to change the background color
            child: ListView.builder(
              itemCount: 1, // this determines how many items are in the list (of groceries)
              itemBuilder: (context, index) {
              return Card(
                color: Colors.white, // Change this color to change the color of the card
                child: LabeledCheckbox(
                  label: 'Placeholder: one grocery will go here',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // this is how much padding should appear between the text, and the edge
                  value: _isSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  },
                    /*child: CheckboxListTile(
                    value: timeDilation != 1.0,
                    title: const Text('Placeholder Grocery'),
                    onChanged: (bool value) {
                      timeDilation = value ? 2.0 : 1.0;
                    },
                    //secondary: const Icon(Icons.hourglass_empty),
                  ) */
                )
              );
            },
            )
          )
      ]
    );

    //);
  }
}