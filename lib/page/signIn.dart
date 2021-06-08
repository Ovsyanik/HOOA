import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack() 
    );
  }
}