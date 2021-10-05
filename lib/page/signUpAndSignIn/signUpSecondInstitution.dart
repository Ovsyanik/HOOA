import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/model/TypeInstitution.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/page/mainContainer.dart';
import 'package:hooa/page/signUpAndSignIn/MapPage.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sms/sms.dart';

class SignUpSecondInstitutionPage extends StatefulWidget {
  @override
  SignUpSecondInstitutionState createState() => SignUpSecondInstitutionState();
}

class SignUpSecondInstitutionState extends State<SignUpSecondInstitutionPage> {
  final institutionController = TextEditingController();
  final addressController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  String code;

  bool isHidden = true;
  TypeInstitution _typeInstitution = TypeInstitution.HairdressingSalon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(actions: []),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
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
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: TextField(
                controller: this.institutionController,
                decoration: InputDecoration(
                  hintText: "Название заведения",
                  hintStyle: TextStyle(
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
                        alignment: Alignment(-10, 0),
                        child: Text(
                          TypeInstitution.HairdressingSalon.value,
                          style: TextStyle(fontSize: unitHeight * 17),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio(
                        value: TypeInstitution.HairdressingSalon,
                        groupValue: _typeInstitution,
                        onChanged: ((TypeInstitution value) =>
                          setState(() => _typeInstitution = value)
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListTile(
                      title: Align(
                        alignment: Alignment(-2, 0),
                        child: Text(
                          TypeInstitution.Barbershop.value,
                          style: TextStyle(fontSize: unitHeight * 17)
                        ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio(
                        value: TypeInstitution.Barbershop,
                        groupValue: _typeInstitution,
                        onChanged: ((TypeInstitution value) =>
                          setState(() => _typeInstitution = value)
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
                controller: this.addressController,
                decoration: InputDecoration(
                  hintText: "Адрес",
                  hintStyle: TextStyle(color: HexColor("#4D262626")),
                  suffixIcon: InkWell(
                    child: Icon(Icons.location_on_outlined),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      addressController.text = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
                    },
                  ),
                ),
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
                    hintStyle: TextStyle(color: HexColor("#4D262626")),
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
                  hintStyle: TextStyle(
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
              child: TextField(
                obscureText: isHidden,
                controller: this.passwordController,
                decoration: InputDecoration(
                  hintText: "Пароль",
                  hintStyle: TextStyle(
                    color: HexColor("#4D262626"),
                    fontSize: unitHeight * 17.0,
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/eye_close.svg',
                      height: unitHeight * 20,
                      width: unitHeight * 20,
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => setState(() => isHidden = !isHidden),
                  ),
                ),
              ),
            ),

            Button(
              margin: size.height * 0.05,
              text: 'Зарегистрироваться',
              width: size.width,
              textSize: 16.0,
              onPressed: () {
                code = _generateCode();
                _showModalVerify(context, code);
              }
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              child: Container(
                child: Column(children: <Widget> [
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Регистрируясь вы принимаете условия',
                        style:  TextStyle(
                          fontSize: unitHeight * 13,
                          color: HexColor("#828282"),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Политики конфиденциальности',
                        style:  TextStyle(
                          fontSize: unitHeight * 13,
                          color: HexColor("#FF844B"),
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          },
                      ),
                    ),
                  ),


                  ],
                ),
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
                    style:  TextStyle(
                      fontSize: unitHeight * 15,
                      color: HexColor("#FF844B"),
                    ),
                    children: <TextSpan> [
                      TextSpan(
                        text: 'Войти',
                        style:  TextStyle(
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
    institutionController.dispose();
    addressController.dispose();
    numberPhoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  String _generateCode() {
    Random random = Random();
    return random.nextInt(9999).toString();
  }


  Future _sendSMS(String message, String recipents) async {
    SmsSender sender = SmsSender();
    sender.sendSms(SmsMessage(recipents, message));
  }


  void _showModalVerify(BuildContext context, String code) {
    Size size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    _sendSMS(code, numberPhoneController.text);
    showModalBottomSheet(
      context: context,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                bottom: unitHeight * 11,
                top: unitHeight * 34,
              ),
              child: Text(
                'Верификация',
                style: TextStyle(
                  fontSize: unitHeight * 34,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 30),
              child: Text(
                'Введите четырехзначный код отправленный на ваш номер телефона',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: unitHeight * 17,
                  fontWeight: FontWeight.w400,
                  color: HexColor('#262626').withOpacity(0.6),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: PinCodeTextField(
                maxLength: 4,
                onTextChanged: (value) {
                  print(value);
                },
                pinTextStyle: TextStyle(
                  fontSize: unitHeight * 17,
                ),
                controller: codeController,
                pinBoxHeight: 56,
                pinBoxWidth: 49,
                pinBoxDecoration: (Color borderColor, Color pinBoxColor, {
                  double borderWidth = 0.5,
                  double radius = 15.0,
                }) => BoxDecoration(
                  border: Border.all(
                    color: HexColor('#262626'),
                    width: 0.5,
                  ),
                  color: pinBoxColor,
                  borderRadius: BorderRadius.circular(6.0),
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              width: size.width,
              height: unitHeight * 50,
              child: MaterialButton(
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor("#FF844B")),
                  borderRadius: BorderRadius.circular(40),
                ),
                color: HexColor("#FF844B"),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Text(
                  'Отправить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16,
                  ),
                ),
                onPressed: () {
                  //if(code == codeController.text) {
                    Institution institution = Institution(
                      name: institutionController.text,
                      type: _typeInstitution.value,
                      email: emailController.text,
                      numberPhone: numberPhoneController.text,
                      address: addressController.text,
                      password: passwordController.text,
                    );
                    BlocProvider.of<SignUpBloc>(context)
                        .register(institution: institution);
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => MainContainerPage(),
                    ));
                    //}
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}