// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/search.dart';
import 'package:graduate_proj/workerProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'EditProfile.dart';
import 'Ratings.dart';
import 'SettingsPage.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'mainPage.dart';
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MapTwoUser extends StatelessWidget {
  late final PointLatLng FrindPos;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
  late final PointLatLng myPos;

    MapTwoUser
    ({
    
   required this.FrindPos,
    required this.currentUser,
    required this.kGooglePlex,
    required this.myPos,



  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }

 
  
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: MapTwoUser_Page(
        FrindPos:FrindPos, 
         currentUser:currentUser,
         kGooglePlex:kGooglePlex,
         myPos:myPos,

      ),
    
      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
             Navigator.pop(context);
            },
          ),
        ],
      ),

    ),
    
    );
  }
}

class MapTwoUser_Page extends StatefulWidget {
  late final PointLatLng FrindPos;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
  late final PointLatLng myPos;

    MapTwoUser_Page
    ({
 required this.FrindPos,
    required this.currentUser,
    required this.kGooglePlex,
     required this.myPos,

  });
  
  @override
  _MapTwoUser createState() => _MapTwoUser(
         FrindPos:FrindPos, 
         currentUser:currentUser,
         kGooglePlex:kGooglePlex,
        myPos:myPos,

         );
}

class _MapTwoUser extends State<MapTwoUser_Page> {


  late final PointLatLng FrindPos;

  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
  late final PointLatLng myPos;

    _MapTwoUser
    ({
     required this.FrindPos,
    required this.currentUser,
    required this.kGooglePlex,
        required this.myPos,


  });

  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }


late String downloadURL;
 String Distan='جار الحساب';

 String googleAPiKey = "AIzaSyASqMc9scA2BjTQqyKjBkWSwMNqR6mDBmQ";
  List<LatLng> polylineCoordinates = [];
Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();


    getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      myPos!,
      
      PointLatLng(FrindPos.latitude,FrindPos.longitude),
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

  addPolyLine(List<LatLng> polylineCoordinates) 
  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 2,
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates.map((e) => LatLng(e.latitude, e.longitude)).toList());
       polylines[id] = polyline;
    calcDistance(polylineCoordinates);
    setState(() {});
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
    // print("=========================================");
    // print("distance = ${totalDistance.toStringAsFixed(2)} km");

    // print("=========================================");

    Distan=totalDistance.toStringAsFixed(2)+'km';
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


CustomInfoWindowController customInfoWindowController=CustomInfoWindowController();

  @override

  Widget build(BuildContext context) {
          
        var myIcon;

void initState() {
        
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(35, 35)), 'images/pp.png').then((onValue) { myIcon = onValue; });


 }      
          Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
                                                     final MarkerId MymarkerId = MarkerId(currentUser);
                                                      final Marker myMark =Marker(
                                                      markerId: MarkerId(currentUser),
                                                      position: LatLng(myPos.latitude, myPos.longitude),
                                                   onTap:(){ 
                                                      customInfoWindowController.addInfoWindow!(
                                                        Text('هذا انت  ',style: TextStyle(fontSize:30,color: Color.fromARGB(20, 7, 3, 247))),
                                                       LatLng(myPos.latitude, myPos.longitude),
                                                      );
                                                     },
                                                     
                                                     icon:BitmapDescriptor.defaultMarker,
                                                     );

                                                 markers[MymarkerId] = myMark;


                                                 final MarkerId markerId = MarkerId('worker point');
                                                  
        
                                                       final Marker marker =Marker(
                                                        
                                                      markerId: MarkerId('worker point'),
                                                      position: LatLng(FrindPos.latitude, FrindPos.longitude),
                                                      icon: BitmapDescriptor.defaultMarker,
                                                         onTap:(){ 
                                                      customInfoWindowController.addInfoWindow!(
                                                      Text('هذا الشخص الاخر',style: TextStyle(fontSize:30,color: Color.fromARGB(20, 7, 3, 247))),
                                                       LatLng(FrindPos.latitude, FrindPos.longitude),
                                                       );
                                                       }
                                                       );
          
                                                  
                                                    markers[markerId] = marker;
                                                  
               
                 getPolyline();
                     return Scaffold(
                  
                              body:Column(
                                  children: [
                               Container(
                                        height:MediaQuery.of(context).size.height *0.1,
                                        width: MediaQuery.of(context).size.width,
                                        child: Text('      المسافة  بينكم = $Distan       ',style: TextStyle(fontSize: 25,color: Colors.indigo),),
                                      ),

                                      Container(
                                        height:MediaQuery.of(context).size.height *0.67,
                                        width: MediaQuery.of(context).size.width,
                                        child:   GoogleMap(
                                           initialCameraPosition: kGooglePlex,
                                           markers: Set<Marker>.of(markers.values),
                                            onTap: (postition){ customInfoWindowController.hideInfoWindow!();},
                                           onMapCreated: (GoogleMapController controller) {customInfoWindowController.googleMapController=controller;},
                                           onCameraMove:(postition){ customInfoWindowController.onCameraMove!();},
                                          
                                             ),
                                      ),
                                    // SizedBox(height: 15 ,),
                                    //           CustomInfoWindow(
                                    //         controller:customInfoWindowController,
                                    //    height:MediaQuery.of(context).size.height *0.12,
                                    //     width: MediaQuery.of(context).size.width *0.95,
                                    //         offset: 40, ),
                              
                                  ],
                                ),
                           
                            
                             
                                        
               
            
                                    );


       
       
       }
  
    
   
  }


