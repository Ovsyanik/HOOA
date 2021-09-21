import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/model/Sex.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/widget/CheckBox.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';
import 'package:image_picker/image_picker.dart';

class AddStaffPage extends StatefulWidget {
  @override
  AddStaffPageState createState() => AddStaffPageState();
}

class AddStaffPageState extends State<AddStaffPage> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final positionController = TextEditingController();

  final _picker = new ImagePicker();
  File _image;
  Map<Service, bool> selectedService = Map<Service, bool>();

  Sex _sex = Sex.Female;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: 'Добавление сотрудника',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                bottom: unitHeight * 20,
                top: unitHeight * 10
            ),
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
              radius: unitHeight * 45,
              backgroundColor: HexColor('#E0E0E0'),
              child: _image != null ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: unitHeight * 90,
                  height: unitHeight * 90,
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
              controller: this.positionController,
              decoration: InputDecoration(
                hintText: "Должность",
                hintStyle: TextStyle(
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
            child: Stack(
              children: [
                Expanded(
                  child: Container(
                    child: BlocBuilder(
                      bloc: BlocProvider.of<ServicesBloc>(context),
                      builder: (context, ServicesState state) => ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          List<Service> services = state.services.where((element) =>
                          element.categoryService == state.categories[index].id)
                          .toList();
                          if (selectedService.isEmpty) {
                            for(int i = 0; i < services.length; i++) {
                              selectedService.putIfAbsent(services[i], () => false);
                            }
                          }
                        return DropDown(
                          unitHeight: unitHeight,
                          title: state.categories[index].name,
                          list: List<Widget>.generate(services.length, (index) =>
                            _getItemDropdown(unitHeight, services[index], index, selectedService[selectedService.keys.elementAt(index)])
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Align(
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
                            List<int> services = [];

                            for(int i = 0; i < selectedService.length; i++) {
                              if(selectedService.values.elementAt(i) == true) {
                                services.add(selectedService.keys.elementAt(i).id);
                              }
                            }

                            final bloc = BlocProvider.of<StaffBloc>(context);
                            bloc.add(AddStaff(Staff(
                              fullName: fullNameController.text,
                              position: positionController.text,
                              sex: _sex.value,
                              numberPhone: numberPhoneController.text,
                              image: _image != null ? _image.path : null,
                              services: services
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
              ],
            ),
          ),
        ]),
      ),
    );
  }

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
      builder: (BuildContext buildContext) {
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

  Widget _getItemDropdown(double unitHeight, Service service, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() {
        for(int i = 0; i < selectedService.length; i++) {
          selectedService[selectedService.keys.elementAt(i)] = false;
        }
        print(selectedService[selectedService.keys.elementAt(index)]);

        selectedService[selectedService.keys.elementAt(index)]
          = !selectedService[selectedService.keys.elementAt(index)];
        print(selectedService[selectedService.keys.elementAt(index)]);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: unitHeight * 16),
        width: unitHeight * 1,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor('#262626').withOpacity(0.5)),

            ),
          ),
          child: Row(children: [
            Text(
              service.name,
              style: TextStyle(fontSize: unitHeight * 15),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: CheckBox(isSelected: isSelected),
              ),
            ),
          ],
          ),
      ),
    );
  }
}