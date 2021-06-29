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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
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
                labelStyle: TextStyle(color: HexColor("#4D262626"), fontSize: 17)
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
              cursorColor: HexColor("#FF844B"),
              decoration: InputDecoration(
                hintText: "Пароль",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor("#FF844B"),
                  )
                ),
                labelStyle: TextStyle(color: HexColor("#4D262626"), fontSize: 17),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/eye_close.svg', 
                    height: 20,
                    width: 20,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,   
                  onPressed: () => setState(() => isHidden = !isHidden)
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
                    ..onTap = () => Navigator.pushNamed(context, '/recoveryPassword')
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

          Positioned(
            top: height * 0.8,
            width: width,
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
      ) 
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();


}