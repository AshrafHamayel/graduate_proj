// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, camel_case_types

import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';
import 'homePage.dart';
import 'main-grid.dart';
import 'search.dart';
import 'signIn.dart';
import 'signup.dart';

import 'myProfile.dart';

class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mainState();
  }
}

class _mainState extends State<mainPage> {
  var _currentIndex = 2;
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
                icon: Icon(Icons.switch_account_outlined), label: 'العمال'),
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
      return MainGrid();
    } else if (_currentIndex == 4) {
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
