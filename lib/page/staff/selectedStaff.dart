import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/calendar/table_calendar.dart';
import 'package:hooa/widget/starRating.dart';

class SelectedStaffPage extends StatefulWidget {
  @override
  _SelectedStaffPageState createState() => _SelectedStaffPageState();
}

class _SelectedStaffPageState extends State<SelectedStaffPage> {
  final _pageController = PageController();

  File _image;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      currentIndex = _pageController.page.round();
    });
  }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      double unitHeight = size.height * 0.00125;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: unitHeight * 60,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/return.svg',
              color: HexColor("#262626"),
              height: unitHeight * 20,
              width: unitHeight * 20,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/add.svg',
                color: HexColor("#262626"),
                height: unitHeight * 20,
                width: unitHeight * 20,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => null,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
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

            SizedBox(height: unitHeight * 6),

            Text(
              'Анна Маликова',
              style: TextStyle(
                  fontSize: unitHeight * 17,
                  color: HexColor('#262626')
              ),
            ),

            SizedBox(height: unitHeight * 4),

            Text(
              'Стилист-парикмахер',
              style: TextStyle(
                  fontSize: unitHeight * 14,
                  color: HexColor('#262626').withOpacity(0.3)
              ),
            ),

            SizedBox(height: unitHeight * 4),

            //переделать
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarRating(size: unitHeight * 17),
              ],
            ),

            SizedBox(height: unitHeight * 4),

            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/phone.svg',
                    height: unitHeight * 14,
                    width: unitHeight * 14,
                  ),
                  Text(
                    '+375(29) 777 77 77',
                    style: TextStyle(
                      fontSize: unitHeight * 14,
                      color: HexColor('#262626'),
                    ),
                  ),
                ],
              ),
              onTap: () => null,
            ),

            SizedBox(height: unitHeight * 4),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Редактировать',
                style: TextStyle(
                  fontSize: unitHeight * 13,
                  color: HexColor("#4E7D96"),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/changeStaff'),
              ),
            ),

            SizedBox(height: unitHeight * 4),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: unitHeight * 38,
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: currentIndex == 0
                              ? HexColor("#FF844B")
                              : HexColor("#F2F2F2"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () =>
                              setState(() => _pageController.jumpToPage(0)),
                          child: Text(
                            "Режим работы",
                            style: TextStyle(
                              color: currentIndex == 0
                                  ? Colors.white
                                  : HexColor("#262626"),
                              fontSize: unitHeight * 13,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: unitHeight * 38,
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: currentIndex == 1
                              ? HexColor("#FF844B")
                              : HexColor("#F2F2F2"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () =>
                              setState(() => _pageController.jumpToPage(1)),
                          child: Text(
                            "Услуги",
                            style: TextStyle(
                              color: currentIndex == 1
                                  ? Colors.white
                                  : HexColor("#262626"),
                              fontSize: unitHeight * 13,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: unitHeight * 38,
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: currentIndex == 2
                              ? HexColor("#FF844B")
                              : HexColor("#F2F2F2"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () =>
                              setState(() => _pageController.jumpToPage(2)),
                          child: Text(
                            'Отзывы',
                            style: TextStyle(
                              color: currentIndex == 2
                                  ? Colors.white
                                  : HexColor("#262626"),
                              fontSize: unitHeight * 13,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PageView(
                  controller: _pageController,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 25),
                        width: size.width - 100,
                        child: TableCalendar(
                          selectedDay: DateTime.now(),
                          firstDay: DateTime.utc(2020, 10, 16),
                          lastDay: DateTime.utc(
                            DateTime.now().year + 2,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                          focusedDay: DateTime.now(),
                          // selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                          // onDaySelected: _onDaySelected,
                          // onPageChanged: (focusedDay) {
                          //   _focusedDay = focusedDay;
                          // },
                        ),
                      ),
                    ),
                    Center(child: Text('часы')),
                    Center(child: Text('$currentIndex')),
                  ],
                  onPageChanged: (index) =>
                      setState(() => _pageController.jumpToPage(index)),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }