import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Предстоящие'),
  Tab(text: 'Прошедшие'),
];

class TabBarRecordsState extends State<TabBarRecords> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              // Your code goes here.
              // To get index of current tab use tabController.index
            }
          });
          return Scaffold(
            appBar: TabBar(
              tabs: tabs,
              labelColor: HexColor('#262626'),
              indicatorColor: HexColor('#262626'),
              unselectedLabelColor: HexColor('#262626').withOpacity(0.6),
              labelStyle: TextStyle(fontSize: 17),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 32,
                  height: 32,
                  child: Stack(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          height: 32,
                          width: 32,
                        ),
                        onPressed: () => _showModalCalendar(context)),
                      )
                    ],
                  )
              ),
              Container(
                child: Stack(children: <Widget>[
                Text('123'),
                Text('123'),
                Text('123'),
                Text('123'),
              ]))
            ]),
          );
        }
      )
    );
  }

  void _showModalCalendar(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    Future<DateTime> future = showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 25),
              width: width - 80,
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2020, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                headerVisible: false,
                locale: 'ru_RU',
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 20,
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) =>
                    DateFormat.E(locale).format(date)[0].toUpperCase(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: width / 2 - 32,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      side: BorderSide(color: HexColor("#FF844B")),
                    ),
                    color: HexColor("#F8F7F4"),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => null,
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
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    color: HexColor("#FF844B"),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => null,
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
          ]
        );
      }
    );
    future.then((value) => _closeModal(value));
  }

  void _closeModal(DateTime value) {}
}

class TabBarRecords extends StatefulWidget {
  @override
  TabBarRecordsState createState() => TabBarRecordsState();
}
