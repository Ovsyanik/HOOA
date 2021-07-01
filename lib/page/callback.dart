import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

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
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Обратная связь',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HexColor('#262626')
          ),
        ),
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
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/add.svg',
              color: HexColor("#262626"),
              height: 20,
              width: 20,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => null,
          ),
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
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              child: TextField(
                controller: this._nameController,
                decoration: InputDecoration(
                  hintText: "Имя Фамилия",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              child: TextField(
                controller: this._phoneController,
                decoration: InputDecoration(
                  hintText: "Номер телефона",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              child: TextField(
                controller: this._emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: sizeScreen.height * 0.02),
              child: TextField(
                controller: this._messageController,
                decoration: InputDecoration(
                  hintText: "Сообщение",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: sizeScreen.width / 2 - 24,
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  child: MaterialButton(
                    elevation: 0,
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
                        fontSize: 15,
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