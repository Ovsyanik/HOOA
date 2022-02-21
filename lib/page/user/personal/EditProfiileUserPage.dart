import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/UserBloc.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/model/Sex.dart';
import 'package:hooa/model/user.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';

class EditProfileUserPage extends StatefulWidget {
  final User user;

  EditProfileUserPage({this.user});

  @override
  EditProfileUserPageState createState() => EditProfileUserPageState();
}

class EditProfileUserPageState extends State<EditProfileUserPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  Sex _sex = Sex.Female;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.user.fullName;
    phoneController.text = widget.user.numberPhone;
    emailController.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Редактирование данных',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16),
        child: Stack(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        bottom: unitHeight * 20,
                        top: unitHeight * 10,
                      ),
                      child: Text(
                        'ИЗМЕНЕНИЕ ЛИЧНОЙ ИНФОРМАЦИИ',
                        style: TextStyle(
                          fontSize: unitHeight * 14,
                          color: HexColor('#BDBDBD'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.nameController,
                        decoration: InputDecoration(
                          hintText: "Иванов иван",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      width: size.width,
                      height: unitHeight * 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              title: Align(
                                alignment: Alignment(-1.8, 0),
                                child: Text(
                                  Sex.Female.value,
                                  style: TextStyle(
                                    fontSize: unitHeight * 17,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              leading: Radio(
                                value: Sex.Female,
                                groupValue: _sex,
                                onChanged: ((Sex value) =>
                                    setState(() => _sex = value)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Align(
                                alignment: Alignment(-1.8, 0),
                                child: Text(
                                  Sex.Male.value,
                                  style: TextStyle(fontSize: unitHeight * 17),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              leading: Radio(
                                value: Sex.Male,
                                groupValue: _sex,
                                onChanged: ((Sex value) =>
                                    setState(() => _sex = value)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.phoneController,
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
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.emailController,
                        decoration: InputDecoration(
                          hintText: "Электронная почта",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        top: unitHeight * 20,
                      ),
                      child: Text(
                        'ИЗМЕНЕНИЕ ПАРОЛЯ',
                        style: TextStyle(
                          fontSize: unitHeight * 14,
                          color: HexColor('#BDBDBD'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.oldPasswordController,
                        decoration: InputDecoration(
                          hintText: "Старый пароль",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.newPasswordController,
                        decoration: InputDecoration(
                          hintText: "Новый пароль",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.confirmedPasswordController,
                        decoration: InputDecoration(
                          hintText: "Подтверждение пароля",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: 'Сбросить',
                    textColor: HexColor('#FF844B'),
                    color: HexColor('#F8F7F4'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Button(
                    onPressed: () {
                      //Допилить пароль
                      var bloc = BlocProvider.of<UserBloc>(context);
                      String password;
                      if (newPasswordController.text ==
                          confirmedPasswordController.text) {
                        password = newPasswordController.text == ""
                            ? widget.user.password
                            : newPasswordController.text;
                      }
                      User user = User(
                        id: widget.user.id,
                        fullName: nameController.text,
                        email: emailController.text,
                        sex: _sex.value,
                        numberPhone: phoneController.text,
                        password: password,
                      );
                      bloc.add(EditUser(user));
                      BlocProvider.of<SignUpBloc>(context).user = user;
                      Navigator.pop(context);
                    },
                    text: 'Применить',
                    color: HexColor("#FF844B"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
