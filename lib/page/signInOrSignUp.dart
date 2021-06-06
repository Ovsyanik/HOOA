import 'package:flutter/material.dart';
import 'package:hooa/page/SignIn.dart';
import 'package:hooa/page/signUp.dart';

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
              fontSize: 70,
              fontWeight: FontWeight.bold
            )
          ),
          Align(
            alignment: Alignment(0.5, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 40 
                  ), 
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20) 
                      )
                    ),
                    primary: Colors.orange
                  ), 
                  onPressed: () { 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage())
                      );
                    },
                  child: Text(
                    "Вход", 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                  ), 
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 2 - 20, 
                    height: 40
                  ), 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(      
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        ),
                        
                      ),
                      primary: Colors.white
                    ),                
                    onPressed: () { 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage())
                      );
                    },
                    child: Text(
                      "Регистрация",
                      style: TextStyle(
                        color: Colors.orange
                      ),)
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