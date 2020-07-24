import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Body extends StatefulWidget{
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body>{
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(6.9108335,79.8605378);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      ),
    );
  }

//  CameraPosition _initialPosition = CameraPosition(target: LatLng(6.9220039,79.7861644), zoom: 12.0);
//
//  @override
//  Widget build(BuildContext context) {
//    _getCurrentLocation();
//    return Scaffold(
//      body: GoogleMap(
//        initialCameraPosition: _initialPosition,
//        mapType: MapType.normal,
//      ),
//    );
//  }
//
  Future<CameraPosition> _getCurrentLocation() async {
    double latitude, longitude;
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;

      return CameraPosition(target: LatLng(latitude, longitude));
    });
  }
}