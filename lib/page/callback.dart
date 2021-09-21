import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/MyAppBar.dart';

class CallbackPage extends StatefulWidget {
  @override
  _CallbackPageState createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final unitHeight = sizeScreen.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Обратная связь',
        actions: [
          MyAction('assets/icons/add.svg', () => null,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Напиши нам',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: unitHeight * 22,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              height: unitHeight * 50,
              child: TextField(
                controller: this._nameController,
                decoration: InputDecoration(
                  hintText: "Имя Фамилия",
                  hintStyle: TextStyle(
                    fontSize: unitHeight * 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              height: unitHeight * 50,
              child: TextField(
                controller: this._phoneController,
                decoration: InputDecoration(
                  hintText: "Номер телефона",
                  hintStyle: TextStyle(
                    fontSize: unitHeight * 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              height: unitHeight * 50,
              child: TextField(
                controller: this._emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontSize: unitHeight * 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              height: unitHeight * 50,
              child: TextField(
                controller: this._messageController,
                decoration: InputDecoration(
                  hintText: "Сообщение",
                  hintStyle: TextStyle(
                    fontSize: unitHeight * 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: unitHeight * 50,
                  width: sizeScreen.width / 2 - 24,
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: HexColor("#FF844B"),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                      },
                    child: Text(
                      "Отправить",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: unitHeight * 15,
                      ),
                    ),
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