import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemListCard extends StatelessWidget {
  final double unitHeight;
  final double height;
  final String title;
  final Function onTap;

  ItemListCard({
    @required this.title,
    @required this.unitHeight,
    this.height = 55.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: unitHeight * height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: HexColor('#C6C6C8').withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: this.onTap,
        child: ListTile(
          leading: SvgPicture.asset(
            'assets/icons/credit-card.svg',
            color: HexColor("#262626"),
            height: unitHeight * 25,
            width: unitHeight * 25,
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow.svg',
            color: HexColor("#262626"),
            height: unitHeight * 15,
            width: unitHeight * 15,
          ),
          contentPadding: EdgeInsets.all(0),
          title: Align(
            alignment: Alignment(-1.2, 0),
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: unitHeight * 17,
                color: HexColor('#262626'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}