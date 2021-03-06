import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';

class ChangeServicePage extends StatefulWidget {
  final _duration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;
  final BuildContext context;

  const ChangeServicePage({Key key, this.context}) : super(key: key);

  @override
  _ChangeServicePageState createState() => _ChangeServicePageState();
}

class _ChangeServicePageState extends State<ChangeServicePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _timeController = TextEditingController();
  final _pageController = PageController();
  FocusNode _timeFocus;
  FocusNode _priceFocus;

  int _selectedIndex = 0;
  int lengthDescription = 0;

  Service service;



  @override
  void initState() {
    super.initState();
    _timeFocus = FocusNode();
    _priceFocus = FocusNode();

    _priceFocus.addListener(() => setState(() {
      String str = _priceController.value.text.split(' ')[0];
      if (_priceFocus.hasFocus) {
        _priceController.text = str;
      } else {
        _priceController.text = '$str BYN';
      }
    }));

    _timeFocus.addListener(() => setState(() {
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
    }));

    _descriptionController.addListener(() {
      lengthDescription = _descriptionController.value.text.length;
    });


    service = ModalRoute.of(widget.context).settings.arguments as Service;

    _nameController.text = service.name;
    _descriptionController.text = service.description;
    _priceController.text = service.price + ' BYN';
    _timeController.text = service.time;
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
        title: 'Редактирование услуги',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Column(children: <Widget>[

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
            ],),
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
            child: Row(children: <Widget>[
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
                width: size.width / 2 - 17,
                height: unitHeight * 36,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: HexColor('#262626').withOpacity(0.3),
                      width: unitHeight * 1,
                    ),
                  ),
                ),
                child: Row(children: <Expanded>[
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
                ]),
              ),
            ]),
          ),
          Expanded(
            child: Align(
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
                      var bloc = BlocProvider.of<ServicesBloc>(context);
                      bloc.add(ChangeService(Service(
                          id: service.id,
                          name: _nameController.value.text,
                          description: _descriptionController.value.text,
                          price: _priceController.value.text.split(' ')[0],
                          time: _timeController.value.text,
                          categoryService: 1,
                        )));
                      for(int i = 0; i < 3; i++)
                        Navigator.pop(context);
                      },
                    text: 'Применить',
                    color: HexColor("#FF844B"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
  );
}
}