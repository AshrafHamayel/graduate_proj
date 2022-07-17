// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers

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
                        title: TextFormField(
                          maxLines: 10,
                          maxLength: 255,
                          minLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 10),
                              hintText: '...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      IconButton(
                          onPressed: pickercamera,
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                          )),
                      Row(
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
                                          Icons.add_box,
                                          color: Colors.grey,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10)),
                                        Text(
                                          'اضف منشور',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Container(child: Text('الاسم')),
                        trailing: Icon(Icons.more_vert_outlined),
                        isThreeLine: true,
                        subtitle: Text('هلا هلي '),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(.5),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.grey))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.thumb_up_off_alt_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "اعجبني",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                          )),
                          Expanded(
                              child: Padding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.thumb_down_alt_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "لم يعجبني",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                          )),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
