// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_proj/EditProfile.dart';
import 'package:graduate_proj/myProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PasswordCH.dart';
import 'main-grid.dart';
import 'mainPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  
  out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }


  @override
  Widget build(BuildContext context) {
    var _curIndex = 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => myProfile()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              "الاعدادات",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "الحساب",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "تغير كلمة السر", 0),
            buildAccountOptionRow(context, "المعلومات العامة", 1),
            buildAccountOptionRow(context, "اللغة", 2),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                               out();
                              
                                Navigator.push( context,
            MaterialPageRoute(builder: (context) =>  mainPage()));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: const Text("تسجيل الخروج",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, var curindex) {
    return GestureDetector(
      onTap: () {
        if (curindex == 0) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => changemypassord()));
        } else if (curindex == 1) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => MYACC()));
        } else if (curindex == 2) {}
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
