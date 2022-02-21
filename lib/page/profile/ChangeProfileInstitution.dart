import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/Regex.dart';
import 'package:hooa/bloc/InstitutionBloc.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/formatters/TimeInputFormatter.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileInstitution extends StatefulWidget {
  final Institution institution;

  ChangeProfileInstitution({this.institution});

  @override
  _ChangeProfileInstitution createState() => _ChangeProfileInstitution();
}

class _ChangeProfileInstitution extends State<ChangeProfileInstitution> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final timeStartController = TextEditingController();
  final timeEndController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();
  final socialController = TextEditingController();
  PageController _pageController;
  File _image;
  final _duration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;
  InstitutionBloc _institutionBloc;
  SignUpBloc _signUpBloc;
  Size size;
  double unitHeight;
  int _selectedIndex;
  bool _phoneValidate = true, _emailValidate = true, _dateStar;

  @override
  void initState() {
    super.initState();

    _institutionBloc = BlocProvider.of<InstitutionBloc>(context);
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    _pageController = PageController(
        initialPage: _signUpBloc.institution.type == "Парикмахерская" ? 0 : 1);

    nameController.text = widget.institution.name;
    addressController.text = widget.institution.address;
    phoneController.text = widget.institution.numberPhone;
    emailController.text = widget.institution.email;
    timeStartController.text = widget.institution.timeStart != null
        ? widget.institution.timeStart
        : null;
    timeEndController.text =
        widget.institution.timeEnd != null ? widget.institution.timeEnd : null;
    socialController.text = widget.institution.instagram;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Редактирование заведения',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                    GestureDetector(
                      onTap: () => _showPicker(),
                      child: CircleAvatar(
                        radius: unitHeight * 45,
                        backgroundColor: HexColor('#E0E0E0'),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image,
                                  width: unitHeight * 90,
                                  height: unitHeight * 90,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
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
                        controller: this.nameController,
                        decoration: InputDecoration(
                          hintText: "Название",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      height: unitHeight * 50,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Тип заведения',
                            style: TextStyle(
                              fontSize: unitHeight * 17.0,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          _getTypeInstitution(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      width: size.width,
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.addressController,
                        decoration: InputDecoration(
                          hintText: "Адрес",
                          hintStyle: TextStyle(color: HexColor("#4D262626")),
                          suffixIcon: InkWell(
                            child: Icon(Icons.location_on_outlined),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async =>
                                addressController.text = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => null),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 40,
                      child: TextField(
                        controller: this.phoneController,
                        onChanged: (value) => setState(
                            () => _phoneValidate = Regex.phone.hasMatch(value)),
                        decoration: InputDecoration(
                          hintText: "Номер телефона",
                          errorText: !_phoneValidate
                              ? "Номер телефона должен быть в формате +375 (00) 000-00-00"
                              : null,
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
                        onChanged: (value) => setState(
                            () => _emailValidate = Regex.email.hasMatch(value)),
                        decoration: InputDecoration(
                          hintText: "Электронная почта",
                          errorText: !_emailValidate
                              ? "Электронная почта должна быть в формате ivanov@ivan.ru"
                              : null,
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      height: unitHeight * 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Время открытия',
                              style: TextStyle(
                                fontSize: unitHeight * 17.0,
                                color: HexColor('#262626'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: this.timeStartController,
                              inputFormatters: [TimeInputFormatter()],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'ЧЧ:ММ',
                                hintStyle: TextStyle(
                                  fontSize: unitHeight * 16,
                                  color: HexColor("#262626"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      height: unitHeight * 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Время закрытия',
                              style: TextStyle(
                                fontSize: unitHeight * 17.0,
                                color: HexColor('#262626'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: this.timeEndController,
                              inputFormatters: [TimeInputFormatter()],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'ЧЧ:ММ',
                                hintStyle: TextStyle(
                                  fontSize: unitHeight * 16,
                                  color: HexColor("#262626"),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        top: unitHeight * 30,
                        bottom: unitHeight * 5,
                      ),
                      child: Text(
                        'СОЦИАЛЬНЫЕ СЕТИ',
                        style: TextStyle(
                          fontSize: unitHeight * 14,
                          color: HexColor('#BDBDBD'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: unitHeight * 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: unitHeight * 8),
                          leading: SvgPicture.asset(
                            'assets/icons/InstagramLogo.svg',
                            color: HexColor("#262626"),
                            height: unitHeight * 30,
                            width: unitHeight * 30,
                          ),
                          title: TextField(
                            controller: this.socialController,
                            decoration: InputDecoration(
                              hintText: "@instagram",
                              hintStyle: TextStyle(
                                fontSize: unitHeight * 17,
                                color: HexColor("#262626").withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: unitHeight * 8,
                        bottom: unitHeight * 70,
                      ),
                      child: GestureDetector(
                        onTap: () => _showConfirmationPicker(),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: unitHeight * 12),
                          leading: SvgPicture.asset(
                            'assets/icons/remove_account.svg',
                            color: HexColor("#262626"),
                            height: unitHeight * 25,
                            width: unitHeight * 25,
                          ),
                          title: Text(
                            "Удалить аккаунт",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: unitHeight * 17,
                              color: HexColor('#262626'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _getButtons(),
          ],
        ),
      ),
    );
  }

  _pickImage(ImageSource source) async {
    final _pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() => _image = File(_pickedFile.path));
  }

  void _showPicker() {
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
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  Future _showConfirmationPicker() {
    return showDialog(
      context: context,
      barrierDismissible: true, //// user must tap button!
      builder: (context) => Container(
        height: unitHeight * 50,
        child: AlertDialog(
          elevation: 3,
          title: Text(
            'Удалить заведение',
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
                  'При этом будут удалены все данные заведения',
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
                        margin: EdgeInsets.symmetric(vertical: 8.0),
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
                            _institutionBloc
                                .add(DeleteInstitution(widget.institution.id));
                            _signUpBloc.institution = null;
                            while (Navigator.canPop(context)) {
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
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: HexColor("#FF844B"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () => Navigator.pop(context),
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
        ),
      ),
    );
  }

  Widget _getTypeInstitution() {
    return Expanded(
      child: Container(
        height: unitHeight * 36,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor('#262626').withOpacity(0.3),
              width: unitHeight * 1,
            ),
          ),
        ),
        child: Row(
          children: <Expanded>[
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () => _pageController.previousPage(
                  duration: _duration,
                  curve: _kCurve,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/left_button.svg',
                  color: _selectedIndex == 0
                      ? HexColor('#BDBDBD')
                      : HexColor('#262626'),
                  height: unitHeight * 10,
                  width: unitHeight * 7,
                ),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
            Expanded(
              flex: 5,
              child: PageView(
                controller: _pageController,
                children: [
                  Center(child: Text('Парикмахерская')),
                  Center(child: Text('Барбершоп')),
                ],
                onPageChanged: (index) =>
                    setState(() => _selectedIndex = index),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () => _pageController.nextPage(
                  duration: _duration,
                  curve: _kCurve,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/right_button.svg',
                  color: _selectedIndex == 1
                      ? HexColor('#BDBDBD')
                      : HexColor('#262626'),
                  height: unitHeight * 10,
                  width: unitHeight * 7,
                ),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButtons() {
    return Container(
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
              if (!_phoneValidate && !_emailValidate) return;
              //Допилить пароль
              String password;
              if (newPasswordController.text ==
                  confirmedPasswordController.text) {
                password = newPasswordController.text == ""
                    ? widget.institution.password
                    : newPasswordController.text;
              }
              Institution institution = Institution(
                id: widget.institution.id,
                name: nameController.text,
                address: addressController.text,
                email: emailController.text,
                type: _selectedIndex == 0 ? "Парикмахерская" : "Барбершоп",
                numberPhone: phoneController.text,
                instagram: socialController.text,
                timeStart: timeStartController.text,
                timeEnd: timeEndController.text,
                password: password,
                image: _image != null ? _image.path : null,
              );
              _institutionBloc.add(EditInstitution(institution));
              _signUpBloc.institution = institution;
              Navigator.pop(context);
            },
            text: 'Применить',
            color: HexColor("#FF844B"),
          ),
        ],
      ),
    );
  }
}