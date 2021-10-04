import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/bloc/salesBloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/page/sales/AddSalesPage.dart';
import 'package:hooa/widget/CardSales.dart';
import 'package:hooa/widget/MyAppBar.dart';

class SalesPage extends StatefulWidget{
  final Institution institution;

  SalesPage({
    this.institution
  });

  @override
  SalesPageState createState() => SalesPageState();
}

class SalesPageState extends State<SalesPage> {
  SalesBloc _salesBloc;


  @override
  void initState() {
    super.initState();
    _salesBloc = BlocProvider.of<SalesBloc>(context);
    _salesBloc.add(GetSales());
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: MyAppBar(
        title: 'Скидки',
        actions: [
          MyAction('assets/icons/settings.svg',
                () => Navigator.pushNamed(context, "/changeProfileInstitution"),
          ),
          MyAction('assets/icons/add.svg',
                () => Navigator.push(context, MaterialPageRoute(builder:
                    (context) => AddSalesPage(institution: widget.institution))),
          ),
        ],
      ),
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
                children: List.generate(state.sales.length, (index) => CardSale(
                  institution: widget.institution,
                  sale: state.sales[index],
                  service: state.services[index],
                ),),
              ),
            );
          },
        ),
      ),
    );
  }

}