import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/salesBloc.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/model/Sale.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/CheckBox.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';
import 'package:hooa/widget/dropDown/ExpandedListAnimationWidget.dart';

class AddSalesPage extends StatefulWidget{
  final Institution institution;

  AddSalesPage({
    this.institution
  });

  @override
  AddSalesPageState createState() => AddSalesPageState();
}

class AddSalesPageState extends State<AddSalesPage> {
  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();
  final countController = TextEditingController();
  Map<Service, bool> selectedService = Map<Service, bool>();
  bool isStrechedDropDown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: 'Добавление скидки',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(children: [
              Container(
                child: Row(children: [
                  Expanded(
                    child: Text(
                      'Длительность',
                      style: TextStyle(
                        fontSize: unitHeight * 16.0,
                        color: HexColor('#262626'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      height: unitHeight * 32,
                      width: unitHeight * 20,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => null,
                        // onPressed: () => _showModalCalendar(context),
                  ),
                ],),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                height: unitHeight * 50,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      'Дата начала',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                        color: HexColor('#262626'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      inputFormatters: [DateTextFormatter()],
                      controller: this.dateStartController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'ДД.ММ.ГГ',
                        hintStyle: TextStyle(
                          fontSize: unitHeight * 16,
                          color: HexColor("#262626"),
                        ),
                      ),
                    ),
                  ),
                ],),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                height: unitHeight * 50,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      'Время конца',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      inputFormatters: [DateTextFormatter()],
                      controller: this.dateEndController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'ДД.ММ.ГГ',
                        hintStyle: TextStyle(
                          fontSize: unitHeight * 16,
                          color: HexColor("#262626"),
                        ),
                      ),
                    ),
                  ),
                ],),
              ),

              SafeArea(
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () => setState(() {
                                    isStrechedDropDown = !isStrechedDropDown;
                                  }),
                                  child: Row(children: [
                                    Text(
                                      'Виды услуг',
                                      style: TextStyle(
                                        fontSize: unitHeight * 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(isStrechedDropDown
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down),
                                  ]),
                                ),
                              ],),
                            ),
                            ExpandedSection(
                              expand: isStrechedDropDown,
                              height: 100,
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overScroll) {
                                  overScroll.disallowGlow();
                                  return;
                                  },
                                child: BlocBuilder(
                                  bloc: BlocProvider.of<ServicesBloc>(context),
                                  builder: (context, ServicesState state) => ListView.builder(
                                    itemCount: state.categories.length,
                                    itemBuilder: (context, index) {
                                      List<Service> services = state.services
                                          .where((element) =>
                                      element.categoryService ==
                                          state.categories[index].id)
                                          .toList();
                                      if (selectedService.isEmpty) {
                                        for (int i = 0; i <
                                            services.length; i++) {
                                          selectedService.putIfAbsent(
                                              services[i], () => false);
                                        }
                                      }
                                      return DropDown(
                                        unitHeight: unitHeight,
                                        title: state.categories[index].name,
                                        list: List<Widget>.generate(
                                            services.length, (index) =>
                                            _getItemDropdown(
                                                unitHeight, services[index],
                                                index,
                                                selectedService[selectedService
                                                    .keys.elementAt(index)],)
                                        ),
                                      );
                                      },
                                  ),
                                ),
                              ),
                            ),
                          ],),
                        ),
                      ),
                    ],),
                ],),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                height: unitHeight * 50,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      'Стоимость',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: this.countController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: unitHeight * 17,
                          color: HexColor("#262626").withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],),
              ),
            ],),
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
                    for(int i = 0; i < selectedService.length; i++) {
                      if(selectedService.values.elementAt(i) == true) {
                        BlocProvider.of<SalesBloc>(context).add(AddSale(Sale(
                          institution: widget.institution.id,
                          service: selectedService.keys.elementAt(i).id,
                          count: int.parse(countController.text),
                        )));
                      }
                    }
                    Navigator.pop(context);
                    },
                  text: 'Применить',
                  color: HexColor("#FF844B"),
                ),
              ],
            ),
          ),
        ],),
      ),
    );
  }

  Widget _getItemDropdown(double unitHeight, Service service, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() =>
        selectedService[selectedService.keys.elementAt(index)] =
          !selectedService[selectedService.keys.elementAt(index)]),
      child: Container(
        margin: EdgeInsets.only(bottom: unitHeight * 16),
        width: unitHeight * 1,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor('#262626').withOpacity(0.5),
            ),
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
          )
        ],),
      ),
    );
  }

  @override
  void dispose() {
    dateStartController.dispose();
    dateEndController.dispose();

    super.dispose();
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '.');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String separator) {
    value = value.replaceAll(separator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += separator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}