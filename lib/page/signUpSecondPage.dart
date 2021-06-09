import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/TypeInstitution.dart';
import 'package:hooa/page/SignIn.dart';
import 'package:hooa/page/records.dart';

class SignUpSecondPageState extends State<SignUpSecondPage> {
  TextEditingController institutionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController numberPhoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isHidden = true;
  TypeInstitution _typeInstitution = TypeInstitution.HairdressingSalon;

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
            top: height * 0.09,
            left: 16,
            width: width - 32,
            child: TextField(
              controller: this.institutionController,
              decoration: InputDecoration(
                hintText: "Название заведения",
                labelStyle: TextStyle(
                  fontSize: 124,
                  color: HexColor("#4D262626")
                )
              ),
            )
          ),

          Positioned(
            top: height * 0.175,
            left: 16,
            width: width,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-10, 0),
                      child: Text(
                        TypeInstitution.HairdressingSalon.value,
                        style: TextStyle(fontSize: 17)
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
                        style: TextStyle(fontSize: 17)
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
            )
          ),
          
          Positioned(
            top: height * 0.26,
            left: 16,
            width: width - 32,
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

                  }
                )
              ),
            )
          ),

          Positioned(
            top: height * 0.345,
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
            top: height * 0.43,
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
            top: height * 0.515,
            left: 16,
            width: width - 32,
            child: TextField(
              obscureText: isHidden,
              controller: this.passwordController,
              decoration: InputDecoration(
                hintText: "Пароль",
                labelStyle: TextStyle(color: HexColor("#4D262626")),
                suffixIcon: InkWell(
                  child: Icon(Icons.visibility_outlined),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => setState(() => isHidden = !isHidden)
                )
              ),
            )
          ),
            
          Positioned(
            top: height * 0.63,
            left: 16,
            width: width - 32,
            height: 50,
            child: MaterialButton(
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
                  fontSize: 16)
                ),
              onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RecordsPage())
              ),
            )
          ),

          Positioned(
            top: height * 0.72,
            width: width,
            child: Container(
              child:Column( 
                children: <Widget> [
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Регистрируясь вы принимаете условия',
                        style:  TextStyle(
                          fontSize: 13,
                          color: HexColor("#828282")
                        ),
                      ),
                    )
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Политики конфиденциальности',
                        style:  TextStyle(
                          fontSize: 13,
                          color: HexColor("#FF844B"),
                          fontWeight: FontWeight.w700
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () { Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => null)
                          );
                        }
                      ),
                    ),
                  )


                ]
              )
            )
          ),

          Positioned(
            top: height * 0.85,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Зарегистрированы? ',
                  style:  TextStyle(
                    fontSize: 15,
                    color: HexColor("#FF844B")
                  ),
                  children: <TextSpan> [
                    TextSpan(
                      text: 'Войти',
                      style:  TextStyle(
                        fontSize: 15,
                        color: HexColor("#FF844B"),
                        fontWeight: FontWeight.w600
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignInPage())
                        );
                      }
                    )
                  ]
                )
              )
            )
          )

        ],
      )
    );
  }
}

class SignUpSecondPage extends StatefulWidget {
  @override
  SignUpSecondPageState createState() => SignUpSecondPageState();
}
