import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/model/Sale.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/page/sales/ChangeSalePage.dart';

class CardSale extends StatelessWidget {
  final Sale sale;
  final Institution institution;
  final Service service;

  CardSale({
    this.institution,
    this.sale,
    this.service,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.001225;
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(textDirection: TextDirection.rtl, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(unitHeight * 10),
              child: Image.network(
                'https://open.zeba.academy/wp-content/uploads/2020/05/kak-poluchit-dannye-interneta-1024x576.png',
                width: size.width - 32,
                height: unitHeight * 122,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: unitHeight * 22,
              width: 49,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Text(
                '-${sale.count}%',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ),
          ]),
          SizedBox(
            height: unitHeight * 8,
          ),
          Text(
            service.name,
            style: TextStyle(
              fontSize: unitHeight * 16,
              fontWeight: FontWeight.w600,
              color: HexColor('#262626'),
            ),
          ),
          SizedBox(
            height: unitHeight * 8,
          ),
          Text(
            institution.name,
            style: TextStyle(
                fontSize: unitHeight * 13, color: HexColor('#828282')),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                height: unitHeight * 24,
                width: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor('#FF844B'),
                ),
                child: Text(
                  '${int.parse(service.price) * (1 - (sale.count / 100))} BYN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: unitHeight * 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '  ${service.price} BYN',
                style: TextStyle(
                  fontSize: unitHeight * 13,
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChangeSalePage(sale: sale))),
    );
  }
}
