import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInOrSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(0, 0),
        children: <Widget>[
          Text(
            "HOOA", 
            style: TextStyle(
              fontSize: 124,
              fontFamily: 'Bebas Neue'
            )
          ),
          Align(
            alignment: Alignment(0.5, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 2 - 17,
                    height: 50 
                  ), 
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: HexColor("#FF844B")),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25) 
                      )
                    ),
                    color: HexColor("#FF844B"),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent, 
                    onPressed: () => Navigator.pushNamed(context, '/signIn'),
                    child: Text(
                      "Вход", 
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                    )
                  ), 
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 2 - 17, 
                    height: 50
                  ), 
                  child: MaterialButton(   
                    elevation: 0,  
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: HexColor("#FF844B")),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25)
                      ),  
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,  
                    color: Colors.white,                
                    onPressed: () => Navigator.pushNamed(context, '/signUp'),
                    child: Text(
                      "Регистрация",
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor("#FF844B")
                      ),
                    )
                  ), 
                )
              ],
            )
          )
        ],
      ),
    );
  }
}