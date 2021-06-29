import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/tabBarRecords.dart';

class ListRecordsPage extends StatelessWidget {
  const ListRecordsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <IconButton>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/filter_black.svg',
              color: HexColor("#262626"),
              height: 30,
              width: 30,
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
                height: 20,
                width: 20,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => Navigator.of(context)
              // .push(MaterialPageRoute(builder: (context) => SignInPage())),
              ),
        ],
      ),
      body: Stack(
        children: <Positioned>[
          Positioned(
            left: 16,
            height: 41,
            child: Row(
              children: [
                Text(
                  'Записи ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 34),
                ),
                Text(
                  '7',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#262626').withOpacity(0.4),
                      fontSize: 34),
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
      ),
    );
  }
}
