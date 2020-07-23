import 'package:flutter/material.dart';
import 'package:my_recipe_box/login.dart';
import 'package:http/http.dart' as http;
import 'package:my_recipe_box/resetpassword.dart';
import 'dart:convert';

//void main() => runApp(Register());

class ForgotPasswordPage extends StatelessWidget {
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
      home: MyHomePage(title: 'Forgot Password Page'),
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
  static final createUrl = 'https://www.myrecipebox.club/api/users/forgotPassword';
  TextEditingController emailController = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'OpenSans', fontSize: 20.0);

  Map<String,String> headers = {'Content-Type':'application/json'};

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
      'Please enter email\nto reset password.',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
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
    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff4caf50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          final emailMessage = jsonEncode({'email': emailController.text});
          print(emailMessage.toString());
          var response = await http.post(createUrl,
              headers: headers,
              body: emailMessage,
          );

          print(response.body);
          print(response.statusCode);
          String title;
          String message;
          if (response.statusCode == 200) {
            title = "Email sent";
            message = "Please go to your email and click the link to reset your password.";
          }
          else if (response.statusCode == 404) {
            title = "Invalid email";
            message = "This email is not associated with an account.";
          }
          else {
            title = "Error";
            message = "Unknown error. Please try again later.";
          }
          _emailDialog(title, message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text("Send Email",
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
                SizedBox(height: 5.0),
                registration,
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 10.0),
                submitButton,
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


