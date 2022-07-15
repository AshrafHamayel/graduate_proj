import 'package:flutter/material.dart';
import 'package:graduate_proj/workersPage.dart';
import 'homePage.dart';
import 'signIn.dart';
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 66, 64, 64),
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_search), label: 'بحث'),
            BottomNavigationBarItem(
                icon: Icon(Icons.switch_account_outlined), label: 'العمال'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wechat), label: 'الدردشات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'حسابي'),
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 75,
        child: getBodyWidget(),
      ),
    );
  }

  getBodyWidget() {
    if (_currentIndex == 2)
      // return Text("asd");
      return HomePage();
    else if (_currentIndex == 4)
      return myProfile();
    else if (_currentIndex == 3)
      return SignIn();
    else if (_currentIndex == 1)
      return Workers();
    else
      return Container();
  }
}
