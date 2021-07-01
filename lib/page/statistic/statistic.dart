import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData('David', 43, HexColor('#828282')),
    ChartData('Jack', 61, HexColor('#BDBDBD')),
    ChartData('Steve', 151, HexColor('#E0E0E0')),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Text(
              'Статистика',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 34,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Row(
              children: <Widget>[

              ],
            ),
          ),

          Container(
              // margin: EdgeInsets.only(top: size.height * 0.1),
              height: 200,
              child: SfCircularChart(
                  series: <CircularSeries>[
                // Render pie chart
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      radius: '100'
                    )
                  ]
              )
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Row(
              children: [

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Row(
              children: [

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Row(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}