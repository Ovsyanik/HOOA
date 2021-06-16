import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/page/listRecords.dart';
import 'package:hooa/page/profile.dart';
import 'package:hooa/page/signIn.dart';
import 'package:hooa/page/statistics.dart';
import 'package:hooa/page/users.dart';

class RecordsPage extends StatefulWidget {
  @override
  RecordsPageState createState() => RecordsPageState();
}

class RecordsPageState extends State<RecordsPage> {
int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
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
              height: 40,
              width: 40,
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
              builder: (BuildContext context) {
                return Container(

                );
              }
            )
          ),
          IconButton(
            icon: Icon(Icons.add, color: HexColor("#262626")),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignInPage())),
          ),
        ],
      ),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/article.svg',
              color: HexColor('#BDBDBD'),
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/users.svg',
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chart_pie.svg',
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/house.svg',
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
        ],
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: onItemTapBottomBar,
      ),
    );
  }

  onItemTapBottomBar(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget getBody() {
    switch (_selectedIndex) {
      case 0: return ListRecordsPage(); break;
      case 1: return UsersPage(); break;
      case 2: return StatisticsPage(); break;
      case 3: return ProfilePage(); break;
      default: return null;
    }
  }

}
