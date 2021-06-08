
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooa/page/signIn.dart';
import 'package:hooa/page/signUpSecondPage.dart';
import 'package:hooa/widget/customRadioSignUp.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState () => SignUpPageState (); 

}

class SignUpPageState extends State<SignUpPage> {
  int choose;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body: Stack( 
        children: <Widget>[

          Positioned(
            top: height * 0.12,
            left: width / 20,
            child: Text(
              "Регистрация", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ), 
          ),

          CustomRadio(width, height),

          Positioned(
            top: height * 0.5,
            left: width / 20,
            height: height / 18,
            width: width - 40,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.orange),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              color: Colors.orange,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpSecondPage()));
              },
              child: Text(
                "Продолжить",
                style: TextStyle(color: Colors.white),
              )
            ),
          ),

          Positioned(
            top: height * 0.85,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Зарегистрированы? ',
                  style: TextStyle(fontSize: 18, color: Colors.orange),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Войти',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInPage()
                        )
                      )
                    )
                  ]
                )   
              )
            )
          )

        ]
      )
    );
  }
}