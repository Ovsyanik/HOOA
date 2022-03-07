import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/dropDown/ExpandedListAnimationWidget.dart';

class FilterUser extends StatefulWidget {
  @override
  _FilterUserState createState() => _FilterUserState();
}

class _FilterUserState extends State<FilterUser> {
  FilterUserResult result = FilterUserResult();

  ServicesBloc _categoryServiceBloc;

  Size size;
  double unitHeight;

  //change bottom color in out SafeArea
  @override
  void initState() {
    super.initState();

    _categoryServiceBloc = BlocProvider.of<ServicesBloc>(context);
    _categoryServiceBloc.add(GetServices());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return Padding(
      padding: EdgeInsets.only(top: unitHeight * 15),
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/icons/indicator_modal.svg',
              color: HexColor("#262626"),
              height: unitHeight * 4,
              width: unitHeight * 20,
            ),
          ),
          SizedBox(height: unitHeight * 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: unitHeight * 16),
            child: DropDown(
              title: 'Сортировать по',
              unitHeight: unitHeight,
              body: _buildSortButtons(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: unitHeight * 16),
            child: DropDown(
              title: 'Тип',
              unitHeight: unitHeight,
              body: _buildTypeButtons(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: unitHeight * 16),
            child: DropDown(
              title: 'Услуги',
              unitHeight: unitHeight,
              body: _buildCategoryButtons(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: unitHeight * 16),
            child: DropDown(
              title: 'Стоимость',
              unitHeight: unitHeight,
              body: _buildRangeSlider(),
            ),
          ),
          _buildBottomButtonsOnFilter()
        ],
      ),
    );
  }

  Widget _buildSortButtons() {
    List<String> titles = ['Популярности', 'С высоких рейтингом'];

    return Row(
      children: List.generate(2, (index) {
        return Container(
          height: unitHeight * 30,
          margin: EdgeInsets.only(right: unitHeight * 16),
          child: MaterialButton(
            elevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: result.selectedSortIndex == index
                ? HexColor("#FF844B")
                : HexColor("#F2F2F2"),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => setState(() => result.selectedSortIndex = index),
            child: Text(
              titles[index],
              style: TextStyle(
                color: result.selectedSortIndex == index
                    ? Colors.white
                    : HexColor("#262626"),
                fontSize: unitHeight * 13,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTypeButtons() {
    List<String> titles = ['Парикмахерская', 'Барбершоп'];

    return Row(
      children: List.generate(2, (index) {
        return Container(
          height: unitHeight * 30,
          margin: EdgeInsets.only(right: unitHeight * 16),
          child: MaterialButton(
            elevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: result.selectedTypeIndex == index
                ? HexColor("#FF844B")
                : HexColor("#F2F2F2"),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => setState(() => result.selectedTypeIndex = index),
            child: Text(
              titles[index],
              style: TextStyle(
                color: result.selectedTypeIndex == index
                    ? Colors.white
                    : HexColor("#262626"),
                fontSize: unitHeight * 13,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryButtons() {
    return BlocBuilder(
      bloc: _categoryServiceBloc,
      builder: (context, ServicesState state) {
        return Wrap(
          spacing: unitHeight * 20,
          runSpacing: unitHeight * 16,
          children: List.generate(state.categories.length, (index) {
            String categoryName = state.categories[index].name;
            return Container(
              height: unitHeight * 30,
              child: MaterialButton(
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: result.selectedCategory == categoryName
                    ? HexColor("#FF844B")
                    : HexColor("#F2F2F2"),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () =>
                    setState(() => result.selectedCategory = categoryName),
                child: Text(
                  state.categories[index].name,
                  style: TextStyle(
                    color: result.selectedCategory == categoryName
                        ? Colors.white
                        : HexColor("#262626"),
                    fontSize: unitHeight * 13,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildRangeSlider() {
    TextStyle textStyle = TextStyle(
      color: HexColor('#262626').withOpacity(0.6),
      fontSize: unitHeight * 12,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'от ${result.rangeValues.start.round()} BYN',
              style: textStyle,
            ),
            Text(
              'от ${result.rangeValues.end.round()} BYN',
              style: textStyle,
            ),
          ],
        ),
        RangeSlider(
          values: result.rangeValues,
          activeColor: HexColor("#FF844B"),
          inactiveColor: HexColor("#F2F2F2"),
          max: 100,
          onChanged: (RangeValues values) =>
              setState(() => result.rangeValues = values),
        ),
        SizedBox(height: unitHeight * 10),
      ],
    );
  }

  Widget _buildBottomButtonsOnFilter() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: HexColor('#262626').withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Button(
            text: 'Сбросить',
            color: HexColor("#F8F7F4"),
            textColor: HexColor("#FF844B"),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            text: 'Применить',
            onPressed: () => Navigator.pop(context, result),
          ),
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final String title;
  final double unitHeight;
  final Widget body;

  DropDown({
    this.title,
    this.unitHeight,
    this.body,
  });

  @override
  _DropDownState createState() => new _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool isStreched = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                setState(() => isStreched = !isStreched),
                            child: Row(children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: widget.unitHeight * 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                isStreched
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    ExpandedSection(
                      expand: isStreched,
                      height: 100,
                      child: widget.body,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class FilterUserResult {
  int selectedSortIndex = 0;
  int selectedTypeIndex = 0;
  String selectedCategory;
  RangeValues rangeValues = const RangeValues(40, 80);
}
