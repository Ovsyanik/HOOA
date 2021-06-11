import 'package:flutter/material.dart';
import 'package:hooa/page/signInOrSignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOOA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima Nova',
      ),
      home: SignInOrSignUpPage(),
    );
  }
}
