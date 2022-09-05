// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'SettingsPage.dart';
import 'myProfile.dart';

void main() => runApp(MYACC());

class MYACC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text('تعديل الملف الشخصي'),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // const Text(
              //   "تعديل الملف الشخصي",
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   textAlign: TextAlign.end,
              // ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("الاسم", false),
              buildTextField("الايميل", false),
              buildTextField("الموقع", false),
              buildTextField("المهنة", false),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SettingsPage()));
                    },
                       style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),elevation: 2,padding: const EdgeInsets.symmetric(horizontal: 50),primary: Colors.white ),
                    
                    
                 
                   
                    child: const Text(
                      "الغاء",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),elevation: 2,padding: const EdgeInsets.symmetric(horizontal: 50),primary: Colors.green ),

                
                    child: const Text(
                      "حفظ",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(),
          alignLabelWithHint: true,

          border: const UnderlineInputBorder(),
          hintText: labelText,
        ),
      ),
    );
  }
}
