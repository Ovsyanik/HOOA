import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:latlong2/latlong.dart' as latLong;
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  String position;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double unitHeight = size.height * 0.00125;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLong.LatLng(53.890998, 27.550449),
              zoom: 15.0,
              onTap: (position, point) {
                final coordinates = Coordinates(point.latitude, point.longitude);
                Geocoder.local
                    .findAddressesFromCoordinates(coordinates)
                    .then((value) => this.position = "${value.first.thoroughfare}, ${value.first.featureName}" );
              }
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/hooa/cktredxp006bf18o2wqb5n5vr/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoiaG9vYSIsImEiOiJja3RyZWF5eWcwdDVrMm9ucTRuZWFjNm1vIn0.lf2viia7eoo9v7MAAm0QlQ',
                  'id': 'mapbox.mapbox-streets-v8'
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.04),
            width: size.width / 2,
            height: unitHeight * 50,
            child: MaterialButton(
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor("#FF844B")),
                borderRadius: BorderRadius.circular(40),
              ),
              color: HexColor("#FF844B"),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                'Выбрать',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: unitHeight * 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(position),
            ),
          ),
        ],
      ),
    );
  }
}