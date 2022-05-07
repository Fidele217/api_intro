import 'pages/Add.dart';
import 'pages/Liste.dart';
import 'pages/Users.dart';
import 'pages/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "UserList",
      //home: RegisterScreen(),
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: {
        "home": (context) => Home(),
        "list_user": (context) => ListUserScreen(),
        "add_user": (context) => AddUserScreen(),
        "user": (context) => UserScreen(),
      },
    );
  }
}
