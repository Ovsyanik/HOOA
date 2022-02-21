import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/InstitutionBloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/page/user/InstitutionUserPage.dart';
import 'package:hooa/page/user/SearchInstitution.dart';
import 'package:hooa/widget/MyAppBar.dart';

class ListInstitutionPage extends StatefulWidget {
  @override
  _ListInstitutionPage createState() => _ListInstitutionPage();
}

class _ListInstitutionPage extends State<ListInstitutionPage> {
  InstitutionBloc _institutionBloc;

  Size size;
  double unitHeight;

  @override
  void initState() {
    super.initState();

    _institutionBloc = BlocProvider.of<InstitutionBloc>(context);
    _institutionBloc.add(GetInstitution());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: MyAppBar(
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
            () => _getFilterDialog(),
          ),
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          child: BlocBuilder(
            bloc: _institutionBloc,
            builder: _getBuilder,
          ),
        ),
      ),
    );
  }

  Widget _getBuilder(BuildContext context, InstitutionState state) {
    //сделать чтобы выбивать ошибку
    if (state.institutions.isEmpty) return Container();

    List<Institution> _getInstitutions(String type) =>
        state.institutions.where((element) => element.type == type).toList();

    return Column(
      children: [
        _getContainer(_getInstitutions("Парикмахерская"), "Избранное"),
        _getContainer(_getInstitutions("Парикмахерская"), "Парикмахерские"),
        _getContainer(_getInstitutions("Барбершоп"), "Барбершопы"),
      ],
    );
  }

  Widget _getContainer(List<Institution> institutions, String title) {
    if (institutions.isEmpty) return Container();
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: unitHeight * 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: unitHeight * 8),
        GridView.count(
          crossAxisCount: 3,
          primary: false,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          children: List.generate(
            institutions.length,
            (index) => Container(
              child: null,
            ),
          ),
        ),
      ],
    );
  }

  _getFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Column(
          children: [
            SizedBox(height: unitHeight * 10),
          ],
        );
      },
    );
  }
}

class InstitutionBlock extends StatelessWidget {
  final Institution institution;
  final bool isSelected;

  InstitutionBlock({this.institution, this.isSelected});

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
            // Container(
            //   margin: EdgeInsets.all(8),
            //   height: unitHeight * 22,
            //   width: 49,
            //   padding: EdgeInsets.symmetric(vertical: 2),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(25),
            //     color: Colors.white,
            //   ),
            //   child: Text(
            //     '-${sale.count}%',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(),
            //   ),
            // ),
          ]),
          SizedBox(
            height: unitHeight * 4,
          ),
          Text(
            institution.name,
            style: TextStyle(
              fontSize: unitHeight * 15,
              fontWeight: FontWeight.w600,
              color: HexColor('#262626'),
            ),
          ),
          SizedBox(
            height: unitHeight * 4,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                size: unitHeight * 14,
                color: HexColor('#4E7D96'),
              ),
              //доделать
              Text(
                '  ${institution.name}',
                style: TextStyle(
                  fontSize: unitHeight * 13,
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstitutionUserPage(institution: institution),
        ),
      ),
    );
  }
}
