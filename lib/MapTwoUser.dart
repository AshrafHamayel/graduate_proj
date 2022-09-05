// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
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

  late final String currentUser;
    late final String UserId;


    MapTwoUser
    ({
    
   required this.UserId,
    required this.currentUser,
 


  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }

 @override
 void initState() {
    
   
 }
  

  
 



  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: MapTwoUser_Page(
        UserId:UserId, 
         currentUser:currentUser,
      
      ),
    
      appBar:  AppBar(
        elevation: 3,
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text('اماكن تواجدكم '),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),

    ),
    
    );
  }
}

class MapTwoUser_Page extends StatefulWidget {
   late final String currentUser;
    late final String UserId;

    MapTwoUser_Page
    ({
   required this.UserId,
    required this.currentUser,

  });
  
  @override
  _MapTwoUser createState() => _MapTwoUser(
    UserId:UserId, 
         currentUser:currentUser,
         );
}

class _MapTwoUser extends State<MapTwoUser_Page> {
  late final String currentUser;
    late final String UserId;

    _MapTwoUser
    ({
        required this.UserId,
    required this.currentUser,

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
 String Distan=' ';

 String googleAPiKey = "AIzaSyASqMc9scA2BjTQqyKjBkWSwMNqR6mDBmQ";
  List<LatLng> polylineCoordinates = [];
Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();


    getPolyline(PointLatLng myPos, PointLatLng FrindPos) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      myPos,
       
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

 Future <void>getPos() async {

    var url = await"http://172.19.32.48:80/myProf/posCurrentFrind?frindId=$UserId&currentUser=$currentUser";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
print('responsebody Map====');
    print(responsebody);
       return await responsebody;
 

  }

  @override

  Widget build(BuildContext context) {
          
        var myIcon;

void initState() {
        
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(35, 35)), 'images/pp.png').then((onValue) { myIcon = onValue; });
        


 }      


  late PointLatLng myPos;
  late PointLatLng FrindPos;

          
                     return Scaffold(
        
         body: FutureBuilder(
                     future:getPos() ,
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   {   
           
       if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
       {
                                                    var   LatUser1 = double.parse(snapshot.data["CurrentUserLat"].toString());
                                                   var     LongUser1 = double.parse(snapshot.data["CurrentUserLong"].toString());

                                                   var   LatUser2 = double.parse(snapshot.data["FrindUserLat"].toString());
                                                   var     LongUser2 = double.parse(snapshot.data["FrindUserLong"].toString());

                                                            CameraPosition  kGooglePlex = CameraPosition(
                                                            target: LatLng(LatUser1, LongUser1),
                                                            zoom: 12,
                                                          );

                                                         myPos = PointLatLng(LatUser1, LongUser1);
                                                        FrindPos = PointLatLng(LatUser2, LongUser2);
                                                      Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
                                                     final MarkerId MymarkerId = MarkerId(currentUser);
                                                      final Marker myMark =Marker(
                                                      markerId: MarkerId(currentUser),
                                                      position: LatLng(LatUser1,LongUser1),
                                                   onTap:(){ 
                                                      customInfoWindowController.addInfoWindow!(
                                                        Text('هذا انت  ',style: TextStyle(fontSize:30,color: Color.fromARGB(20, 7, 3, 247))),
                                                       LatLng(LatUser1,LongUser1),
                                                      );
                                                     },
                                                     
                                                     icon:BitmapDescriptor.defaultMarker,
                                                     );

                                                 markers[MymarkerId] = myMark;


                                                 final MarkerId markerId = MarkerId('worker point');
                                                  
        
                                                       final Marker marker =Marker(
                                                        
                                                      markerId: MarkerId('worker point'),
                                                      position: LatLng(LatUser2,LongUser2),
                                                      icon: BitmapDescriptor.defaultMarker,
                                                         onTap:(){ 
                                                      customInfoWindowController.addInfoWindow!(
                                                      Text('هذا الشخص الاخر',style: TextStyle(fontSize:30,color: Color.fromARGB(20, 7, 3, 247))),
                                                      LatLng(LatUser2,LongUser2),
                                                       );
                                                       }
                                                       );
          
                                                  
                                                    markers[markerId] = marker;
                             return ListView(
                                children: 
                                      [Column(
                                        children: [
                                         FlatButton(  
                                                child: Text('جد الطريق و المسافة ', style: TextStyle(fontSize: 20.0),),  
                                                color: Color.fromARGB(255, 114, 114, 114),  
                                                textColor: Colors.white,  
                                                onPressed: () {   getPolyline(myPos,FrindPos);},  
                                              ), 
                                   Container(
                                              height:37,
                                              width: MediaQuery.of(context).size.width,
                                              child: Text('         المسافة  بينكم = $Distan       ',style: TextStyle(fontSize: 25,color: Colors.indigo),),
                                            ),
                                
                                            Container(
                                              height:MediaQuery.of(context).size.height *0.67,
                                              width: MediaQuery.of(context).size.width,
                                              child:   GoogleMap(
                                                 initialCameraPosition: kGooglePlex,
                                                 markers: Set<Marker>.of(markers.values),
                                                                     polylines: Set<Polyline>.of(polylines.values),
                              
                                                  onTap: (postition){ customInfoWindowController.hideInfoWindow!();},
                                                 onMapCreated: (GoogleMapController controller) {customInfoWindowController.googleMapController=controller;},
                                                 onCameraMove:(postition){ customInfoWindowController.onCameraMove!();},
                                                
                                                   ),
                                            ),
                                          SizedBox(height: 15 ,),
                                                    CustomInfoWindow(
                                                  controller:customInfoWindowController,
                                             height:MediaQuery.of(context).size.height *0.12,
                                              width: MediaQuery.of(context).size.width *0.95,
                                                  offset: 40, ),
                                              
                                      ]),
                                    ],
                              );
       

      
            }
          return CircularProgressIndicator();
          
          
         },
        ),
      );


       
       
       }
  
    
   
  }



