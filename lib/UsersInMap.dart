// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

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

class UsersInMap extends StatelessWidget {
  late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;

    UsersInMap
    ({
    
   required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
    

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SearchWorker(currentUser:currentUser)));
            },
          ),
        ],
      ),

    ),
    
    );
  }
}

class UsersInMap_Page extends StatefulWidget {
  late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
    UsersInMap_Page
    ({
 required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
    

  });
  
  @override
  _UsersInMap createState() => _UsersInMap(
         markers:markers, 
         currentUser:currentUser,
         kGooglePlex:kGooglePlex,
         );
}

class _UsersInMap extends State<UsersInMap_Page> {


 late final Map<MarkerId, Marker> markers;
  late final String currentUser;
  late final  CameraPosition  kGooglePlex ;
    _UsersInMap
    ({
     required this.markers,
    required this.currentUser,
    required this.kGooglePlex,
    

  });



  final Storage storage=Storage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;



  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }




Future<List> SendInfoSearch() async
  { 
    final  url = "http://192.168.0.114:80/search/getResultSearch?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();

  }





  Future <void>getInfo() async {

    var url = await"http://192.168.0.114:80/myProf/myProf?UserId=$currentUser";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }
CustomInfoWindowController _customInfoWindowController=CustomInfoWindowController();
late String downloadURL;

  @override

  
void initState(){
  super.initState();
}


  Widget build(BuildContext context) {
       
                 
                     return Scaffold(
                         body: Stack(
                              children: [
                                           Container(
                                              height: 100,
                                              width: 100,
                                              child:GoogleMap(
                                         initialCameraPosition: kGooglePlex,
                                         markers: Set<Marker>.of(markers.values),
                                          onTap: (postition){ _customInfoWindowController.hideInfoWindow!();},
                                         onMapCreated: (GoogleMapController controller) {_customInfoWindowController.googleMapController=controller;},
                                         onCameraMove:(postition){ _customInfoWindowController.onCameraMove!();},
                         
                                               ), 

                                           ),
                                      
                              
                                        CustomInfoWindow(
                                          controller:_customInfoWindowController,
                                          height:50,
                                          width: 50,
                                          offset: 35,
                                          
                                                        ),

           

                                          ],
          


                                    ),
               
            
                                    );


       
       
       }
  
    
   
  }


