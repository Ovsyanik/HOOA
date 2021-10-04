import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInOrSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment(0, 0),
        children: <Widget>[
          Text(
            "HOOA",
            style: TextStyle(
                fontSize: unitHeight * 124,
                fontFamily: 'Bebas Neue'
            ),
          ),
          Align(
            alignment: Alignment(0.5, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: size.width / 2 - 17,
                    height: unitHeight * 50,
                  ),
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: HexColor("#FF844B")),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    color: HexColor("#FF844B"),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => Navigator.pushNamed(context, '/signIn'),
                    child: Text(
                      "Вход",
                      style: TextStyle(
                        fontSize: unitHeight * 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 2 - 17,
                    height: unitHeight * 50,
                  ),
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: HexColor("#FF844B")),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                      ),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: HexColor('#F2F2F2'),
                    onPressed: () => Navigator.pushNamed(context, '/signUp'),
                    child: Text(
                      "Регистрация",
                      style: TextStyle(
                        fontSize: unitHeight * 16,
                        color: HexColor("#FF844B"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}