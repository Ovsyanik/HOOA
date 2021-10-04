import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rxdart/rxdart.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime selectedDate;
  final onSelectMonth;

  const CalendarHeader({
    @required this.selectedDate,
    @required this.onSelectMonth,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = new BehaviorSubject<DateTime>();
    return Container(
      width: double.infinity,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: PageView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          if(index==1) index = index + 3;
          if(index==2) index = index + 6;
          return Row(
            children: _buildWidgets(index,controller,onSelectMonth,selectedDate),
          );
        }
      )
    );
  }

  List<Widget> _buildWidgets(page, controller,onSelectMonth,selectedDate){
    return List.generate(7, (index) {
      if(index % 2 == 0)
        return Expanded(
          child: MonthHeaderWidget(month: page + index ~/ 2,
          str: controller,onSelectMonth: onSelectMonth,
          initDate: selectedDate),
        );
      else
        return VerticalDivider(color: Colors.transparent);
    });
  }
}


class MonthHeaderWidget extends StatelessWidget {

  MonthHeaderWidget({
    @required this.initDate,
    @required this.month,
    @required this.onSelectMonth,
    @required this.str
  });

  final int month;
  final onSelectMonth;
  final BehaviorSubject<DateTime> str;
  final DateTime initDate;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate;
    bool isActive;
    return StreamBuilder<DateTime>(
      stream: str,
      builder: (context, snapshot) {
        DateTime date = DateTime.now();
        if(snapshot.hasData) selectedDate = snapshot.data;
        else selectedDate = initDate;
        date = DateTime(
          initDate.year,
          initDate.month + month > 12 ? initDate.month + month - 12 : initDate.month + month,
          initDate.day,
          initDate.hour,
          initDate.minute,
          initDate.second,
          initDate.millisecond,
          initDate.microsecond,
        );
        if(date == selectedDate) isActive = true;
        else isActive = false;
        return GestureDetector(
          onTap: (){
            onSelectMonth(month);
            str.add(date);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: isActive ? BoxDecoration(
              color: HexColor('#4E7D96'),
              borderRadius: BorderRadius.circular(20),
            ) : null,
            child: Text(
              getMonthName(month, initDate),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey
              ),
            ),
          ),
        );
      }
    );
  }

  String getMonthName(int sum , DateTime initDate) {
    initializeDateFormatting();
    if(initDate == null) initDate = DateTime.now();
    final dateTime = DateTime.utc(
      initDate.year,
      initDate.month + sum,
      initDate.day
    );
    return DateFormat.MMMM('ru_RU').format(dateTime);
  }
}