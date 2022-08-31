// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
bool mapVis1=true;
class UsersInMap extends StatelessWidget {
  late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
  late final CustomInfoWindowController customInfoWindowController;
  late final bool mapVis;
    UsersInMap
    ({
    
   required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
    required this.customInfoWindowController,
    required this.mapVis,


  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }


  @override
 
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: UsersInMap_Page(
        markers:markers, 
         currentUser:currentUser,
         kGooglePlex:kGooglePlex,
    customInfoWindowController:customInfoWindowController,
    mapVis:mapVis,

      ),
    
      appBar:  AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {

            mapVis1=false;
           Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text('النتائج على الخريطة'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),

    ),
    
    );
  }
}

class UsersInMap_Page extends StatefulWidget {
  late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
    late final CustomInfoWindowController customInfoWindowController;
  late final bool mapVis;

    UsersInMap_Page
    ({
 required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
   required this.customInfoWindowController,
    required this.mapVis,


  });
  
  @override
  _UsersInMap createState() => _UsersInMap(
         markers:markers, 
         currentUser:currentUser,
         kGooglePlex:kGooglePlex,
     customInfoWindowController:customInfoWindowController,
    mapVis:mapVis,

         );
}

class _UsersInMap extends State<UsersInMap_Page> {


 late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
    late final CustomInfoWindowController customInfoWindowController;
  late final bool mapVis;

    _UsersInMap
    ({
     required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
     required this.customInfoWindowController,
        required this.mapVis,


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

  @override
     void initState() 
    {
    mapVis1=true;
    super.initState();
    
  }
  Widget build(BuildContext context) {
       
                 
                     return Scaffold(
                  
                              body:Visibility(
                                child: Column(
                                  children: [
                                      Container(
                                        height:MediaQuery.of(context).size.height *0.63,
                                        width: MediaQuery.of(context).size.width,
                                        child:   GoogleMap(
                                           initialCameraPosition: kGooglePlex,
                                           markers: Set<Marker>.of(markers.values),
                                            onTap: (postition){ customInfoWindowController.hideInfoWindow!();},
                                           onMapCreated: (GoogleMapController controller) {customInfoWindowController.googleMapController=controller;},
                                           onCameraMove:(postition){ customInfoWindowController.onCameraMove!();},
                                          
                                             ),
                                      ),
                                    SizedBox(height: 15 ,),
                                              CustomInfoWindow(
                                            controller:customInfoWindowController,
                                       height:MediaQuery.of(context).size.height *0.20,
                                        width: MediaQuery.of(context).size.width *0.95,
                                            offset: 40, ),
                              
                                  ],
                                ),
                               visible: mapVis1,
                              )
                             
                                        
               
            
                                    );


       
       
       }
  
    
   
  }


