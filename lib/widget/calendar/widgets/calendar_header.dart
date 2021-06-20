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
    Key key,
    this.decorations,
    @required this.selectedDate,
    @required this.onFirstButtonTap,
    @required this.onSecondButtonTap,
    @required this.onThirdButtonTap,
    @required this.onFourthButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BoxDecoration> decorations1;
    if(decorations == null){
    if(selectedDate.month == DateTime.now().month) {
      decorations1 = [
        BoxDecoration(
          color: HexColor('#4E7D96'),
          border: Border.all(
            color: HexColor('#4E7D96'), 
            width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        null,
        null,
        null
      ];
    } else if(selectedDate.month == DateTime.now().month + 1) {
      decorations1 = [
        null,         
        BoxDecoration(
          color: HexColor('#4E7D96'),
          border: Border.all(
            color: HexColor('#4E7D96'), 
            width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        null, 
        null
      ];
    } else if(selectedDate.month == DateTime.now().month + 2) {
      decorations1 = [
        null, 
        null,         
        BoxDecoration(
          color: HexColor('#4E7D96'),
          border: Border.all(
            color: HexColor('#4E7D96'), 
            width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        null
        ];
    } else if(selectedDate.month == DateTime.now().month + 3) {
      decorations1 = [
        null, 
        null, 
        null,         
        BoxDecoration(
          color: HexColor('#4E7D96'),
          border: Border.all(color: HexColor('#4E7D96'), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        )
      ];
    }
    }

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
            decoration: decorations != null ? decorations[0]: decorations1[0],
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
            decoration: decorations != null ? decorations[1] : decorations1[1],
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
            decoration: decorations != null ? decorations[2] : decorations1[2],
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
            decoration: decorations != null ? decorations[3] : decorations1[3],
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
