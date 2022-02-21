import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/statisticBloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StatisticPage extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData('David', 43, HexColor('#828282')),
    ChartData('Jack', 61, HexColor('#BDBDBD')),
    ChartData('Steve', 151, HexColor('#E0E0E0')),
  ];

  StatisticBloc bloc;
  Size size;
  double unitHeight;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    bloc = BlocProvider.of<StatisticBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Text(
              'Статистика',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: unitHeight * 34,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildListButton(),
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
                      fontSize: unitHeight * 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.03, left: 13),
            child: Row(children: [
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
                    fontSize: unitHeight * 17,
                  ),
                ),
              ),
            ]),
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
                      fontSize: unitHeight * 17,
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

  List<Container> _buildListButton() {
    List<String> titleButtons = ['1 неделя', '2 недели', '1 месяц'];

    return List.generate(
      3,
      (index) => Container(
        height: size.height * 0.0015 * 38,
        width: size.width / 3 - 24,
        child: StreamBuilder<Object>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return MaterialButton(
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: snapshot.data == index
                  ? HexColor("#FF844B")
                  : HexColor("#F2F2F2"),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => bloc.selectButton(index),
              child: Text(
                titleButtons[index],
                style: TextStyle(
                  color:
                      snapshot.data == 0 ? Colors.white : HexColor("#262626"),
                  fontSize: unitHeight * 15,
                ),
              ),
            );
          },
        ),
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
