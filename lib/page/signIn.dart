import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/page/records.dart';
import 'package:hooa/page/signUp.dart';

class SignInPageState extends State<SignInPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isHidden = true;

  @override 
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        children: <Positioned>[
          
          Positioned(
            left: 16,
            top: height * 0.13,
            child: Text(
              "Вход",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626')
              ),
            ),
          ),

          Positioned(
            top: height * 0.25,
            left: 16,
            width: width - 32,
            child: TextField(
              controller: this.emailController,
              decoration: InputDecoration(
                hintText: "E-mail",
                labelStyle: TextStyle(color: HexColor("#4D262626"))
              ),
            )
          ),

          Positioned(
            top: height * 0.35,
            left: 16,
            width: width - 32,
            child: TextField(
              obscureText: isHidden,
              controller: this.passwordController,
              decoration: InputDecoration(
                hintText: "Пароль",
                labelStyle: TextStyle(color: HexColor("#4D262626")),
                  suffixIcon: InkWell(
                    child: Icon(Icons.visibility_outlined),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => setState(() => isHidden = !isHidden)
                )
              ),
            )
          ),

          Positioned(
            top: height * 0.42,
            width: width - 32,
            child: Align(
              alignment: Alignment.topRight,
              child: RichText(
                text: TextSpan(
                  text: 'Забыли пароль?',
                  style: TextStyle(
                    fontSize: 15,
                    color: HexColor("#99262626"),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SignUpPage()
                    ) 
                  )
                )   
              )
            )
          ),

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
                builder: (context) => RecordsPage())),
              child: Text(
                "Войти",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                  ),
              )
            ),
          ),

          Positioned(
            top: height * 0.59,
            width: width,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Нажимая кнопку "Войти" вы принимаете',
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor("#7d7d7d")
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'условия ',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#7d7d7d")
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Политики конфиденциальности',
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor("#FF844B"),
                            fontWeight: FontWeight.w600
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context)
                              .push(MaterialPageRoute(
                                builder: (context) => null
                            )
                          )
                        )
                      ]
                    )   
                  )
                )
              ]
            )
          ),

          Positioned(
            top: height * 0.8,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Нет аккаунта? ',
                  style: TextStyle(
                    fontSize: 15,
                    color: HexColor("#FF844B")),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#FF844B"),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpPage()
                        )
                      )
                    )
                  ]
                )   
              )
            )
          ),
        ],
      ) 
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}