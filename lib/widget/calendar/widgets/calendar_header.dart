import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onFirstButtonTap;
  final VoidCallback onSecondButtonTap;
  final VoidCallback onThirdButtonTap;
  final VoidCallback onFourthButtonTap;
  final List<BoxDecoration> decorations;

  const CalendarHeader({
    this.decorations,
    @required this.selectedDate,
    @required this.onFirstButtonTap,
    @required this.onSecondButtonTap,
    @required this.onThirdButtonTap,
    @required this.onFourthButtonTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeight = size.height * 0.00125;
    List<BoxDecoration> decorations1;
    if (decorations == null) {
      if (selectedDate.month == DateTime.now().month) {
        decorations1 = [
          BoxDecoration(
            color: HexColor('#4E7D96'),
            border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          null,
          null,
          null
        ];
      } else if (selectedDate.month == DateTime.now().month + 1) {
        decorations1 = [
          null,
          BoxDecoration(
            color: HexColor('#4E7D96'),
            border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          null,
          null
        ];
      } else if (selectedDate.month == DateTime.now().month + 2) {
        decorations1 = [
          null,
          null,
          BoxDecoration(
            color: HexColor('#4E7D96'),
            border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          null
        ];
      } else if (selectedDate.month == DateTime.now().month + 3) {
        decorations1 = [
          null,
          null,
          null,
          BoxDecoration(
            color: HexColor('#4E7D96'),
            border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          )
        ];
      }
    }

    return Container(
      width: 0.8 * size.width,
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: unitHeight * 27,
            width: 65,
            decoration: decorations != null ? decorations[0] : decorations1[0],
            child: GestureDetector(
              onTap: onFirstButtonTap,
              child: Text(
                getMonthName(0),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: decorations != null
                      ? (decorations[0] != null
                          ? Colors.white
                          : HexColor('#262626'))
                      : (decorations1[0] != null
                          ? Colors.white
                          : HexColor('#262626')),
                ),
              ),
            ),
          ),
          Container(
            height: unitHeight * 27,
            width: 65,
            decoration: decorations != null ? decorations[1] : decorations1[1],
            child: GestureDetector(
              onTap: onSecondButtonTap,
              child: Text(
                getMonthName(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: decorations != null
                      ? (decorations[1] != null
                          ? Colors.white
                          : HexColor('#262626'))
                      : (decorations1[1] != null
                          ? Colors.white
                          : HexColor('#262626')),
                ),
              ),
            ),
          ),
          Container(
            height: unitHeight * 27,
            width: 65,
            decoration: decorations != null ? decorations[2] : decorations1[2],
            child: GestureDetector(
              onTap: onThirdButtonTap,
              child: Text(
                getMonthName(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: decorations != null
                      ? (decorations[2] != null
                          ? Colors.white
                          : HexColor('#262626'))
                      : (decorations1[2] != null
                          ? Colors.white
                          : HexColor('#262626')),
                ),
              ),
            ),
          ),
          Container(
            height: unitHeight * 27,
            width: 65,
            decoration: decorations != null ? decorations[3] : decorations1[3],
            child: GestureDetector(
              onTap: onFourthButtonTap,
              child: Text(
                getMonthName(3),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: decorations != null
                      ? (decorations[3] != null
                          ? Colors.white
                          : HexColor('#262626'))
                      : (decorations1[3] != null
                          ? Colors.white
                          : HexColor('#262626')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getMonthName(int sum) {
    final dateTime = DateTime.utc(
        DateTime.now().year, DateTime.now().month + sum, DateTime.now().day);
    return DateFormat.MMMM('ru_RU').format(dateTime);
  }
}
