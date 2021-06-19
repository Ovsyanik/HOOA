// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;

  const CellContent({
    Key key,
    @required this.day,
    @required this.focusedDay,
    @required this.isTodayHighlighted,
    @required this.isToday,
    @required this.isSelected,
    @required this.isOutside,
    @required this.isDisabled,
    @required this.isHoliday,
    @required this.isWeekend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cell;

    if (cell != null) {
      return cell;
    }

    final text = '${day.day}';
    final margin = const EdgeInsets.symmetric(horizontal: 0.3);
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: HexColor('#262626'),
            fontSize: 16
          )
        ),
      );
    } else if (isSelected) {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        decoration: BoxDecoration(
          color: HexColor('#4E7D96'),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: const Color(0xFFFAFAFA),
            fontSize: 16.0,
          )
        ),
      );
    } else if (isToday && isTodayHighlighted) {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: HexColor('#262626'),
            fontSize: 16.0,
          )
        ),
      );
    } else if (isHoliday) {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        decoration: const BoxDecoration(
          border: const Border.fromBorderSide(
            const BorderSide(
              color: const Color(0xFF9FA8DA),
              width: 1.4
            ),
          ),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          text, 
          style: const TextStyle(
            color: const Color(0xFF5C6BC0)
          )
        ),
      );
    } else if (isOutside) {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: const Color(0xFFAEAEAE), 
            fontSize: 16
          )
        ),
      );
    } else {
      cell = AnimatedContainer(
        duration: duration,
        margin: margin,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          text,
          style: isWeekend ? const TextStyle(
            color: const Color(0xFF5A5A5A),
            fontSize: 16
          ) : const TextStyle(fontSize: 16),
        ),
      );
    }

    return cell;
  }
}
