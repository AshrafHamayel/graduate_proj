// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_final_fields, avoid_single_cascade_in_expression_statements

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:graduate_proj/mainPage.dart';
import 'package:graduate_proj/posts.dart';
import 'package:image_picker/image_picker.dart';
import 'mainPage.dart';

class myMap extends StatefulWidget {
  @override
  State<myMap> createState() => newMap();
}

class newMap extends State<myMap> {
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
//for polyline

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyASqMc9scA2BjTQqyKjBkWSwMNqR6mDBmQ";
  PointLatLng? myPos; // = PointLatLng(lat!, long!);

//
  StreamSubscription<Position>? positionStream;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? gmc;
  Set<Marker>? myMark = {};
  CameraPosition? _kGooglePlex;
  Future getPer() async {
    bool ser;
    LocationPermission per;
    ser = await Geolocator.isLocationServiceEnabled();
    if (ser == false) {
      AwesomeDialog(
          context: context,
          //  title: Text("services"),
          body: Text("S not enabled"))
        ..show();
    }
    per = await Geolocator.requestPermission();
    if (per == LocationPermission.denied)
      per = await Geolocator.requestPermission();

    return per;
  }

  late Position myP;
  double? lat, long;

  Future<void> getLatAndLong() async {
    myP = await Geolocator.getCurrentPosition().then((value) => value);
    lat = myP.latitude;
    long = myP.longitude;
    myPos = PointLatLng(lat!, long!);
    _kGooglePlex = CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 12,
    );
    myMark?.add(Marker(
      markerId: MarkerId("My Position"),
      position: LatLng(lat!, long!),
    ));
    setState(() {});
  }

  changeMarker(newlat, newlong) {
    myMark?.clear();
    myMark?.add(Marker(
      markerId: MarkerId("My Position"),
      position: LatLng(newlat, newlong),
    ));
    gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(newlat, newlong)));
    setState(() {});
  }

  @override
  void initState() {
    getPer();
    getLatAndLong();
    // TODO: implement initState

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      changeMarker(position?.latitude, position?.longitude);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        ),
        body: Center(
          child: Column(
            children: [
              if (_kGooglePlex == null)
                CircularProgressIndicator()
              else
                Container(
                  height: 300,
                  width: 300,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: myMark!,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      gmc = controller;
                      //    _controller.complete(controller);
                    },
                  ),
                ),
              RaisedButton(
                onPressed: () {
                  LatLng? laln = LatLng(lat!, long!);
                  myPos = PointLatLng(laln.latitude, laln.longitude);
                  getPolyline();
                  // gmc!.animateCamera(CameraUpdate.newCameraPosition(
                  //     CameraPosition(
                  //         target: laln, zoom: 16, tilt: 30, bearing: 30)));
                },
                child: Text("get my pos."),
              )
            ],
          ),
        ),
      ),
    ));
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 2,
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList());
    polylines[id] = polyline;
    calcDistance(polylineCoordinates);
    setState(() {});
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      myPos!,
      PointLatLng(32.143763, 35.290582),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));

        // polylineCoordinates.add(LatLng(lat!, long!));
        // polylineCoordinates.add(LatLng(31.903765, 35.203419));
      });
    } else {
      print("==================================================");
      print(result.errorMessage);
    }

    // polylineCoordinates.add(LatLng(lat!, long!));
    //polylineCoordinates.add(LatLng(31.903765, 35.203419));

    addPolyLine(polylineCoordinates);
  }

  void calcDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;

    // Calculating the total distance by adding the distance
    // between small segments
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    print("=========================================");
    print("distance = ${totalDistance.toStringAsFixed(2)} km");

    print("=========================================");
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
