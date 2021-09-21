import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';

class ServicesPage extends StatelessWidget {
  Size size;
  double unitHeight;

  ServicesPage(BuildContext context) {
    BlocProvider.of<ServicesBloc>(context).add(GetServices());
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
  }

  @override
  Widget build(BuildContext context) {
    ServicesBloc bloc = BlocProvider.of<ServicesBloc>(context);
    bloc.add(GetServices());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Услуги',
        actions: [
          MyAction('assets/icons/add.svg',
                () => Navigator.of(context).pushNamed('/addService'),),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: BlocBuilder(
          bloc: BlocProvider.of<ServicesBloc>(context),
          builder: (context, ServicesState state) => ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              List<Service> services = state.services.where((element) =>
              element.categoryService == state.categories[index].id).toList();
              return DropDown(
                unitHeight: unitHeight,
                title: state.categories[index].name,
                list: List<Widget>.generate(services.length, (index) => GestureDetector(
                  onTap: () => _showModalBottomSheet(context, services[index]),
                  child: Container(
                    margin: EdgeInsets.only(bottom: unitHeight * 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor('#262626').withOpacity(0.3),
                          width: unitHeight * 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: unitHeight * 12),
                          child: Text(
                            services[index].name,
                            style: TextStyle(
                              fontSize: unitHeight * 15,
                            ),
                          ),
                        ),
                        Row(children: [
                          Text(
                            'Подробнее',
                            style: TextStyle(
                              fontSize: unitHeight * 13,
                              color: HexColor('#262626').withOpacity(0.6),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${services[index].price} BYN',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: unitHeight * 15,
                                ),
                              ),
                            ),
                          )
                        ],)
                      ],
                    ),
                  ),
                ),),
              );},
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, Service service) {
    Size size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    showModalBottomSheet(
      context: context,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                'Услуга',
                style: TextStyle(
                  fontSize: unitHeight * 34,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
              
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => _showModalChoice(context, service),
                    icon: SvgPicture.asset(
                      'assets/icons/service_change.svg',
                      height: unitHeight * 44,
                      width: unitHeight * 44,
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
              ),
            ],),

            Container(
              margin: EdgeInsets.only(
                top: unitHeight * 22,
                bottom: unitHeight * 30,
              ),
              child: Text(
                service.name,
                style: TextStyle(
                  fontSize: unitHeight * 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 8),
              child: Text(
                'Описание',
                style: TextStyle(
                  fontSize: unitHeight * 16,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 25),
              child: Text(
                service.description,
                style: TextStyle(
                  fontSize: unitHeight * 15,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 8),
              child: Text(
                'Стоимость и длительность',
                style: TextStyle(
                  fontSize: unitHeight * 16,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 25),
              child: Text(
                '${service.price} BYN',
                style: TextStyle(
                  fontSize: unitHeight * 15,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: unitHeight * 8),
              child: Text(
                'Длительность',
                style: TextStyle(
                  fontSize: unitHeight * 16,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#262626'),
                ),
              ),
            ),
            Container(
              child: Text(
                '~ ${service.time}',
                style: TextStyle(
                  fontSize: unitHeight * 15,
                  color: HexColor('#262626'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalChoice(BuildContext context, Service service) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                'Изменить',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: unitHeight * 20,
                ),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/changeService',
                arguments: service,
              ),
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Удалить',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: unitHeight * 20,
                ),
              ),
              onPressed: () => _showModalDeleteService(context, service.id),
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        elevation: 3,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) => Wrap(children: [
          ListTile(
            title: Text(
              'Изменить',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: unitHeight * 20,
              ),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              '/changeService',
              arguments: service,
            ),
          ),
          ListTile(
            title: Text(
              'Удалить',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: unitHeight * 20,
              ),
            ),
            onTap: () => _showModalDeleteService(context, service.id),
          ),
        ]),
      );
    }
  }

  Future<void> _showModalDeleteService(BuildContext context, int id) {
    return showDialog(
      context: context,
      barrierDismissible: true, //// user must tap button!
      builder: (context) => Container(
        height: unitHeight * 50,
        child: AlertDialog(
          elevation: 3,
          title: Text(
            'Удалить услугу',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: unitHeight * 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'При этом будет удалена вся информация об услуге',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: unitHeight * 14,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: unitHeight * 50,
                        width: size.width / 3 - 10,
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: HexColor("#FF844B")),
                          ),
                          color: Colors.white,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            BlocProvider.of<ServicesBloc>(context).add(DeleteService(id));
                            BlocProvider.of<ServicesBloc>(context).add(GetServices());
                            for(int i = 0; i < 3; i++) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Удалить",
                            style: TextStyle(
                              color: HexColor("#FF844B"),
                              fontSize: unitHeight * 15,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: unitHeight * 50,
                        width: size.width / 3 - 10,
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: HexColor("#FF844B"),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Отменить",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: unitHeight * 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}