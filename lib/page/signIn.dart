import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/repository/sqfliteRepository.dart';

class SignInPageState extends State<SignInPage> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  bool isHidden = true;
  bool eMail = false;
  bool password = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() { eMail = emailController.value.text.isNotEmpty;});
    passwordController.addListener(() { password = passwordController.value.text.isNotEmpty; });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeightValue = size.height * 0.0017;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            height: size.height * 0.025,
            width: size.height * 0.025,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            Container(
              width: size.width,
              margin: EdgeInsets.only(
                  top: size.height * 0.1
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "Вход",
                style: TextStyle(
                  fontSize: unitHeightValue * 40,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626')
                ),
              ),
            ),

            Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.05
                ),
                height: size.height * 0.05,
                width: size.width,
                child: TextField(
                  controller: this.emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    labelStyle: TextStyle(
                        color: HexColor("#4D262626"),
                        fontSize: unitHeightValue * 0.15
                    )
                  ),
                )
            ),

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.035
              ) ,
              height: size.height * 0.05,
              width: size.width,
              child: TextField(
                obscureText: isHidden,
                controller: this.passwordController,
                cursorColor: HexColor("#FF844B"),
                decoration: InputDecoration(
                  hintText: "Пароль",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor("#FF844B"),
                    )
                  ),
                  labelStyle: TextStyle(
                      color: HexColor("#4D262626"),
                      fontSize: unitHeightValue * 0.15
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/eye_close.svg',
                      height: size.height * 0.025,
                      width: size.height * 0.025,
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => setState(() => isHidden = !isHidden)
                  )
                ),
              )
            ),

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.025
              ),
              width: size.width,
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
                      ..onTap = () => Navigator.pushNamed(context, '/recoveryPassword')
                  )
                )
              )
            ),

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05
              ),
              height: size.height * 0.067,
              width: size.width,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: HexColor("#FF844B") ,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                disabledColor: HexColor("#66FF844B"),
                onPressed: this.eMail && this.password ?
                  (){
                  var bloc = BlocProvider.of<SignUpBloc>(context);
                  // var sql = SqfliteRepository();
                  // var result = sql.signIn(
                    // email: emailController.text,
                    // password: passwordController.text
                  // );
                  // result.then((value) => null)
                    Navigator.of(context).pushNamed('/mainContainer');
                  // } else print('Error');
                } : null,
                child: Text(
                  "Войти",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                    ),
                )
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.03
              ),
              width: size.width,
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
                          fontSize: 13,
                          color: HexColor("#7d7d7d")
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Политики конфиденциальности',
                            style: TextStyle(
                              fontSize: 13,
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

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.15
              ),
              width: size.width,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Нет аккаунта? ',
                  style: TextStyle(
                    fontSize: 15,
                    color: HexColor("#FF844B")
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#FF844B"),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/signUp')
                    )
                  ]
                )
              )
            )
          ],
        ),
      ) 
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();


}