import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/tabBarRecords.dart';

class ListRecordsPage extends StatelessWidget {
  const ListRecordsPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Positioned>[

        Positioned(
          left: 16,
          height: 41,
          child: Row(
            children: [
              Text(
                'Записи ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34
                ),
              ),
              Text(
                '7',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626').withOpacity(0.4),
                  fontSize: 34
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 60,
          left: 16,
          width: width - 32,
          height: height - 41 - 60,
          child: TabBarRecords(),
        )

      ],
    );
  }
}