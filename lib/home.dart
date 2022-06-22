import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget>createState() {
    return _HomeState();
    
  }

}

class _HomeState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Name Proj "),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        items:[
           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),


     ]
      ),
    );
  }
}