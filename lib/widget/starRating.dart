import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StarRating extends StatelessWidget {
  final double size;
  final double rating;

  StarRating({
    this.size = 14,
    this.rating = .0
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    if (index > rating - 1) {
      icon = Icon(
        Icons.star_border,
        size: size,
        color: HexColor('#262626').withOpacity(0.3),
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size,
        color:  HexColor('#4E7D96'),
      );
    }
    return InkResponse(
      child: icon,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Row(
        children: List.generate(5, (index) => buildStar(context, index)),
      ),
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Text(
          rating.toString(),
          style: TextStyle(
            color: HexColor('#4E7D96'),
            fontSize: 15,
          ),
        ),
      ),
    ]);
  }
}