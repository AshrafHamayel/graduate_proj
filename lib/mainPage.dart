// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, camel_case_types, prefer_const_constructors, unused_import, use_key_in_widget_constructors, file_names, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_proj/Chats/models/user_model.dart';
import 'package:graduate_proj/Chats/screens/home_screen.dart';
import 'package:graduate_proj/posts.dart';
import 'finalHome.dart';
import 'search.dart';
import 'signIn.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class mainPage extends StatefulWidget {
   late final String currentUser;
      late final String name;
   late final String UrlImage;

    mainPage
    ({
    required this.currentUser,
    required this.name,
    required this.UrlImage,
  
  });

  @override
  State<StatefulWidget> createState() {
    
    return _mainState(
      currentUser:currentUser,
       name:name,
        UrlImage:UrlImage,
    );
  }
}

class _mainState extends State<mainPage> {
   late final String currentUser;
      late final String name;
   late final String UrlImage;
    _mainState
    ({
    required this.currentUser,
    required this.name,
    required this.UrlImage,
  
  });
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
      return home_Page(
        currentUser:currentUser,
        name:name,
        UrlImage:UrlImage,
      );
    } else if (_currentIndex == 4) {
        return myProfile(
           UserId:currentUser,
           name:name,
        UrlImage:UrlImage,
        );
    }
     else if (_currentIndex == 3) 
     {
     return HomeScreen( name:name,
        UrlImage:UrlImage,);
    
    } 
    
    else if (_currentIndex == 1) {
      return Post(UserId:currentUser,name:name,UrlImage:UrlImage,);
    } else if (_currentIndex == 0) {
      return SearchWorker(currentUser:currentUser,
         name:name,
        UrlImage:UrlImage,
      
      );
    } else {
      return Container();
    }
  }
}
