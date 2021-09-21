import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/widget/MyAppBar.dart';

class AddServicePage extends StatefulWidget {
  final _duration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;
  @override
  _AddServicePageState createState() => _AddServicePageState();
} 

class _AddServicePageState extends State<AddServicePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _timeController = TextEditingController();
  final _pageController = PageController();
  FocusNode _timeFocus;
  FocusNode _priceFocus;

  int _selectedIndex = 0;
  int lengthDescription = 0;

  @override
  void initState() {
    super.initState();
    _timeFocus = FocusNode();
    _priceFocus = FocusNode();

    _priceFocus.addListener(() {
      setState(() {
        String str = _priceController.value.text.split(' ')[0];
        if (_priceFocus.hasFocus) {
          _priceController.text = str;
        } else {
          _priceController.text = '$str BYN';
        }
      });
    });

    _timeFocus.addListener(() {
      setState(() {
        String str = _timeController.value.text.split(' ')[0];
        if (_timeFocus.hasFocus) {
          _timeController.text = '$str';
        } else {
          if (_pageController.page.round() == 0) {
            _timeController.text = '$str минут';
          } else {
            _timeController.text = '$str часа';
          }
        }
      });
    });

    _descriptionController.addListener(() {
      lengthDescription = _descriptionController.value.text.length;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _timeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: 'Добавление услуги',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              height: unitHeight * 50,
              child: TextField(
                controller: this._nameController,
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
              height: lengthDescription == 0 ? unitHeight * 50 : null,
              child: TextField(
                controller: this._descriptionController,
                minLines: 1,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: "Описание",
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
                      'Стоимость',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _priceFocus,
                      controller: this._priceController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
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

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              height: unitHeight * 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Длительность',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _timeFocus,
                      controller: this._timeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
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

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              height: unitHeight * 50,
              child: Row(
                children: <Widget>[
                  Container(
                    width: size.width / 2 - 16,
                    child: Text(
                      'Составляющая длительности',
                      style: TextStyle(
                        fontSize: unitHeight * 17.0,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 2 - 16,
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
                          child: IconButton(
                            onPressed: () => _pageController.previousPage(
                              duration: widget._duration,
                              curve: widget._kCurve,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/left_button.svg',
                              color: _selectedIndex == 0 ? HexColor('#BDBDBD') : HexColor('#262626'),
                              height: unitHeight * 10,
                              width: unitHeight * 7,
                            ),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            children: [
                              Center(child: Text('минуты')),
                              Center(child: Text('часы')),
                            ],
                            onPageChanged: (index) {
                              setState(() {
                                _selectedIndex = index;
                                // String str = _timeController.value.text.split(' ')[0];
                                // if()
                                // _timeController.text = '$str минут';
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () => _pageController.nextPage(
                              duration: widget._duration,
                              curve: widget._kCurve,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/right_button.svg',
                              color: _selectedIndex == 1 ? HexColor('#BDBDBD') : HexColor('#262626'),
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
                ],
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: unitHeight * 50,
                      width: size.width / 2 - 24,
                      margin: EdgeInsets.symmetric(vertical: 16.0),
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
                            fontSize: unitHeight * 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: unitHeight * 50,
                      width: size.width / 2 - 24,
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
                          var bloc = BlocProvider.of<ServicesBloc>(context);
                          bloc.add(AddService(Service(
                            name: _nameController.value.text,
                            description: _descriptionController.value.text,
                            price: _priceController.value.text.split(' ')[0],
                            time: _timeController.value.text,
                            categoryService: 1,
                          )));
                          Navigator.pushNamed(context, '/services');
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

          ],
        ),
      ),
    );
  }
}

class ServiceModel {
  bool isSelected;
  Service service;

  ServiceModel(this.isSelected, this.service);
}