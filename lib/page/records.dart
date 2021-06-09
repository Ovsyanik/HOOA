import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/page/signIn.dart';

class RecordsPage extends StatefulWidget {
  @override
  RecordsPageState createState() => RecordsPageState();
}

class RecordsPageState extends State<RecordsPage> {
int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              height: 20,
              width: 20,
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
      body: Stack(
        children: <Widget>[
          Positioned(
              left: width / 20,
              child: Text(
                'Записи 7',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: height / 30),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              // ignore: deprecated_member_use
              title: Text('Записи')),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              // ignore: deprecated_member_use
              title: Text('Записи')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
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

}
