import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/widget/starRating.dart';

class ItemListStaff extends StatelessWidget {
  final Staff staff;

  ItemListStaff({@required this.staff});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeight = size.height * 0.00125;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/selectedStaff'),
      child: Container(
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
            Expanded(
              child: ClipRRect(
                child: staff.image,
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
