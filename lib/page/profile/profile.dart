import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/page/profile/ChangeProfileInstitution.dart';
import 'package:hooa/page/sales/SalesPage.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/starRating.dart';

class ProfilePage extends StatelessWidget {
  File _image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    Institution institution = BlocProvider.of<SignUpBloc>(context).institution;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        showLeading: false,
        actions: [
          MyAction('assets/icons/settings.svg',
                () async => await Navigator.push<Institution>(context, MaterialPageRoute(builder:
                    (context) => ChangeProfileInstitution(institution: institution,))),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width - unitHeight * 32,
              child: Text(
                "Профиль",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: unitHeight * 34
                ),
              ),
            ),

            SizedBox(height: unitHeight * 25),

            CircleAvatar(
              radius: unitHeight * 55,
              backgroundColor: HexColor('#E0E0E0'),
              child: _image != null ? ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.file(
                  _image,
                  width: unitHeight * 110,
                  height: unitHeight * 110,
                  fit: BoxFit.fill,
                ),
              ) : Container(
                width: unitHeight * 50,
                height: unitHeight * 50,
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  color: Colors.white,
                  height: unitHeight * 30,
                  width: unitHeight * 30,
                  ),
                ),
              ),

            SizedBox(height: unitHeight * 20),

            Text(
              institution.name,
              style: TextStyle(
                fontSize: unitHeight * 17,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626')
              ),
            ),

            SizedBox(height: unitHeight * 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarRating(size: unitHeight * 17),
              ],
            ),

            SizedBox(height: unitHeight * 12),

            Text(
              'Время работы: ${institution.timeStart} - ${institution.timeEnd}',
              style: TextStyle(
                  fontSize: unitHeight * 16,
                  color: HexColor('#262626')
              ),
            ),

            SizedBox(height: unitHeight * 12),

            Text(
              'Адрес: ${institution.address}',
              style: TextStyle(
                  fontSize: unitHeight * 16,
                  color: HexColor('#262626')
              ),
            ),

            SizedBox(height: unitHeight * 12),

            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/InstagramLogo.svg',
                    height: unitHeight * 18,
                    width: unitHeight * 18,
                  ),
                  Text(
                    ' ${institution.instagram}',
                    style: TextStyle(
                      fontSize: unitHeight * 16,
                      color: HexColor('#262626'),
                    ),
                  ),
                ],
              ),
              onTap: () => null,
            ),

            SizedBox(height: unitHeight * 57),


            Container(
              height: unitHeight * 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: HexColor('#C6C6C8').withOpacity(0.3),
                    width: 1
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/services"),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: unitHeight * 8, right: unitHeight * 16),
                  trailing: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    color: HexColor("#262626"),
                    height: unitHeight * 15,
                    width: unitHeight * 15,
                  ),
                  title: Text(
                    "Услуги",
                    style: TextStyle(
                      fontSize: unitHeight * 17,
                      color: HexColor('#262626'),
                    ),
                  ),
                )
              ),
            ),

            SizedBox(height: unitHeight * 8,),

            Container(
              height: unitHeight * 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: HexColor('#C6C6C8').withOpacity(0.3),
                      width: 1
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder:
                    (context) => SalesPage(institution: institution))),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: unitHeight * 8, right: unitHeight * 16),
                  trailing: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    color: HexColor("#262626"),
                    height: unitHeight * 15,
                    width: unitHeight * 15,
                  ),
                  title: Text(
                    "Скидки",
                    style: TextStyle(
                      fontSize: unitHeight * 17,
                      color: HexColor('#262626'),
                    ),
                  ),
                )
              ),
            ),

            SizedBox(height: unitHeight * 8),

            Container(
              height: unitHeight * 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: HexColor('#C6C6C8').withOpacity(0.3),
                      width: 1
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/callback"),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: unitHeight * 8, right: unitHeight * 16),
                  trailing: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    color: HexColor("#262626"),
                    height: unitHeight * 15,
                    width: unitHeight * 15,
                  ),
                  title: Text(
                    "Обратная связь",
                    style: TextStyle(
                      fontSize: unitHeight * 17,
                      color: HexColor('#262626'),
                    ),
                  ),
                )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: unitHeight * 8),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<SignUpBloc>(context).institution = null;
                  Navigator.pushNamed(context, "/");
                },
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: unitHeight * 8),
                  leading: SvgPicture.asset(
                    'assets/icons/sign_out.svg',
                    color: HexColor("#262626"),
                    height: unitHeight * 30,
                    width: unitHeight * 30,
                  ),
                  title: Text(
                    "Выйти из аккаунта",
                    style: TextStyle(
                      fontSize: unitHeight * 17,
                      color: HexColor('#262626'),
                    ),
                  ),
                )
              ),
            ),

        ],),
      ),
    );
  }
}