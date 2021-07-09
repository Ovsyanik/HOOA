
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/widget/customRadioSignUp.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState () => SignUpPageState(); 
}

class SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double unitHeight = size.height * 0.00125;
    return Scaffold(
      backgroundColor: HexColor("#F2F2F2"),
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
              margin: EdgeInsets.only(top: size.height * 0.1),
              alignment: Alignment.centerLeft,
              child: Text(
                "Регистрация",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: unitHeight * 48
                ),
              ),
            ),

            CustomRadio(size),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.09),
              height: unitHeight * 50,
              width: size.width - 32,
              child: MaterialButton(
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor("#FF844B")),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                color: HexColor("#FF844B"),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed:  () {
                  final bloc = BlocProvider.of<SignUpBloc>(context);
                  if(bloc.selectedType == 0){
                    Navigator.pushNamed(context, '/signUpUser');
                  } else if(bloc.selectedType == 1) {
                    Navigator.pushNamed(context, '/signUpInstitution');
                  } else return null;
                },
                child: Text(
                  "Продолжить",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16,
                    ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.05),
                alignment: Alignment.bottomCenter,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Зарегистрированы? ',
                    style: TextStyle(
                      fontSize: unitHeight * 15,
                      fontWeight: FontWeight.w400,
                      color: HexColor("#FF844B")
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
                          ..onTap = () => Navigator.pushNamed(context, '/signIn'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}