import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooa/model/TypeInstitution.dart';
import 'package:hooa/page/SignIn.dart';

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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF424242)
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: <Widget>[

          Positioned(
            top: height * 0.01,
            left: width / 25,
            child: Text(
              'Регистрация',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 26
              )
            ),
          ),

          Positioned(
            top: height * 0.09,
            left: width / 25,
            width: width - (width / 12.5),
            child: TextField(
              controller: this.institutionController,
              decoration: InputDecoration(
                hintText: "Название заведения",
                  // labelText: "Email",
                labelStyle: TextStyle(color: Color(0xFF424242))
              ),
            )
          ),

          Positioned(
            top: height * 0.175,
            left: width / 25,
            width: width,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-10, 0),
                      child: Text(
                        TypeInstitution.HairdressingSalon.value,
                        style: TextStyle(fontSize: 16)
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
                        style: TextStyle(fontSize: 16)
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
            left: width / 25,
            width: width - (width / 12.5),
            child: TextField(
              controller: this.addressController,
              decoration: InputDecoration(
                hintText: "Адрес",
                labelStyle: TextStyle(color: Color(0xFF424242)),
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
            left: width / 25,
            width: width - (width / 12.5),
            child: TextField(
              controller: this.numberPhoneController,
              decoration: InputDecoration(
                  hintText: "Номер телефона",
                  labelStyle: TextStyle(color: Color(0xFF424242))
              ),
            )
          ),
            
          Positioned(
            top: height * 0.43,
            left: width / 25,
            width: width - (width / 12.5),
            child: TextField(
              controller: this.emailController,
              decoration: InputDecoration(
                hintText: "E-mail",
                // labelText: "Email",
                labelStyle: TextStyle(color: Color(0xFF424242))
              ),
            )
          ),

          Positioned(
            top: height * 0.515,
            left: width / 25,
            width: width - (width / 12.5),
            child: TextField(
              obscureText: isHidden,
              controller: this.passwordController,
              decoration: InputDecoration(
                hintText: "Пароль",
                  // labelText: "Email",
                labelStyle: TextStyle(color: Color(0xFF424242)),
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
            left: width / 25,
            width: width - (width / 12.5),
            height: height / 18,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.orange),
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              color: Colors.orange,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent, 
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(color: Colors.white)
                ),
              onPressed: () => 
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => null)
              ),
            )
          ),

          Positioned(
            top: height * 0.7,
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
                          fontSize: 14,
                          color: Color(0xFF424242)
                        ),
                      ),
                    )
                  ),
                  
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Политики конфиденциальности',
                        style:  TextStyle(
                          fontSize: 14,
                          color: Colors.orange
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
                    fontSize: 18,
                    color: Colors.orange
                  ),
                  children: <TextSpan> [
                    TextSpan(
                      text: 'Войти',
                      style:  TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold
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
