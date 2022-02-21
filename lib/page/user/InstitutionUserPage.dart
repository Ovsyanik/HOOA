import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/calendar/table_calendar.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';

class InstitutionUserPage extends StatefulWidget {
  final Institution institution;

  InstitutionUserPage({this.institution});
  @override
  _InstitutionUserPage createState() => _InstitutionUserPage();
}

class _InstitutionUserPage extends State<InstitutionUserPage> {
  final _pageController = PageController();

  int currentIndex = 0;
  ServicesBloc _servicesBloc;

  @override
  void initState() {
    super.initState();

    _servicesBloc = BlocProvider.of<ServicesBloc>(context);
    _servicesBloc.add(GetServicesById(widget.institution.services));
    _pageController
        .addListener(() => currentIndex = _pageController.page.round());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unitHeight = size.height * 0.00125;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        actions: [
          MyAction(
            'assets/icons/add.svg',
            () => {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: unitHeight * 50,
            backgroundColor: HexColor('#E0E0E0'),
            child: widget.institution.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(widget.institution.image),
                      width: unitHeight * 100,
                      height: unitHeight * 100,
                      fit: BoxFit.fill,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/images/photo_user.jpg",
                      width: unitHeight * 100,
                      height: unitHeight * 100,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),

          SizedBox(height: unitHeight * 6),

          Text(
            widget.institution.name,
            style: TextStyle(
              fontSize: unitHeight * 17,
              color: HexColor('#262626'),
            ),
          ),

          SizedBox(height: unitHeight * 4),

          // Text(
          //   widget.staff.position,
          //   style: TextStyle(
          //     fontSize: unitHeight * 14,
          //     color: HexColor('#262626').withOpacity(0.3),
          //   ),
          // ),

          SizedBox(height: unitHeight * 4),

          //переделать
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     StarRating(
          //       size: unitHeight * 17,
          //       rating: widget.institution.rate,
          //     ),
          //   ],
          // ),

          SizedBox(height: unitHeight * 4),

          // GestureDetector(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SvgPicture.asset(
          //         'assets/icons/phone.svg',
          //         height: unitHeight * 14,
          //         width: unitHeight * 14,
          //       ),
          //       Text(
          //         widget.staff.numberPhone,
          //         style: TextStyle(
          //           fontSize: unitHeight * 14,
          //           color: HexColor('#262626'),
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () => null,
          // ),

          SizedBox(height: unitHeight * 4),

          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     text: 'Редактировать',
          //     style: TextStyle(
          //       fontSize: unitHeight * 13,
          //       color: HexColor("#4E7D96"),
          //     ),
          //     recognizer: TapGestureRecognizer()
          //       ..onTap = () => Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => ChangeStaff(staff: widget.staff),
          //             ),
          //           ),
          //   ),
          // ),

          SizedBox(height: unitHeight * 4),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: unitHeight * 38,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: currentIndex == 0
                            ? HexColor("#FF844B")
                            : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () =>
                            setState(() => _pageController.jumpToPage(0)),
                        child: Text(
                          "Режим работы",
                          style: TextStyle(
                            color: currentIndex == 0
                                ? Colors.white
                                : HexColor("#262626"),
                            fontSize: unitHeight * 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: unitHeight * 38,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: currentIndex == 1
                            ? HexColor("#FF844B")
                            : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () =>
                            setState(() => _pageController.jumpToPage(1)),
                        child: Text(
                          "Услуги",
                          style: TextStyle(
                            color: currentIndex == 1
                                ? Colors.white
                                : HexColor("#262626"),
                            fontSize: unitHeight * 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: unitHeight * 38,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: currentIndex == 2
                            ? HexColor("#FF844B")
                            : HexColor("#F2F2F2"),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () =>
                            setState(() => _pageController.jumpToPage(2)),
                        child: Text(
                          'Отзывы',
                          style: TextStyle(
                            color: currentIndex == 2
                                ? Colors.white
                                : HexColor("#262626"),
                            fontSize: unitHeight * 13,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PageView(
                controller: _pageController,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 25),
                      width: size.width - 100,
                      child: TableCalendar(
                        selectedDay: DateTime.now(),
                        firstDay: DateTime.utc(2020, 10, 16),
                        lastDay: DateTime.utc(
                          DateTime.now().year + 2,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        focusedDay: DateTime.now(),
                        // selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                        // onDaySelected: _onDaySelected,
                        // onPageChanged: (focusedDay) {
                        //   _focusedDay = focusedDay;
                        // },
                      ),
                    ),
                  ),
                  Center(
                    child: BlocBuilder(
                      bloc: BlocProvider.of<ServicesBloc>(context),
                      builder: (context, ServicesState state) =>
                          ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          List<Service> services = state.services
                              .where((element) =>
                                  element.categoryService ==
                                  state.categories[index].id)
                              .toList();
                          return DropDown(
                            unitHeight: unitHeight,
                            title: state.categories[index].name,
                            list: List<Widget>.generate(
                              services.length,
                              (index) => GestureDetector(
                                onTap: () => _showModalBottomSheet(
                                    context, services[index]),
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: unitHeight * 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: HexColor('#262626')
                                            .withOpacity(0.3),
                                        width: unitHeight * 1,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: unitHeight * 12),
                                        child: Text(
                                          services[index].name,
                                          style: TextStyle(
                                            fontSize: unitHeight * 15,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Подробнее',
                                            style: TextStyle(
                                              fontSize: unitHeight * 13,
                                              color: HexColor('#262626')
                                                  .withOpacity(0.6),
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
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(child: Text('$currentIndex')),
                ],
                onPageChanged: (index) =>
                    setState(() => _pageController.jumpToPage(index)),
              ),
            ),
          ),
        ],
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
            Row(
              children: [
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
                      //доделать
                      onPressed: () => null,
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
              ],
            ),
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
}