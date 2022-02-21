import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/salesBloc.dart';
import 'package:hooa/model/Sale.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/page/user/SearchInstitution.dart';
import 'package:hooa/widget/MyAppBar.dart';

class SalesPage extends StatefulWidget {
  @override
  SalesPageState createState() => SalesPageState();
}

class SalesPageState extends State<SalesPage> {
  SalesBloc _salesBloc;
  Size size;
  double unitHeight;

  @override
  void initState() {
    super.initState();

    _salesBloc = BlocProvider.of<SalesBloc>(context);
    _salesBloc.add(GetSales());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: BlocBuilder(
          bloc: _salesBloc,
          builder: (context, state) {
            return Container(
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                children: List.generate(
                  state.sales.length,
                  (index) => CardSale(
                    institution: state.institutions[index],
                    sale: state.sales[index],
                    service: state.services[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return MyAppBar(
      showLeading: false,
      title: 'Каталог',
      actions: [
        MyAction(
          'assets/icons/search.svg',
          () => showSearch(
            context: context,
            delegate: SearchInstitutionDelegate(unitHeight: unitHeight),
          ),
        ),
        MyAction(
          'assets/icons/filter_black.svg',
          () => null,
        ),
      ],
    );
  }
}

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
    return Column(
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
        SizedBox(height: unitHeight * 8),
        Text(
          service.name,
          style: TextStyle(
            fontSize: unitHeight * 16,
            fontWeight: FontWeight.w600,
            color: HexColor('#262626'),
          ),
        ),
        SizedBox(height: unitHeight * 8),
        Text(
          institution.name,
          style:
              TextStyle(fontSize: unitHeight * 13, color: HexColor('#828282')),
        ),
        SizedBox(height: 8),
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
    );
  }
}
