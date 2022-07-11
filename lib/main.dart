import 'package:flutter/material.dart';
import 'mainPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:const  TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            color: Colors.red,
            decorationColor: Colors.amber
          )
        )

      ),
      home: mainPage(),
    );
  }
}
