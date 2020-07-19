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
  static final createPostUrl = 'https://www.myrecipebox.club/api/users/signup';
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmationController = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'OpenSans', fontSize: 20.0);

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
          hintText: "Create username",
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

          var response = await http.post(createPostUrl,
              body: {'name': usernameController.text,
                'email': emailController.text,
                'password': passwordController.text,
                'passwordConfirm': passwordConfirmationController.text,
          });
          print("response is ");
          print(response.statusCode);
          if (response.statusCode == 200) { // TODO: add loading icon while waiting
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
