// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../shared/utils.dart' show DayBuilder;

class CalendarHeader extends StatelessWidget {
  final VoidCallback onFirstButtonTap;
  final VoidCallback onSecondButtonTap;
  final VoidCallback onThirdButtonTap;
  final VoidCallback onFourthButtonTap;
  // final List<Decoration> decorations;

  const CalendarHeader({
    Key key,
    @required this.onFirstButtonTap,
    @required this.onSecondButtonTap,
    // @required this.decorations,
    @required this.onThirdButtonTap,
    @required this.onFourthButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 27,
            width: 65,
            // decoration: decorations[0],
            child: GestureDetector(
              onTap: onFirstButtonTap,         
              child: Text(
                getMonthName(0),
                textAlign: TextAlign.center,
              ),
            ),
          ), 
          Container(
            height: 27,
            width: 65,
            // decoration: decorations[1],
            child: GestureDetector(
              onTap: onSecondButtonTap,
              child: Text(
                getMonthName(1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 27,
            width: 65,
            // decoration: decorations[2],
            child: GestureDetector(
              onTap: onThirdButtonTap,
              child: Text(
                getMonthName(2),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 27,
            width: 65,
            // decoration: decorations[3],
            child: GestureDetector(
              onTap: onFourthButtonTap,
              child: Text(
                getMonthName(3),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getMonthName(int sum) {
    final dateTime = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month + sum, 
      DateTime.now().day
    );
    return DateFormat.MMMM('ru_RU').format(dateTime);
  }
}
