import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/model/Sex.dart';
import 'package:hooa/model/staff.dart';

class AddStaffPage extends StatefulWidget {
  @override
  AddStaffPageState createState() => AddStaffPageState();
}

class AddStaffPageState extends State<AddStaffPage> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final positionController = TextEditingController();

  Sex _sex = Sex.Female;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Добавление сотрудника',
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
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                'ИЗМЕНЕНИЕ ЛИЧНОЙ ИНФОРМАЦИИ',
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor('#BDBDBD')
                ),
              )
            ),

            GestureDetector(
              onTap: () => null,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: HexColor('#E0E0E0'),
                    ),
                    Positioned(
                      left: 26,
                      top: 26,
                      child: SizedBox(
                        height: 28,
                        width: 28,
                        child: SvgPicture.asset(
                          'assets/icons/add.svg',
                          color: Colors.white,
                          height: 28,
                          width: 28,
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.015),
              child: TextField(
                controller: this.fullNameController,
                decoration: InputDecoration(
                  hintText: "Имя Фамилия",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3)
                  )
                ),
              )
            ),

            Container(
                margin: EdgeInsets.only(top: size.height * 0.015),
                width: size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: Align(
                          alignment: Alignment( -1.8, 0),
                          child: Text(
                              Sex.Female.value,
                              style: TextStyle(fontSize: 17)
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Radio(
                          value: Sex.Female,
                          activeColor: HexColor('#262626'),
                          groupValue: _sex,
                          onChanged: ((Sex value) =>
                              setState(() => _sex = value)
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Align(
                          alignment: Alignment(-1.8, 0),
                          child: Text(
                              Sex.Male.value,
                              style: TextStyle(fontSize: 17)
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Radio(
                          value: Sex.Male,
                          groupValue: _sex,
                          activeColor: HexColor('#262626'),
                          onChanged: ((Sex value) =>
                              setState(() => _sex = value)
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.015),
              child: TextField(
                controller: this.numberPhoneController,
                decoration: InputDecoration(
                  hintText: "+375 (00) 000 00 00",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3)
                  )
                ),
              )
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.015),
              child: TextField(
                controller: this.positionController,
                decoration: InputDecoration(
                  hintText: "Должность",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3)
                  )
                ),
              )
            ),

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: size.height * 0.04),
                child: Text(
                  'ИЗМЕНЕНИЕ УСЛУГ',
                  style: TextStyle(
                      fontSize: 14,
                      color: HexColor('#BDBDBD')
                  ),
                )
            ),

            Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: size.width / 2 - 32,
                        margin: EdgeInsets.only(bottom: 16, top: 16),
                        child: MaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              side: BorderSide(color: HexColor("#FF844B")),
                            ),
                            color: HexColor("#F8F7F4"),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Сбросить",
                              style: TextStyle(
                                  color: HexColor("#FF844B"),
                                  fontSize: 15
                              ),
                            )
                        ),
                      ),
                      Container(
                        height: 50,
                        width: size.width / 2 - 32,
                        margin: EdgeInsets.only(bottom: 16, top: 16),
                        child: MaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                            ),
                            color: HexColor("#FF844B"),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              final bloc = BlocProvider.of<StaffBloc>(context);
                              bloc.add(AddStaff(Staff(
                                  fullName: fullNameController.text,
                                  position: positionController.text,
                                  sex: _sex.value,
                                  numberPhone: numberPhoneController.text,
                                  image: null
                              )));
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Применить",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                            )
                        ),
                      ),
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}