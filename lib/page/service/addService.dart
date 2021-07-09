import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

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

  int _selectedIndex = 0;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: unitHeight * 60,
        centerTitle: true,
        title: Text(
          'Добавление услуги',
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              child: TextField(
                controller: this._nameController,
                decoration: InputDecoration(
                  hintText: "Название",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              child: TextField(
                controller: this._descriptionController,
                decoration: InputDecoration(
                  hintText: "Описание",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: HexColor("#262626").withOpacity(0.3),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Стоимость',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: this._priceController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 17,
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Длительность',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: this._timeController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 17,
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
              child: Row(
                children: <Widget>[
                  Container(
                    width: size.width / 2 - 16,
                    child: Text(
                      'Составляющая длительности',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 2 - 16,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor('#262626').withOpacity(0.3),
                          width: 1,
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
                              height: 10,
                              width: 7,
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
                              height: 10,
                              width: 7,
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
                      height: 50,
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
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
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
                          Navigator.pop(context);
                          },
                        child: Text(
                          "Применить",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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