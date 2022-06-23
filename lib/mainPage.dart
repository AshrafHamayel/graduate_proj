import 'package:flutter/material.dart';
import 'homePage.dart';
import 'signIn.dart';

class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget>createState() {
    return _mainState();
    
  }

}

class _mainState extends State<mainPage>{
  var _currentIndex =2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حرفيون"),
        backgroundColor:Color.fromARGB(255, 66, 64, 64)
      ),

      backgroundColor: Color.fromARGB(255, 37, 35, 36),
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 66, 64, 64),
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
      selectedItemColor: Colors.amberAccent,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentIndex,
        type:BottomNavigationBarType.fixed,
        onTap:(index){
            setState(() {
              _currentIndex=index;
            });
        },
                

        items:[
          
           BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'الاشعارات'),
           BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'بحث'),
           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.wechat), label: 'الدردشات'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'حسابي'),



     ]
      ),

      body: getBodyWidget(),
    );
  }
  
  getBodyWidget() {
         if(_currentIndex==2)
         return HomePage();

         else if(_currentIndex==4)
         return SignIn() ;

         else 
         return Container();

  }
}