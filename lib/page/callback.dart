import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/Button.dart';
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
        child: Column(children: <Widget>[
          Container(
            child: Text(
              'Напиши нам',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: unitHeight * 22,
              ),
            ),
          ),

          _getTextField(_nameController, 'Имя Фамилия', unitHeight),

          _getTextField(_phoneController, 'Номер телефона', unitHeight),

          _getTextField(_emailController, 'Email', unitHeight),

          _getTextField(_messageController, 'Сообщение', unitHeight),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: 'Отправить',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],),
      ),
    );
  }

  Widget _getTextField(
      TextEditingController controller,
      String text,
      double unitHeight) {
    return Container(
      margin: EdgeInsets.only(top: unitHeight * 16),
      height: unitHeight * 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            fontSize: unitHeight * 17,
            color: HexColor("#262626").withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}