import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Услуги',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HexColor('#262626')
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            color: HexColor("#262626"),
            height: 20,
            width: 20,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/icons/add.svg',
                color: HexColor("#262626"),
                height: 20,
                width: 20,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => Navigator.of(context).pushNamed('/addService')
            // .push(MaterialPageRoute(builder: (context) => SignInPage())),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: null,
        ),
      ),
    );
  }
}