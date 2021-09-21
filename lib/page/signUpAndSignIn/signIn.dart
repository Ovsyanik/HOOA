import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/widget/MyAppBar.dart';

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
    double unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(actions: []),
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
                  fontSize: unitHeight * 40,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626')
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.05,
              ),
              height: unitHeight * 50,
              width: size.width,
              child: TextField(
                controller: this.emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  hintStyle: TextStyle(
                    color: HexColor("#4D262626"),
                    fontSize: unitHeight * 17,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.035
              ),
              height: unitHeight * 50,
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
                  hintStyle: TextStyle(
                    color: HexColor("#4D262626"),
                    fontSize: unitHeight * 17,
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/eye_close.svg',
                      height: unitHeight * 20,
                      width: unitHeight * 20,
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
                      fontSize: unitHeight * 15,
                      color: HexColor("#99262626"),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(context, '/recoveryPassword')
                  )
                )
              )
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              height: unitHeight * 50,
              width: size.width,
              child: MaterialButton(
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: HexColor("#FF844B") ,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                disabledColor: HexColor("#66FF844B"),
                onPressed: this.eMail && this.password ?
                  (){
                    var bloc = BlocProvider.of<SignUpBloc>(context);
                    Navigator.of(context).pushNamed('/mainContainer');
                } : null,
                child: Text(
                  "Войти",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16,
                  ),
                ),
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
                          fontSize: unitHeight * 13,
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
                          fontSize: unitHeight * 13,
                          color: HexColor("#7d7d7d")
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Политики конфиденциальности',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
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
                    fontSize: unitHeight * 15,
                    color: HexColor("#FF844B")
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: unitHeight * 15,
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
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();


}