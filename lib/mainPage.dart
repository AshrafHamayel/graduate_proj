import 'package:flutter/material.dart';
import 'homePage.dart';
class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget>createState() {
    return _mainState();
    
  }

}

class _mainState extends State<mainPage>{
  var _currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Name Proj "),
      ),

      backgroundColor: Color(0xFFF0F0F0),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type:BottomNavigationBarType.fixed,
        onTap:(index){
            setState(() {
              _currentIndex=index;
            });
        },
        items:[
           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
           BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
           BottomNavigationBarItem(icon: Icon(Icons.more), label: 'more'),
          BottomNavigationBarItem(icon: Icon(Icons.password_sharp), label: 'pass'),



     ]
      ),

      body: getBodyWidget(),
    );
  }
  
  getBodyWidget() {
         
         return(_currentIndex ==0)? HomePage() :Container();

  }
}