import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/model/Sex.dart';
import 'package:hooa/model/user.dart';

class SignUpSecondUserPage extends StatefulWidget {
  @override
  SignUpSecondUserState createState() => SignUpSecondUserState();
}

class SignUpSecondUserState extends State<SignUpSecondUserPage> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;
  Sex _sex = Sex.Female;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: unitHeight * 60,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            color: HexColor("#262626"),
            height: unitHeight * 20,
            width: unitHeight * 20,
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
              alignment: Alignment.centerLeft,
              child: Text(
                'Регистрация',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: HexColor("#262626"),
                  fontSize: unitHeight * 34,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              height: unitHeight * 50,
              child: TextField(
                controller: this.fullNameController,
                decoration: InputDecoration(
                  hintText: "Имя Фамилия",
                  labelStyle: TextStyle(
                    fontSize: unitHeight * 17,
                    color: HexColor("#4D262626"),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Align(
                        alignment: Alignment( -1.8, 0),
                        child: Text(
                          Sex.Female.value,
                          style: TextStyle(fontSize: unitHeight * 17)
                        ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio(
                        value: Sex.Female,
                        groupValue: _sex,
                        onChanged: ((Sex value) =>
                          setState(() => _sex = value)
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Align(
                        alignment: Alignment(-1.8, 0),
                        child: Text(
                          Sex.Male.value,
                          style: TextStyle(fontSize: unitHeight * 17)
                        ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio(
                        value: Sex.Male,
                        groupValue: _sex,
                        onChanged: ((Sex value) =>
                          setState(() => _sex = value)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: TextField(
                controller: this.numberPhoneController,
                decoration: InputDecoration(
                  hintText: "Номер телефона",
                  labelStyle: TextStyle(color: HexColor("#4D262626"))
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: TextField(
                controller: this.emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  labelStyle: TextStyle(color: HexColor("#4D262626"))
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: TextField(
                obscureText: isHidden,
                controller: this.passwordController,
                decoration: InputDecoration(
                  hintText: "Пароль",
                  labelStyle: TextStyle(color: HexColor("#4D262626")),
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
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              width: size.width,
              height: unitHeight * 50,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor("#FF844B")),
                  borderRadius: BorderRadius.circular(40),
                ),
                color: HexColor("#FF844B"),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16
                  )
                ),
                onPressed: () {
                  var bloc = BlocProvider.of<SignUpBloc>(context);
                  User newUser = User(
                    fullName: fullNameController.text,
                    sex: _sex.value,
                    numberPhone: numberPhoneController.text,
                    email: emailController.text,
                    password: passwordController.text
                  );
                  bloc.register(user: newUser);
                  Navigator.of(context).pushNamed('/mainContainer');
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Регистрируясь вы принимаете условия',
                      style: TextStyle(
                        fontSize: unitHeight * 13,
                        color: HexColor("#828282"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: unitHeight * 5),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Политики конфиденциальности',
                        style: TextStyle(
                          fontSize: unitHeight * 13,
                          color: HexColor("#FF844B"),
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => null));
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.03),
                alignment: Alignment.bottomCenter,
                width: size.width,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Зарегистрированы? ',
                    style: TextStyle(
                      fontSize: unitHeight * 15,
                      color: HexColor("#FF844B"),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Войти',
                        style: TextStyle(
                          fontSize: unitHeight * 15,
                          color: HexColor("#FF844B"),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushNamed('/signIn'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    numberPhoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
