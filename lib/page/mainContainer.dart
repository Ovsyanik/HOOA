import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/page/records/listRecords.dart';
import 'package:hooa/page/profile/profile.dart';
import 'package:hooa/page/staff/staff.dart';
import 'package:hooa/page/statistic/statistic.dart';

class MainContainerPage extends StatefulWidget {
  final Institution institution;

  MainContainerPage({
    this.institution
  });

  @override
  MainContainerPageState createState() => MainContainerPageState();
}

class MainContainerPageState extends State<MainContainerPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final unitHeight = sizeScreen.height * 0.00125;
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: SizedBox(
        height: unitHeight * 70,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/article.svg',
                color: _selectedIndex == 0 ? HexColor('#262626') : HexColor('#BDBDBD'),
                height: unitHeight * 32,
                width: unitHeight * 32,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/users.svg',
                color: _selectedIndex == 1 ? HexColor('#262626') : HexColor('#BDBDBD'),
                height: unitHeight * 32,
                width: unitHeight * 32,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/chart_pie.svg',
                color: _selectedIndex == 2 ? HexColor('#262626') : HexColor('#BDBDBD'),
                height: unitHeight * 32,
                width: unitHeight * 32,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/house.svg',
                color: _selectedIndex == 3 ? HexColor('#262626') : HexColor('#BDBDBD'),
                height: unitHeight * 32,
                width: unitHeight * 32,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: onItemTapBottomBar,
        ),
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
        return ProfilePage(institution: widget.institution);
        break;
      default:
        return null;
    }
  }
}
