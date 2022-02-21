import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchInstitutionDelegate extends SearchDelegate {
  double unitHeight;

  SearchInstitutionDelegate({this.unitHeight});

  @override
  List<Widget> buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/search.svg',
        color: HexColor("#262626"),
        height: unitHeight * 20,
        width: unitHeight * 20,
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () => null,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return null;
  }
}
