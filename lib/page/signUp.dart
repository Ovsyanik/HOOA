
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/page/signIn.dart';
import 'package:hooa/page/signUpSecondPage.dart';
import 'package:hooa/widget/customRadioSignUp.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState () => SignUpPageState(); 
}

class SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#F2F2F2"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            color: HexColor("#262626"),
            height: 20,
            width: 20,
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
            left: 16,
            child: Text(
              "Регистрация", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48
              ),
            ), 
          ),

          CustomRadio(width, height),

          Positioned(
            top: height * 0.5,
            left: 16,
            height: 50,
            width: width - 32,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor("#FF844B")),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              color: HexColor("#FF844B"),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUpSecondPage())),
              child: Text(
                "Продолжить",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                  ),
              )
            ),
          ),

          Positioned(
            top: height * 0.8,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Зарегистрированы? ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#FF844B")),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Войти',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#FF844B"),
                        fontWeight: FontWeight.w600
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(context, MaterialPageRoute(
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