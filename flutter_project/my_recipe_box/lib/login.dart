import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_recipe_box/main.dart';
import 'package:my_recipe_box/registration.dart';
import 'package:my_recipe_box/forgotpasswordpage.dart';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'globals.dart' as globals;

class UserResponse {
  String status;
  String token;
  Data data;

  UserResponse({this.status, this.token, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> parsedJson){
    return UserResponse(
      status: parsedJson['status'],
      token: parsedJson['token'],
      data: Data.fromJson(parsedJson['data'])
    );
  }
}

class Data{
  User user;

  Data({this.user});

  factory Data.fromJson(Map<String, dynamic> parsedJson){
    return Data(
        user: User.fromJson(parsedJson['user'])
    );
  }
}

class User{

  String photo;
  String createdAt;
  String name;
  String email;
  List<dynamic> calendars;
  String token;
  String tokenExpires;

  @JsonKey(name: '_id')
  String id;

  User({this.photo, this.createdAt, this.name, this.email, this.calendars, this.token, this.tokenExpires, this.id});



  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
        id: parsedJson['_id'],
        name: parsedJson['name'],
        email: parsedJson['email'],
        calendars: parsedJson['calendars'],
        token: parsedJson['token'],
        tokenExpires: parsedJson['tokenExpires'],
    );
  }
}

class Person{
  String name;
  String email;
  List<dynamic> calendars;

  Person(this.name, this.email, this.calendars);
}

class Login extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRecipeBox Login',
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
          fontFamily: 'OpenSans'),
      home: MyHomePage(title: 'Flutter Login'),
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
  static final createPostUrl = 'https://www.myrecipebox.club/api/users/login';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextStyle style = TextStyle(fontSize: 20.0);
  bool showProgress = false;
  //Response response;
  Data data;
  User user;

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
    final passwordField = TextField(
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

    final forgotPassword = FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          );
        },
        child: Text(
          'Forgot password? Click here.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: style.copyWith(
            decoration: TextDecoration.underline,
          ),
        )
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff4caf50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var response = await http.post(createPostUrl,
              body: {'email': emailController.text,
                'password': passwordController.text});
          print("response.body is ");
          print(response.body);
          String title;
          String message;
          if (response.statusCode == 200) {
            var userresponse = UserResponse.fromJson(json.decode(response.body));

            //print(response.body);
            //print(userresponse.data.user.id);
            globals.email = userresponse.data.user.email;
            globals.name = userresponse.data.user.name;
            globals.token = userresponse.token;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );



          }
          else if (response.statusCode == 400)  {
            title = "Incomplete entry";
            message = "Please provide email and password";
            _emailDialog(title, message);
          }
          else if (response.statusCode == 401) {
            title = "Invalid entry";
            message = "Incorrect email or password.";
            _emailDialog(title, message);
          }
          else {
            title = "Error";
            message = "Unknown error. Please try again later.";
            _emailDialog(title, message);
          }
        },
          /*Post newPost = new Post(
          email: emailController.text, password: passwordController.text);
          Post post = await createPost(createPostUrl, body: newPost.toMap());

          },*/

          // {
          //    "email": "email@domain.com",
          //    "password": "pass123"
          // }
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );
    final register = FlatButton(

      onPressed: () {
        //CircularProgressIndicator();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Registration()),
        );
      },

      child: Text(
          'Click here to register.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: style.copyWith(
            decoration: TextDecoration.underline,
          ),
        )
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
                  height: 175.0,
                  child: Image.asset(
                    "logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 55.0),
                emailField,
                SizedBox(height: 10.0),
                passwordField,
                SizedBox(
                  height: 10.0,
                ),
                forgotPassword,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 10.0,
                ),
                register,
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
