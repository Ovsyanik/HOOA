import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/tabBarRecords.dart';

class ListRecordsPage extends StatelessWidget {
  const ListRecordsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: unitHeight * 60,
        elevation: 0,
        actions: <IconButton>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/filter_black.svg',
              color: HexColor("#262626"),
              height: unitHeight * 30,
              width: unitHeight * 30,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              builder: (context) {
                return Container(

                );
              }
            )
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/add.svg',
              color: HexColor("#262626"),
              height: unitHeight * 20,
              width: unitHeight * 20,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pushNamed(context, '/addRecord'),
          ),
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
