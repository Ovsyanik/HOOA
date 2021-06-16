import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/Sex.dart';

class SignUpSecondUserPage extends StatefulWidget {
  @override
  SignUpSecondUserState createState() => SignUpSecondUserState();
}

class SignUpSecondUserState extends State<SignUpSecondUserPage> {
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController numberPhoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isHidden = true;
  Sex _sex = Sex.Female;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        children: <Widget>[
          
          Positioned(
            top: height * 0.005,
            left: 16,
            child: Text(
              'Регистрация',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: HexColor("#262626"),
                fontSize: 34
              )
            ),
          ),
          
          Positioned(
            top: height * 0.135,
            left: 16,
            width: width - 32,
            child: TextField(
              controller: this.fullNameController,
              decoration: InputDecoration(
                hintText: "Имя Фамилия",
                labelStyle: TextStyle(
                  fontSize: 17,
                  color: HexColor("#4D262626")
                )
              ),
            )
          ),

          Positioned(
            top: height * 0.22,
            left: 16,
            width: width - 32,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment( -1.8, 0),
                      child: Text(
                        Sex.Female.value,
                        style: TextStyle(fontSize: 17)
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
                        style: TextStyle(fontSize: 17)
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
            )
          ),

          Positioned(
            top: height * 0.305,
            left: 16,
            width: width - 32,
            child: TextField(
              controller: this.numberPhoneController,
              decoration: InputDecoration(
                hintText: "Номер телефона",
                labelStyle: TextStyle(color: HexColor("#4D262626"))
              ),
            )
          ),

          Positioned(
            top: height * 0.39,
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
            top: height * 0.475,
            left: 16,
            width: width - 32,
            child: TextField(
              obscureText: isHidden,
              controller: this.passwordController,
              decoration: InputDecoration(
                hintText: "Пароль",
                labelStyle: TextStyle(color: HexColor("#4D262626")),
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
            top: height * 0.6,
            left: 16,
            width: width - 32,
            height: 50,
            child: MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor("#FF844B")),
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              color: HexColor("#FF844B"),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                )
              ),
              onPressed: () => Navigator.of(context).pushNamed('/records')
            )
          ),
  
          Positioned(
            top: height * 0.69,
            width: width,
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Регистрируясь вы принимаете условия',
                    style: TextStyle(
                      fontSize: 13,
                      color: HexColor("#828282")
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: RichText(
                    
                    text: TextSpan(
                      text: 'Политики конфиденциальности',
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor("#FF844B"),
                        fontWeight: FontWeight.w700
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { 
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => null));
                      }
                    ),
                  ),
                )
              ]
            )
          ),
            
          Positioned(
            top: height * 0.85,
            width: width,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Зарегистрированы? ',
                style: TextStyle(
                  fontSize: 15,
                  color: HexColor("#FF844B")
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Войти',
                    style: TextStyle(
                      fontSize: 15,
                      color: HexColor("#FF844B"),
                      fontWeight: FontWeight.w600
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).pushNamed('/signIn')
                  )
                ]
              )
            )
          )
        ],
      )
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    numberPhoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
