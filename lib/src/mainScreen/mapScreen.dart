import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routelines/helper/getMapImageProvider.dart';
import 'package:routelines/helper/mapStyle.dart';
import 'package:routelines/helper/map_helper.dart';

const LatLng DEST_LOCATION = LatLng(30.925126, 31.157406);

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              zoom: 13,
              bearing: 30,
              tilt: 0,
              target: LatLng(
                  Provider.of<MapHelper>(context, listen: false)
                      .position
                      .latitude,
                  Provider.of<MapHelper>(context, listen: false)
                      .position
                      .longitude)),
          onMapCreated: onMapCreated),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(
              Provider.of<MapHelper>(context, listen: false).position.latitude,
              Provider.of<MapHelper>(context, listen: false)
                  .position
                  .longitude),
          icon: Provider.of<GetMapImage>(context, listen: false).sourceIcon));
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: Provider.of<GetMapImage>(context, listen: false)
              .destinationIcon));
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        Provider.of<MapHelper>(context, listen: false).position.latitude,
        Provider.of<MapHelper>(context, listen: false).position.longitude,
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }
}
