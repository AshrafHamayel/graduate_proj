// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, camel_case_types, prefer_const_constructors, unused_import, use_key_in_widget_constructors, file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';
import 'finalHome.dart';
import 'homePage.dart';
import 'main-grid.dart';
import 'search.dart';
import 'signIn.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myProfile.dart';

class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mainState();
  }
}

class _mainState extends State<mainPage> {
  var _currentIndex = 2;
  var email;

  getEamil() async {
    //SharedPreferences.setMockInitialValues({});
    SharedPreferences preferences = await SharedPreferences.getInstance();
//await preferences.clear();

    email = preferences.getString("email");
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
          unselectedItemColor: Colors.white,
          selectedIconTheme:
              const IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_search), label: 'بحث'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.contact_page_outlined), label: 'المنشورات'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'الرئيسية'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.wechat), label: 'الدردشات'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'حسابي'),
          ]),
      body: getBodyWidget(),
    );
  }

  getBodyWidget() {
    if (_currentIndex == 2) {
      return home_Page();
    } else if (_currentIndex == 4) {
      getEamil();

      if (email.toString().length < 5)
        return SignIn();
      else
        return myProfile();
    } else if (_currentIndex == 3) {
      return SignIn();
    } else if (_currentIndex == 1) {
      return Post();
    } else if (_currentIndex == 0) {
      return Workers();
    } else {
      return Container();
    }
  }
}
