
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState () => SignUpPageState (); 

}

class SignUpPageState extends State<SignUpPage> {
  int choose;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column( 
        children: <Widget>[
          Container(
            height: height / 10,
            alignment: Alignment(-0.95, 1),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context);}
            ),
          ),

          Container(
            height: height / 4,
            alignment: Alignment(-0.8, 0.3),
            child: Text(
              "Регистрация", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ), 
          ),
          
          Container(
            width: width - 40,
            height: height / 18,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[500]),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                primary: Colors.white
              ),
              onPressed: () { choose = 1; },
              child: Text(
                "Клиент/Мастер", 
                style: TextStyle(
                  color: Colors.grey[500]
                ),
              )
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            width: width - 40,
            height: height / 18,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[500]),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              primary: Colors.white
              ),
              onPressed: () { choose = 2; },
              child: Text(
                "Заведение",
                style: TextStyle(
                  color: Colors.grey[500]
                ),
              )
            ),
          ),

          
          Container(
            margin: EdgeInsets.only(top: 60),
            height: height / 18,
            width: width - 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                primary: Colors.orange
              ),
              onPressed: () { 
                if(choose == 1) {
                  Navigator.of(context).pop(
                    MaterialPageRoute(builder: (context) => null)
                  );
                }
              },
              child: Text(
                "Продолжить", 
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 150),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Зарегистрированы?'),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('Войти')
                  )],
              )
            ),
          )
        ]
      ),    
    );
  }

  return ButtonStyle(BuildContext context) {
    
  } 
}