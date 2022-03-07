import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/timeLine.dart';
import 'package:hooa/widget/calendar/shared/utils.dart';
import 'package:hooa/widget/calendar/table_calendar.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Предстоящие'),
  Tab(text: 'Прошедшие'),
];

class TabBarRecordsState extends State<TabBarRecords> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate;
  DateTime selectedDate;

  Size size;
  double unitHeight;

  @override
  void initState() {
    super.initState();

    _selectedDate = _focusedDay;
    selectedDate = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
              return;
            },
            child: Scaffold(
              appBar: TabBar(
                tabs: tabs,
                labelColor: HexColor('#262626'),
                indicatorColor: HexColor('#262626'),
                unselectedLabelColor: HexColor('#262626').withOpacity(0.6),
                labelStyle: TextStyle(fontSize: unitHeight * 17),
              ),
              body: TabBarView(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          height: unitHeight * 32,
                          width: unitHeight * 20,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => _showModalCalendar(),
                      ),
                    ),
                    Expanded(
                      child: Timeline(
                        children: <Widget>[
                          Container(
                              height: unitHeight * 100, color: Colors.amber),
                          Container(
                              height: unitHeight * 50, color: Colors.amber),
                          Container(
                              height: unitHeight * 200, color: Colors.amber),
                          Container(
                              height: unitHeight * 100, color: Colors.amber),
                          Container(
                              height: unitHeight * 100, color: Colors.amber),
                          Container(
                              height: unitHeight * 200, color: Colors.amber),
                        ],
                        indicators: <Widget>[
                          Text(
                            '12:00',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
                            ),
                          ),
                          Text(
                            '12:00',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Text(
                            '12:00',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
                            ),
                          ),
                          Text(
                            '12:00',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Text('12:00'),
                          Text('12:00'),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('123'),
                      Text('123'),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  void _showModalCalendar() {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setMyState) {
            void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                setMyState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            }

            return Wrap(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 25),
                    width: size.width - 100,
                    child: TableCalendar(
                      selectedDay: selectedDate,
                      firstDay: DateTime.utc(2020, 10, 16),
                      lastDay: DateTime.utc(DateTime.now().year + 2,
                          DateTime.now().month, DateTime.now().day),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDate, day),
                      onDaySelected: _onDaySelected,
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: HexColor('#262626').withOpacity(0.3),
                          width: 1),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          text: 'Сбросить',
                          color: HexColor("#F8F7F4"),
                          textColor: HexColor("#FF844B"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Button(
                          text: 'Применить',
                          onPressed: () {
                            setState(() =>
                                setMyState(() => selectedDate = _selectedDate));
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class TabBarRecords extends StatefulWidget {
  @override
  TabBarRecordsState createState() => TabBarRecordsState();
}
