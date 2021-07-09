import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/model/Sex.dart';
import 'package:hooa/model/staff.dart';
import 'package:image_picker/image_picker.dart';

class AddStaffPage extends StatefulWidget {
  @override
  AddStaffPageState createState() => AddStaffPageState();
}

class AddStaffPageState extends State<AddStaffPage> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final positionController = TextEditingController();
  File _image;

  Sex _sex = Sex.Female;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: unitHeight * 60,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Добавление сотрудника',
          style: TextStyle(
            fontSize: unitHeight * 17,
            fontWeight: FontWeight.w700,
            color: HexColor('#262626')
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            color: HexColor("#262626"),
            height: unitHeight * 20,
            width: unitHeight * 20,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 20, top: 10),
            child: Text(
              'ИЗМЕНЕНИЕ ЛИЧНОЙ ИНФОРМАЦИИ',
              style: TextStyle(
                fontSize: unitHeight * 14,
                color: HexColor('#BDBDBD'),
              ),
            ),
          ),

          GestureDetector(
            onTap: () => _showPicker(context),
            child: CircleAvatar(
              radius: unitHeight * 50,
              backgroundColor: HexColor('#E0E0E0'),
              child: _image != null ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: unitHeight * 100,
                  height: unitHeight * 100,
                  fit: BoxFit.fill,
                ),
              ) : Container(
                width: unitHeight * 40,
                height: unitHeight * 40,
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  color: Colors.white,
                  height: unitHeight * 28,
                  width: unitHeight * 28,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            height: unitHeight * 50,
            child: TextField(
              controller: this.fullNameController,
              decoration: InputDecoration(
                hintText: "Имя Фамилия",
                labelStyle: TextStyle(
                  fontSize: unitHeight * 17,
                  color: HexColor("#262626").withOpacity(0.3),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            height: unitHeight * 50,
            child: Row(children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Align(
                    alignment: Alignment( -1.8, 0),
                    child: Text(
                      Sex.Female.value,
                      style: TextStyle(fontSize: unitHeight * 17),
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
                      style: TextStyle(fontSize: unitHeight * 17),
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
            ]),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            height: unitHeight * 50,
            child: TextField(
              controller: this.numberPhoneController,
              decoration: InputDecoration(
                hintText: "+375 (00) 000 00 00",
                labelStyle: TextStyle(
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
              controller: this.positionController,
              decoration: InputDecoration(
                hintText: "Должность",
                labelStyle: TextStyle(
                  fontSize: unitHeight * 17,
                  color: HexColor("#262626").withOpacity(0.3),
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: size.height * 0.04),

            child: Text(
              'ИЗМЕНЕНИЕ УСЛУГ',
              style: TextStyle(
                fontSize: unitHeight * 14,
                color: HexColor('#BDBDBD'),
              ),
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: unitHeight * 50,
                    width: size.width / 2 - 24,
                    margin: EdgeInsets.only(bottom: 16, top: 16),
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
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
                          fontSize:unitHeight * 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: unitHeight * 50,
                    width: size.width / 2 - 24,
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
                          fontSize: unitHeight * 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  final _picker = new ImagePicker();

  _imgFromCamera() async {
    final _pickedFile = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(_pickedFile.path);
    });
  }

  _imgFromGallery() async {
    final _pickedFile = await  _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(_pickedFile.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                  },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                  },
              ),
            ]),
          ),
        );
        },
    );
}
}