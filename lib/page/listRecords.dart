import 'package:flutter/material.dart';

class ListRecordsPage extends StatelessWidget {
  const ListRecordsPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
        children: <Widget>[
          
          Positioned(
            left: width / 20,
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
          )
        ],
      ),
  }
}