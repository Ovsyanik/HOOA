import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/CardBloc.dart';
import 'package:hooa/bloc/recordsBloc.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/record.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/CheckBox.dart';
import 'package:hooa/widget/ItemListCard.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/calendar/shared/utils.dart';
import 'package:hooa/widget/calendar/table_calendar.dart';
import 'package:hooa/widget/dropDown/DropDown.dart';
import 'package:hooa/widget/dropDown/ExpandedListAnimationWidget.dart';
import 'package:hooa/widget/starRating.dart';
import 'package:hooa/widget/stepper/stepper.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

class AddRecordPage extends StatefulWidget {
  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  PaymentMethod _paymentMethod = PaymentMethod.Cash;
  Map<Service, bool> selectedService = Map<Service, bool>();
  Map<Staff, bool> selectedStaff = Map<Staff, bool>();

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate;
  DateTime selectedDate;
  StaffBloc _staffBloc;
  CardBloc _cardBloc;
  RecordsBloc _recordsBloc;

  String _selectedTime;

  GroupButtonController morningController;
  GroupButtonController dinnerController;
  GroupButtonController eveningController;
  TextEditingController clientController;

  Size size;
  double unitHeight;
  int currentStep = 0;
  int totalPrice = 0;
  List<bool> canContinues = [false, false, true];
  Institution institution;

  @override
  void initState() {
    super.initState();

    _staffBloc = BlocProvider.of<StaffBloc>(context);
    _cardBloc = BlocProvider.of<CardBloc>(context);
    _recordsBloc = BlocProvider.of<RecordsBloc>(context);
    institution = BlocProvider.of<SignUpBloc>(context).institution;

    _staffBloc.add(GetStaff());
    _cardBloc.add(GetCards());

    morningController = new GroupButtonController();
    dinnerController = new GroupButtonController();
    eveningController = new GroupButtonController();

    clientController = new TextEditingController();

    _selectedDate = _focusedDay;
    selectedDate = _selectedDate;
  }

  @override
  void dispose() {
    morningController.dispose();
    dinnerController.dispose();
    eveningController.dispose();
    clientController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    canContinues[0] = selectedService.values.contains(true);
    canContinues[1] = _selectedTime != null;
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Запись',
        actions: [
          MyAction(
            'assets/icons/call.svg',
            () => null,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16.0),
        child: CupertinoStepper(
          currentStep: currentStep,
          buttonText: const ['Продолжить', 'Продолжить', 'Сохранить'],
          onButtonPressed: [
            canContinues[0] ? () => setState(() => ++currentStep) : null,
            canContinues[1] ? () => setState(() => ++currentStep) : null,
            () => _showModalSave()
          ],
          steps: _getSteps(),
        ),
      ),
    );
  }

  List<Step> _getSteps() {
    Map<String, Widget> steps = {
      'Выбор услуг': _getDropDownService(),
      'Дата и мастер': _getDateAndMaster(),
      'Оформление': _getRegistration()
    };

    return List.generate(
      steps.length,
      (index) => Step(
        title: Text(
          steps.keys.elementAt(index),
          style: TextStyle(
            fontSize: 15,
            color: HexColor('#262626').withOpacity(0.6),
          ),
        ),
        content: Container(
          height: double.infinity,
          width: double.infinity,
          child: steps.values.elementAt(index),
        ),
      ),
    );
  }

  Widget _getDropDownService() {
    return BlocBuilder(
      bloc: BlocProvider.of<ServicesBloc>(context),
      builder: (context, ServicesState state) => ListView.builder(
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          List<Service> services = state.services
              .where((element) =>
                  element.categoryService == state.categories[index].id)
              .toList();
          if (selectedService.isEmpty) {
            for (int i = 0; i < services.length; i++) {
              selectedService.putIfAbsent(services[i], () => false);
            }
          }
          return DropDown(
            unitHeight: unitHeight,
            title: state.categories[index].name,
            list: List<Widget>.generate(
              services.length,
              (index) => _getItemDropdown(services[index], index,
                  selectedService[selectedService.keys.elementAt(index)]),
            ),
          );
        },
      ),
    );
  }

  Widget _getItemDropdown(Service service, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedService[selectedService.keys.elementAt(index)] =
            !selectedService[selectedService.keys.elementAt(index)];
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: unitHeight * 16),
        width: unitHeight * 1,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: HexColor('#262626').withOpacity(0.5)),
          ),
        ),
        child: Row(
          children: [
            Text(
              service.name,
              style: TextStyle(fontSize: unitHeight * 15),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: CheckBox(isSelected: isSelected),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDateAndMaster() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Дата',
                      style: TextStyle(
                        fontSize: unitHeight * 16.0,
                        color: HexColor('#262626'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      height: unitHeight * 32,
                      width: unitHeight * 20,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => null,
                  ),
                ],
              ),
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setMyState) {
                void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
                  if (!isSameDay(_selectedDate, selectedDay)) {
                    setMyState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                }

                return TableCalendar(
                  selectedDay: selectedDate,
                  firstDay: DateTime.utc(2020, 10, 16),
                  lastDay: DateTime.utc(
                    DateTime.now().year + 2,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                );
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: unitHeight * 16),
              child: Text(
                'Мастера',
                style: TextStyle(
                  color: HexColor('#262626'),
                  fontSize: unitHeight * 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: BlocBuilder(
                bloc: _staffBloc,
                builder: (context, state) {
                  if (selectedStaff.isEmpty) {
                    for (int i = 0; i < state.staff.length; i++) {
                      this
                          .selectedStaff
                          .putIfAbsent(state.staff[i], () => false);
                    }
                  }
                  return Container(
                    height: 600,
                    margin: EdgeInsets.only(bottom: unitHeight * 70),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.staff.length,
                        itemBuilder: (context, index) => _getItemListStaff(
                          selectedStaff.entries.elementAt(index).key,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getItemListStaff(Staff staff) {
    BoxBorder boxBorder = Border(
      bottom: BorderSide(
        color: HexColor('#262626').withOpacity(0.3),
        width: 1,
      ),
    );
    return Container(
      decoration: this.selectedStaff[staff]
          ? BoxDecoration(border: boxBorder)
          : BoxDecoration(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              selectedStaff[staff] = !selectedStaff[staff];
            }),
            child: Container(
              decoration: selectedStaff[staff] == false
                  ? BoxDecoration(border: boxBorder)
                  : BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  staff.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(
                            File(staff.image),
                            width: unitHeight * 50,
                            height: unitHeight * 50,
                            fit: BoxFit.fill,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            "assets/images/photo_user.jpg",
                            width: unitHeight * 50,
                            height: unitHeight * 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              staff.fullName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: unitHeight * 15,
                                color: HexColor('#262626'),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 8),
                            child: Text(
                              staff.position,
                              style: TextStyle(
                                fontSize: unitHeight * 13,
                                color: HexColor('#262626').withOpacity(0.6),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 8),
                            child: StarRating(
                              rating: staff.rate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CheckBox(
                    isSelected: selectedStaff[staff],
                  ),
                ],
              ),
            ),
          ),
          ExpandedSection(
            expand: selectedStaff[staff],
            height: 100,
            child: OverflowBox(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Выберите доступное время: ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: HexColor('#262626').withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: unitHeight * 12, bottom: unitHeight * 4),
                    child: Text(
                      'утро',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor('#262626').withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Center(child: _getFreeTimeForMorning()),
                  Container(
                    margin: EdgeInsets.only(
                        top: unitHeight * 12, bottom: unitHeight * 4),
                    child: Text(
                      'день',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor('#262626').withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Center(child: _getFreeTimeForDinner()),
                  Container(
                    margin: EdgeInsets.only(
                        top: unitHeight * 12, bottom: unitHeight * 4),
                    child: Text(
                      'вечер ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: HexColor('#262626').withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Center(child: _getFreeTimeForEvening()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getFreeTimeForMorning() {
    List<String> buttons = const ['8:00', '9:00', '10:00', '11:00'];

    morningController.selectIndex(buttons.indexOf(_selectedTime));

    return GroupButton(
      buttons: buttons,
      controller: morningController,
      direction: Axis.horizontal,
      selectedBorderColor: HexColor('#FF844B'),
      unselectedBorderColor: HexColor('#e9e9e9'),
      selectedColor: HexColor('#FF844B'),
      unselectedColor: HexColor('#e9e9e9'),
      selectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: Colors.white,
      ),
      unselectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: HexColor('#262626'),
      ),
      onSelected: (index, isSelected) => setState(() {
        _selectedTime = buttons[index];
      }),
      buttonHeight: unitHeight * 28,
      buttonWidth: size.width * 0.00275 * 73,
      borderRadius: BorderRadius.circular(50),
    );
  }

  Widget _getFreeTimeForDinner() {
    List<String> buttons = const ['12:00', '13:00', '14:00', '15:00'];

    dinnerController.selectIndex(buttons.indexOf(_selectedTime));

    return GroupButton(
      controller: dinnerController,
      buttons: buttons,
      mainGroupAlignment: MainGroupAlignment.spaceBetween,
      isRadio: true,
      direction: Axis.horizontal,
      selectedBorderColor: HexColor('#FF844B'),
      unselectedBorderColor: HexColor('#e9e9e9'),
      selectedColor: HexColor('#FF844B'),
      unselectedColor: HexColor('#e9e9e9'),
      selectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: Colors.white,
      ),
      unselectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: HexColor('#262626'),
      ),
      onSelected: (index, isSelected) {
        _selectedTime = buttons[index];
        setState(() {
          _selectedTime = buttons[index];
        });
      },
      buttonHeight: unitHeight * 28,
      buttonWidth: size.width * 0.00275 * 73,
      borderRadius: BorderRadius.circular(50),
    );
  }

  Widget _getFreeTimeForEvening() {
    List<String> buttons = const ['16:00', '17:00', '18:00', '19:00'];

    eveningController.selectIndex(buttons.indexOf(_selectedTime));

    return GroupButton(
      controller: eveningController,
      buttons: buttons,
      direction: Axis.horizontal,
      selectedBorderColor: HexColor('#FF844B'),
      unselectedBorderColor: HexColor('#e9e9e9'),
      selectedColor: HexColor('#FF844B'),
      unselectedColor: HexColor('#e9e9e9'),
      selectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: Colors.white,
      ),
      unselectedTextStyle: TextStyle(
        fontSize: unitHeight * 13,
        color: HexColor('#262626'),
      ),
      onSelected: (index, isSelected) => setState(() {
        _selectedTime = buttons[index];
        print(_selectedTime);
      }),
      buttonHeight: unitHeight * 28,
      buttonWidth: size.width * 0.00275 * 73,
      borderRadius: BorderRadius.circular(50),
    );
  }

  Widget _getRegistration() {
    List<Service> _services = [];
    totalPrice = 0;
    for (int i = 0; i < selectedService.length; i++) {
      Service service = selectedService.keys.elementAt(i);
      if (selectedService[service] == true) {
        totalPrice += int.parse(service.price);
        _services.add(service);
      }
    }
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Клиент:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: unitHeight * 2),
              width: double.infinity,
              height: unitHeight * 50,
              child: TextField(
                controller: this.clientController,
                decoration: InputDecoration(
                  hintText: "Имя клиента",
                  hintStyle: TextStyle(
                    fontSize: unitHeight * 15,
                    color: HexColor("#4D262626"),
                  ),
                ),
              ),
            ),
            SizedBox(height: unitHeight * 12),
            Text(
              'Дата и время',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626'),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/clock.svg',
                color: HexColor("#262626"),
                height: unitHeight * 25,
                width: unitHeight * 25,
              ),
              contentPadding: EdgeInsets.all(0),
              title: Align(
                alignment: Alignment(-1.2, 0),
                child: Text(
                  "${DateFormat.MMMMd('ru-RU').format(_selectedDate)} $_selectedTime",
                  style: TextStyle(
                    fontSize: unitHeight * 15,
                    color: HexColor('#262626'),
                  ),
                ),
              ),
            ),
            Text(
              'Мастер',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626'),
              ),
            ),
            SizedBox(height: unitHeight * 6),
            Text(
              selectedStaff.containsValue(true)
                  ? selectedStaff.entries
                      .firstWhere((element) => element.value == true)
                      .key
                      .fullName
                  : "",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                color: HexColor('#262626'),
              ),
            ),
            SizedBox(height: unitHeight * 12),
            Text(
              'Способ оплаты',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: unitHeight * 16),
              child: Column(
                children: <Widget>[
                  ItemListCardChecked(
                    leading: 'assets/icons/money.svg',
                    title: "Наличные",
                    unitHeight: unitHeight,
                    value: PaymentMethod.Cash,
                    groupValue: _paymentMethod,
                    //доделать
                    onTap: (Object value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                  ),
                  ItemListCardChecked(
                    leading: 'assets/icons/paypal.svg',
                    title: "Apple Pay",
                    unitHeight: unitHeight,
                    value: PaymentMethod.ApplePay,
                    groupValue: _paymentMethod,
                    //доделать
                    onTap: (PaymentMethod value) {
                      setState(() => _paymentMethod = value);
                    },
                  ),
                  ItemListCard(
                    title: "Новая карта",
                    unitHeight: unitHeight,
                    onTap: () async =>
                        await Navigator.pushNamed(context, "/addNewCard"),
                  ),
                  BlocBuilder(
                    bloc: _cardBloc,
                    builder: (context, state) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.cards.length,
                        itemBuilder: (context, index) {
                          return ItemListCard(
                            onTap: () => {},
                            unitHeight: unitHeight,
                            title: getTypeCard(state.cards[index].number) +
                                getLastNumberCard(state.cards[index].number),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Text(
              'Cумма',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: unitHeight * 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#262626'),
              ),
            ),
            SizedBox(height: unitHeight * 12),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _services.length,
              itemBuilder: (_, index) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: HexColor('#262626').withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          _services[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: unitHeight * 15,
                            color: HexColor('#262626'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${_services[index].price} BYN",
                      style: TextStyle(
                        fontSize: unitHeight * 15,
                        color: HexColor("#262626"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: unitHeight * 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Итого',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: unitHeight * 16,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#262626'),
                  ),
                ),
                Text(
                  '$totalPrice BYN',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: unitHeight * 22,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#262626'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getLastNumberCard(String num) => num.split(' ')[3];

  String getTypeCard(String num) {
    switch (num.split(' ')[0][0]) {
      case '4':
        return 'Visa ';
        break;
      case '5':
        return 'MasterCard ';
        break;
      default:
        return null;
    }
  }

  Future<void> _showModalSave() {
    return clientController.text.isNotEmpty
        ? showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(unitHeight * 30.0),
              ),
              contentPadding: EdgeInsets.all(unitHeight * 15),
              content: Container(
                width: size.width - 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/union.svg',
                          width: unitHeight * 20,
                          height: unitHeight * 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: unitHeight * 16),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/calendar_done.svg',
                        width: unitHeight * 85,
                        height: unitHeight * 85,
                      ),
                    ),
                    SizedBox(height: unitHeight * 16),
                    Text(
                      '${clientController.text}, записана в\n ${institution.name}:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: unitHeight * 14,
                        color: HexColor("#262626").withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: unitHeight * 16),
                    Text(
                      '${DateFormat.EEEE('ru-RU').format(_selectedDate)}, ${DateFormat.MMMMd('ru-RU').format(_selectedDate)} в $_selectedTime',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: unitHeight * 24,
                        fontWeight: FontWeight.w600,
                        color: HexColor("#262626"),
                      ),
                    ),
                    SizedBox(height: unitHeight * 32),
                    Button(
                      text: "Ок",
                      width: 0.35 * size.width,
                      onPressed: () {
                        List<int> _services = [];
                        for (int i = 0; i < selectedService.length; i++) {
                          Service service = selectedService.keys.elementAt(i);
                          if (selectedService[service] == true) {
                            _services.add(service.id);
                          }
                        }
                        Record record = new Record(
                          services: _services,
                          client: clientController.text,
                          master: selectedStaff.entries
                              .firstWhere((element) => element.value == true)
                              .key
                              .id,
                          dateTime: DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            int.parse(_selectedTime.split(":")[0]),
                            int.parse(_selectedTime.split(":")[1]),
                          ),
                          price: "$totalPrice BYN",
                        );
                        _recordsBloc.add(AddRecord(record));
                        for (int i = 0; i < 2; i++) Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        : null;
  }
}

enum PaymentMethod { Cash, ApplePay }

class ItemListCardChecked extends StatelessWidget {
  final double unitHeight;
  final String leading;
  final double height;
  final String title;
  final Function onTap;
  final PaymentMethod groupValue;
  final PaymentMethod value;

  ItemListCardChecked({
    @required this.title,
    @required this.unitHeight,
    @required this.onTap,
    @required this.groupValue,
    @required this.value,
    this.height = 55.0,
    this.leading,
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
      child: ListTile(
        leading: SvgPicture.asset(
          leading,
          color: HexColor("#262626"),
          height: unitHeight * 25,
          width: unitHeight * 25,
        ),
        trailing: Radio<PaymentMethod>(
          value: value,
          groupValue: groupValue,
          onChanged: this.onTap,
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
    );
  }
}
