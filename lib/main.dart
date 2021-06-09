import 'package:flutter/material.dart';
import 'package:hooa/page/signInOrSignUp.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOOA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: HexColor("#FF844B"),
        fontFamily: 'Proxima Nova',
      ),
      home: SignInOrSignUpPage(),
    );
  }
}
