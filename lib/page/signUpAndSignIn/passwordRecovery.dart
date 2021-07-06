import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final eMailController = TextEditingController();
  
  @override
  void dispose() {
    eMailController.dispose();

    super.dispose();
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
            'assets/icons/union.svg',
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
              margin: EdgeInsets.only(top: size.height * 0.04),
              width: size.width,
              child: Text(
                'Восстановление\nпароля',
                style: TextStyle(
                  color: HexColor("#262626"),
                  fontWeight: FontWeight.w600,
                  fontSize: unitHeight * 40
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.03),
              width: size.width,
              child: Text(
                'Введите свой e-mail - мы отправим вам\nссылку для восстановления пароля',
                style: TextStyle(
                  color: HexColor('#262626').withOpacity(0.6),
                  fontSize: unitHeight * 15,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.03),
              width: size.width,
              child: TextField(
                controller: this.eMailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  labelStyle: TextStyle(
                    color: HexColor("#4D262626"),
                    fontSize: unitHeight * 17,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.1),
              height: unitHeight * 50,
              width: size.width,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: HexColor("#FF844B"),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => null)
                ),
                child: Text(
                  "Войти",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 16,
                  ),
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
                      text: 'Я вспомнил пароль! Вернуться',
                      style: TextStyle(
                        fontSize: unitHeight * 15,
                        color: HexColor("#FF844B"),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/signIn'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordRecoveryPage extends StatefulWidget {
  @override
  PasswordRecoveryPageState createState() => PasswordRecoveryPageState();
}