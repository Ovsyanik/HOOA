import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/statisticBloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData('David', 43, HexColor('#828282')),
    ChartData('Jack', 61, HexColor('#BDBDBD')),
    ChartData('Steve', 151, HexColor('#E0E0E0')),
  ];

  StatisticBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    bloc = BlocProvider.of<StatisticBloc>(context);
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
                fontSize: size.height * 0.0013 * 34,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  height: size.height * 0.0015 * 38,
                  width: size.width / 3 - 24,
                  child: StreamBuilder<Object>(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      return MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: snapshot.data == 0 ? HexColor("#FF844B") : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => bloc.selectButton(0),
                        child: Text(
                          "1 неделя",
                          style: TextStyle(
                            color: snapshot.data == 0 ? Colors.white : HexColor("#262626"),
                            fontSize: size.height * 0.0013 * 15,
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  height: size.height * 0.0015 * 38,
                  width: size.width / 3 - 24,
                  child: StreamBuilder<Object>(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      return MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: snapshot.data == 1 ? HexColor("#FF844B") : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => bloc.selectButton(1),
                        child: Text(
                          "2 недели",
                          style: TextStyle(
                            color: snapshot.data == 1 ? Colors.white : HexColor("#262626"),
                            fontSize: size.height * 0.0013 * 15,
                          ),
                        ),
                      );
                    }
                  ),
                ),

                Container(
                  height: size.height * 0.0015 * 38,
                  width: size.width / 3 - 24,
                  child: StreamBuilder<Object>(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      return MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: snapshot.data == 2 ? HexColor("#FF844B") : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => bloc.selectButton(2),
                        child: Text(
                          "1 месяц",
                          style: TextStyle(
                            color: snapshot.data == 2 ? Colors.white : HexColor("#262626"),
                            fontSize: size.height * 0.0013 * 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.14),
            height: size.height * 0.1,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  pointColorMapper: (ChartData data, _) => data.color,
                  radius: '${size.height * 0.11}',
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.11, left: 13),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: HexColor('#828282'),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text(
                    '43 - количество отмененных заказов',
                    style: TextStyle(
                      fontSize: size.height * 0.0013 * 17,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.03, left: 13),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('#BDBDBD'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text(
                    '151 - количество заказов',
                    style: TextStyle(
                      fontSize: size.height * 0.0013 * 17,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.03, left: 13),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('#E0E0E0'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text(
                    '61 - количество просмотров',
                    style: TextStyle(
                      fontSize: size.height * 0.0013 * 17,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, [this.color]);
}