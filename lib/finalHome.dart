// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state, camel_case_types, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe

//import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("data"),
          ),
          body: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 150.0,
              //   width: 300.0,
              //   child: Carousel(
              //     boxFit: BoxFit.cover,
              //     autoplay: false,
              //     animationCurve: Curves.fastOutSlowIn,
              //     animationDuration: Duration(milliseconds: 1000),
              //     dotSize: 6.0,
              //     dotIncreasedColor: Color(0xFFFF335C),
              //     dotBgColor: Colors.transparent,
              //     dotPosition: DotPosition.topRight,
              //     dotVerticalPadding: 10.0,
              //     showIndicator: true,
              //     indicatorBgPadding: 7.0,
              //     images: [
              //       NetworkImage(
              //           'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              //       NetworkImage(
              //           'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              //       ExactAssetImage("assets/images/LaunchImage.jpg"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
