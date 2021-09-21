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
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/CheckBox.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';
import 'package:image_picker/image_picker.dart';

class ChangeStaff extends StatefulWidget {
  final Staff staff;
  ChangeStaff({
    this.staff
  });
  @override
  _ChangeStaffState createState() => _ChangeStaffState();
}

class _ChangeStaffState extends State<ChangeStaff> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final positionController = TextEditingController();

  final _picker = new ImagePicker();
  Map<Service, bool> selectedService = Map<Service, bool>();
  Sex _sex = Sex.Female;

  @override
  void initState() {
    fullNameController.text = widget.staff.fullName;
    numberPhoneController.text = widget.staff.numberPhone;
    positionController.text = widget.staff.position;
    if(widget.staff.sex == Sex.Male.value)
      _sex = Sex.Male;
    else _sex = Sex.Female;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    ServicesBloc bloc = BlocProvider.of<ServicesBloc>(context);
    bloc.add(GetServices());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: 'Редактирование сотрудника',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                bottom: unitHeight * 20,
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
              child: widget.staff.image != null ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  File(widget.staff.image),
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
            margin: EdgeInsets.only(top: unitHeight * 15),
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
            margin: EdgeInsets.only(top: unitHeight * 10),
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
            margin: EdgeInsets.only(top: unitHeight * 10),
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
            margin: EdgeInsets.only(top: unitHeight * 10),
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
            child: Column(
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
                              if(widget.staff.services.isNotEmpty) {
                                for (int j = 0; j <
                                    widget.staff.services.length; j++) {
                                  if (services[i].id ==
                                      widget.staff.services[j])
                                    selectedService.putIfAbsent(
                                        services[i], () => true);
                                  else
                                    selectedService.putIfAbsent(
                                        services[i], () => false);
                                }
                              }
                              selectedService.putIfAbsent(
                                  services[i], () => false);
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
                  child: GestureDetector(
                    onTap: () => _showModalDeleteService(context, widget.staff.id, size, unitHeight),
                    child: Row(children: [
                      SizedBox(width: unitHeight * 2),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/user_minus.svg',
                          color: HexColor("#262626"),
                          height: unitHeight * 28,
                          width: unitHeight * 28,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Удалить сотрудника",
                          style: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor('#262626'),
                          ),
                        ),
                      ),

                    ],),
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
                            widget.staff.sex = _sex.value;
                            widget.staff.position = positionController.text;
                            widget.staff.numberPhone = numberPhoneController.text;
                            widget.staff.fullName = fullNameController.text;
                            widget.staff.services = services;
                            final bloc = BlocProvider.of<StaffBloc>(context);
                            bloc.add(EditStaff(widget.staff));
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
      widget.staff.image = _pickedFile.path;
    });
  }

  _imgFromGallery() async {
    final _pickedFile = await  _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      widget.staff.image = _pickedFile.path;
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

        selectedService[selectedService.keys.elementAt(index)]
        = !selectedService[selectedService.keys.elementAt(index)];
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

  Future<void> _showModalDeleteService(BuildContext context, int id, Size size, double unitHeight) {
    return showDialog(
        context: context,
        barrierDismissible: true, //// user must tap button!
        builder: (context) => Container(
            height: unitHeight * 50,
            child: AlertDialog(
              elevation: 3,
              title: Text(
                'Удалить сотрудника',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: unitHeight * 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'При этом будет удалена все данные сотрудника',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: unitHeight * 14,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: unitHeight * 50,
                            width: size.width / 3 - 10,
                            margin: EdgeInsets.symmetric(vertical: 16.0),
                            child: MaterialButton(
                              elevation: 0,
                              highlightElevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: HexColor("#FF844B")),
                              ),
                              color: Colors.white,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                BlocProvider.of<StaffBloc>(context).add(DeleteStaff(id));
                                for(int i = 0; i < 3; i++) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "Удалить",
                                style: TextStyle(
                                  color: HexColor("#FF844B"),
                                  fontSize: unitHeight * 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: unitHeight * 50,
                            width: size.width / 3 - 10,
                            margin: EdgeInsets.symmetric(vertical: 16.0),
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
                                "Отменить",
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
            )
        )
    );
  }
}