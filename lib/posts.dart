// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, unused_import, unused_local_variable, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future pickercamera() async {
      final myFile = await ImagePicker().getImage(
        source: ImageSource.camera,
      );
    }

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
                                        color: Colors.grey.withOpacity(0.3)))),
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
                                                  padding: EdgeInsets.only(
                                                      right: 10)),
                                              Text(
                                                'اعجبني',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        )))
                              ],
                            ),
                          )),
                          Expanded(
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
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
