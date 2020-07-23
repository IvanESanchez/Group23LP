import 'package:flutter/material.dart';
import 'package:my_recipe_box/login.dart';
import 'package:http/http.dart' as http;


class Registration extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a green toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Registration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var showProgress = false;
  static final createPostUrl = 'https://www.myrecipebox.club/api/users/signup';
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmationController = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'OpenSans', fontSize: 20.0);
  bool _validate = false;

  bool validatePasswordStructure(String value){
    if (value.length < 8 || value.isEmpty) {
      return false;
    }
    return true;
  }
  bool validateStructure(String value){
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _emailDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final registration = Text(
      'REGISTRATION',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style.copyWith(fontSize: 35, fontWeight: FontWeight.bold),
    );
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final usernameField = TextField(
      obscureText: false,
      style: style,
      controller: usernameController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      onChanged: (newValue) {
        setState(() {
          //currentIngredient.name = newValue;

          //print(newValue);
        });
      },
      obscureText: true,
      style: style,
      controller: passwordController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordConfirmationField = TextField(
      obscureText: true,
      style: style,
      controller: passwordConfirmationController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password confirmation",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff4caf50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          showProgress = true;
          if (validate()) {
            var response = await http.post(createPostUrl,
                body: {'name': usernameController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'passwordConfirm': passwordConfirmationController.text,
                });

            print("response is ");
            print(response.statusCode);
            String title;
            String message;
            if (response.statusCode == 200) {
              title = "Email sent";
              message = "Please go to your email and verify your account.";
              _emailDialog(title, message);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }
            else if (response.statusCode == 500) {
              title = "Invalid email";
              message = "This email is already associated with a user.";
              _emailDialog(title, message);
            }
            else {
              title = "Error";
              message = "Unknown error. Please try again later.";
              _emailDialog(title, message);
            }
            showProgress = false;
          }
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.w800)),
      ),

    );

    return Scaffold(
      backgroundColor: Colors.green[100],
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          width: 500,
          color: Colors.green[50],
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 0.0),
                registration,
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 10.0),
                usernameField,
                SizedBox(height: 10.0),
                passwordField,
                SizedBox(height: 10.0),
                passwordConfirmationField,
                SizedBox(
                  height: 20.0,
                ),
                registerButton,
                SizedBox(
                  height: 10.0,
                ),
                Center(
                    child: showProgress
                        ? CircularProgressIndicator()
                        : Text(' ', style: TextStyle(fontSize: 20),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  validate(){
    if(!validatePasswordStructure(passwordController.text)){
      setState(() {
        _emailDialog("Invalid password", "Password must contain at least 8 characters.");
      });
      showProgress = false;
      // show dialog/snackbar to get user attention.
      return false;
    }
    else if(!validateStructure(emailController.text)
        || !validateStructure(usernameController.text)
        || !validateStructure(passwordConfirmationController.text)){
      setState(() {
        _emailDialog("Error", "All fields required.");
      });
      showProgress = false;
      // show dialog/snackbar to get user attention.
      return false;
    }
    else if(passwordController.text.compareTo(passwordConfirmationController.text) != 0){
      setState(() {
        _emailDialog("Error", "Passwords do not match.");
      });
      showProgress = false;
      // show dialog/snackbar to get user attention.
      return false;
    }
    return true;
    // Continue
  }
}

