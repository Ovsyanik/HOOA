import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/page/listRecords.dart';
import 'package:hooa/page/profile.dart';
import 'package:hooa/page/staff/staff.dart';
import 'package:hooa/page/statistic/statistic.dart';

class MainContainerPage extends StatefulWidget {
  @override
  MainContainerPageState createState() => MainContainerPageState();
}

class MainContainerPageState extends State<MainContainerPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/article.svg',
              color: _selectedIndex == 0 ? HexColor('#262626') : HexColor('#BDBDBD'),
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/users.svg',
              color: _selectedIndex == 1 ? HexColor('#262626') : HexColor('#BDBDBD'),
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chart_pie.svg',
              color: _selectedIndex == 2 ? HexColor('#262626') : HexColor('#BDBDBD'),
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/house.svg',
              color: _selectedIndex == 3 ? HexColor('#262626') : HexColor('#BDBDBD'),
              height: 32,
              width: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Записи')
          ),
        ],
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
      case 0:
        return ListRecordsPage();
        break;
      case 1:
        return StaffPage();
        break;
      case 2:
        return StatisticPage();
        break;
      case 3:
        return ProfilePage();
        break;
      default:
        return null;
    }
  }
}
