import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/starRating.dart';

class SelectedStaffPage extends StatefulWidget {
  @override
  _SelectedStaffPageState createState() => _SelectedStaffPageState();
}

class _SelectedStaffPageState extends State<SelectedStaffPage> {
  File _image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: unitHeight * 60,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/return.svg',
            color: HexColor("#262626"),
            height: unitHeight * 20,
            width: unitHeight * 20,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/add.svg',
              color: HexColor("#262626"),
              height: unitHeight * 20,
              width: unitHeight * 20,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => null,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CircleAvatar(
            radius: unitHeight * 50,
            backgroundColor: HexColor('#E0E0E0'),
            child: _image != null ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                _image,
                width: unitHeight * 100,
                height: unitHeight * 100,
                fit: BoxFit.fill,
              ),
            ) : Container(
              width: unitHeight * 40,
              height: unitHeight * 40,
              child: SvgPicture.asset(
                'assets/icons/add.svg',
                color: Colors.white,
                height: unitHeight * 28,
                width: unitHeight * 28,
              ),
            ),
          ),

        Container(
          margin: EdgeInsets.only(top: size.height * 0.02),
          alignment: Alignment.center,
          child: Text(
            'Анна Маликова',
            style: TextStyle(
              fontSize: unitHeight * 17,
              color: HexColor('#262626')
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: size.height * 0.002),
          child: Text(
            'Стилист-парикмахер',
            style: TextStyle(
                fontSize: unitHeight * 14,
                color: HexColor('#262626').withOpacity(0.3)
            ),
          ),
        ),

        // Center(
        //   child: Container(
        //     // width: size.width,
        //     margin: EdgeInsets.only(
        //       top: size.height * 0.002,
        //       // left: size.width / 2 - unitHeight * 64,
        //     ),
        //     child: Center(child: StarRating(size: unitHeight * 17)),
        //   ),
        // ),

        Container(
          margin: EdgeInsets.only(
            top: size.height * 0.002,
          ),
          // width: size.width,
          alignment: Alignment.center,
          child: GestureDetector(
            child: Row(children: [
              SvgPicture.asset(
                'assets/icons/phone.svg',
                height: unitHeight * 14,
                width:  unitHeight * 14,
              ),
              Text(
                '+375(29)7777777',
                style: TextStyle(
                  fontSize: unitHeight * 14,
                  color: HexColor('#262626'),
                ),
              ),
            ],),
            onTap: () => null,
          ),
        ),

        Container(
          width: size.width,
          child: null,
        ),

        Container(
          width: size.width,
          child: Row(children: <Widget>[

          ]),
        ),

        Container(
          width: size.width,
          child: Text(''),
        ),
      ],),
    );
  }

}