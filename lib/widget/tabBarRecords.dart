import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
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

  @override
  void initState() {
    super.initState();

    _selectedDate = _focusedDay;
    selectedDate = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: TabBar(
                tabs: tabs,
                labelColor: HexColor('#262626'),
                indicatorColor: HexColor('#262626'),
                unselectedLabelColor: HexColor('#262626').withOpacity(0.6),
                labelStyle: TextStyle(fontSize: 17),
              ),
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: size.width,
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              height: 32,
                              width: 20,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => _showModalCalendar(context)
                          ),
                        ),
                        Expanded(
                            child: Timeline(
                              children: <Widget>[
                                Container(height: 100, color: Colors.amber),
                                Container(height: 50, color: Colors.amber),
                                Container(height: 200, color: Colors.amber),
                                Container(height: 100, color: Colors.amber),
                                Container(height: 100, color: Colors.amber),
                                Container(height: 200, color: Colors.amber),
                              ],
                              indicators: <Widget>[
                                Text(
                                    '12:00',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                ),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      fontSize: 13,
                                      backgroundColor: Colors.white,
                                  ),
                                ),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      fontSize: 13
                                  ),
                                ),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      fontSize: 13,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                Text('12:00'),
                                Text('12:00'),
                              ],
                            ),
                        )
                      ],
                    ),
                  Container(
                  child: Stack(
                    children: <Widget>[
                      Text('123'),
                      Text('123'),
                    ]
                  )
                )
              ]
            ),
          );
        }
      )
    );
  }

  void _showModalCalendar(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setMyState){

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
                    margin: EdgeInsets.only(top: 30, bottom: 25),
                    width: width - 100,
                    child: TableCalendar(
                      selectedDay: selectedDate,
                      firstDay: DateTime.utc(2020, 10, 16),
                      lastDay: DateTime.utc(
                        DateTime.now().year + 2,
                        DateTime.now().month, 
                        DateTime.now().day
                      ),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                      onDaySelected: _onDaySelected,
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: HexColor('#262626').withOpacity(0.3),
                        width: 1
                      ) 
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: width / 2 - 32,
                        margin: EdgeInsets.only(bottom: 16, top: 16),
                        child: MaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
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
                              fontSize: 15
                            ),
                          )
                        ),
                      ),
                      Container(
                        height: 50,
                        width: width / 2 - 32,
                        margin: EdgeInsets.only(bottom: 16, top: 16),
                        child: MaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          color: HexColor("#FF844B"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() => 
                              setMyState(() => selectedDate = _selectedDate));
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Применить",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 15
                            ),
                          )
                        ),
                      ),
                    ] 
                  )
                )
              ]
            );   
          }   
        );
      }
    );
  }
}

class TabBarRecords extends StatefulWidget {
  @override
  TabBarRecordsState createState() => TabBarRecordsState();
}