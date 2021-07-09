import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/TypeInstitution.dart';

class SignUpSecondInstitutionPage extends StatefulWidget {
  @override
  SignUpSecondInstitutionState createState() => SignUpSecondInstitutionState();
}

class SignUpSecondInstitutionState extends State<SignUpSecondInstitutionPage> {
  TextEditingController institutionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController numberPhoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: unitHeight * 50,
              child: TextField(
                controller: this.institutionController,
                decoration: InputDecoration(
                  hintText: "Название заведения",
                  labelStyle: TextStyle(
                    fontSize: unitHeight * 124,
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
                  labelStyle: TextStyle(color: HexColor("#4D262626")),
                  suffixIcon: InkWell(
                    child: Icon(Icons.location_on_outlined),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {

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
                    labelStyle: TextStyle(color: HexColor("#4D262626")),
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
                  labelStyle: TextStyle(color: HexColor("#4D262626")),
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
                    onPressed: () => setState(() => isHidden = !isHidden),
                  ),
                ),
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
                  'Зарегистрироваться',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16,
                  )
                ),
                onPressed: () => Navigator.of(context).pushNamed('/records'),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              child: Container(
                child:Column(
                  children: <Widget> [
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
                            ..onTap = () { Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => null),
                            );
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
}