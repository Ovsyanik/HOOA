import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/tabBarRecords.dart';

class ListRecordsPage extends StatelessWidget {
  const ListRecordsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        actions: [
          MyAction('assets/icons/filter_black.svg', () => null),
          MyAction('assets/icons/add.svg',
                () => Navigator.pushNamed(context, '/addRecord'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Text(
                    'Записи ',
                    style: TextStyle(fontWeight: FontWeight.w600,
                      fontSize: unitHeight * 34,
                    ),
                  ),
                  Text(
                    '7',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor('#262626').withOpacity(0.4),
                        fontSize: unitHeight * 34,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height - 41 - 60,
              child: TabBarRecords(),
            )
          ],
        ),
      ),
    );
  }
}
