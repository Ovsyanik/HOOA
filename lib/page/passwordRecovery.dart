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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/union.svg',
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
            top: height * 0.1,
            width: width - 32,
            child: Text(
              'Восстановление\nпароля',
              style: TextStyle(
                color: HexColor("#262626"),
                fontWeight: FontWeight.w600,
                fontSize: 40
              ),
            ),
          ),
          
          Positioned(
            left: 16,
            top: height * 0.25,
            width: width - 32,
            child: Text(
              'Введите свой e-mail - мы отправим вам\nссылку для восстановления пароля',
              style: TextStyle(
                color: HexColor('#262626').withOpacity(0.6),
                fontSize: 15
              ),  
            ),
          ),
          
          Positioned(
            left: 16,
            top: height * 0.35,
            width: width - 32,
            child: TextField(
              controller: this.eMailController,
              decoration: InputDecoration(
                hintText: "E-mail",
                labelStyle: TextStyle(
                  color: HexColor("#4D262626"),
                  fontSize: 17
                )
              ),
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
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => null)),
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
            top: height * 0.8,
            width: width,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Я вспомнил пароль! Вернуться',
                  style: TextStyle(
                    fontSize: 15,
                    color: HexColor("#FF844B")),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(context, '/signIn')
              )
            )
          )
        ],
      ),
    );
  }
}

class PasswordRecoveryPage extends StatefulWidget {
  @override
  PasswordRecoveryPageState createState() => PasswordRecoveryPageState();
}