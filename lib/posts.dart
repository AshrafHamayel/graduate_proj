// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, unused_import, unused_local_variable, deprecated_member_use, unused_element, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, avoid_single_cascade_in_expression_statements, unnecessary_null_comparison, camel_case_types

import 'dart:async';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';
import 'package:image_picker/image_picker.dart';

import 'Chats/models/user_model.dart';

class Post extends StatelessWidget {
   UserModel user;
  Post(this.user);
  @override
  Widget build(BuildContext context) {
    Future pickercamera() async {
      final myFile = await ImagePicker().getImage(
        source: ImageSource.camera,
      );
    }

    Position myP;
    var lat, long;
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(0, 0),
      zoom: 14.4746,
    );
    ;
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

    Future<void> getLatAndLong() async {
      myP = await Geolocator.getCurrentPosition().then((value) => value);
      lat = myP.latitude;
      long = myP.longitude;

      _kGooglePlex = CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.4746,
      );
    }

    void initState() {
      getPer();

      //super.initState();
    }

    Completer<GoogleMapController> _controller = Completer();

    return Container(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text('المنشورات'),
              backgroundColor: const Color.fromARGB(255, 66, 64, 64),
            ),
            body: ListView(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Container(child: Text('الاسم')),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert_outlined)),
                        isThreeLine: true,
                        subtitle: Text('هلا هلي '),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.3)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(.3)))),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Colors.grey,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Text(
                                              'اعجبني',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          getLatAndLong();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(.3)))),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.thumb_down_alt_outlined,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10)),
                                              Text(
                                                'لم يعجبني',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _kGooglePlex == null
                          ? CircularProgressIndicator()
                          : Container(
                              height: 300,
                              width: 500,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
