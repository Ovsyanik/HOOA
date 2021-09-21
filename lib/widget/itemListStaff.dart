import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/page/staff/selectedStaff.dart';
import 'package:hooa/widget/starRating.dart';

class ItemListStaff extends StatelessWidget {
  final Staff staff;

  ItemListStaff({@required this.staff});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeight = size.height * 0.00125;
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => SelectedStaffPage(staff: staff))),
      child: Container(
        height: unitHeight * 110,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor('#262626').withOpacity(0.3),
              width: 1
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            staff.image != null ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                File(staff.image),
                width: unitHeight * 100,
                height: unitHeight * 100,
                fit: BoxFit.fill,
              ),
            ) : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/images/photo_user.jpg",
                width: unitHeight * 100,
                height: unitHeight * 100,
                fit: BoxFit.fill,
              ),
            ),

            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        staff.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: unitHeight * 15,
                          color: HexColor('#262626')
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: Text(
                        staff.position,
                        style: TextStyle(
                          fontSize: unitHeight * 13,
                          color: HexColor('#262626').withOpacity(0.6)
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: StarRating(
                        rating: staff.rate,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
