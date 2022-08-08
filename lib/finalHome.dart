// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state, camel_case_types, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, deprecated_member_use, sized_box_for_whitespace

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'workersDetails.dart';

class home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        appBar: AppBar(
          title: Text("Work Book"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ),
        endDrawer: Drawer(
          backgroundColor: Color.fromARGB(255, 66, 64, 64),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("لاسم"),
                accountEmail: Text("الايميل"),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(),
              ),

              // DrawerHeader(child: Image(image: AssetImage("images/logo.jpg"))),
              ListTile(
                title: Text(""),
                leading: Icon(Icons.abc),
                onTap: () {},
              )
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  autoplayDuration: Duration(seconds: 10),
                  dotSize: 6.0,
                  dotBgColor: Colors.black.withOpacity(0.2),
                  dotIncreasedColor: Colors.red.withOpacity(0.5),
                  dotPosition: DotPosition.bottomCenter,
                  showIndicator: true,
                  images: [
                    AssetImage("images/logo.jpg"),
                    AssetImage("images/sui.jpg"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: Text(
                  "عمال بناء",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 202,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                  ],
                ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: Text(
                  "عمال كهرباء",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 202,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                  ],
                ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: Text(
                  "عمال بلاط",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 202,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                  ],
                ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: Text(
                  "عمال دهان",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 202,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                  ],
                ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: Text(
                  "خدمات اخرى",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 202,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                    buildCard(context),
                  ],
                ),
              ),
              Divider(color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCard(BuildContext context) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width - 250,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.green,
                      backgroundImage: NetworkImage(
                          "https://media.elcinema.com/uploads/_315x420_4d499ccb5db06ee250289a1d8c753b347b8a31d419fd1eaf80358de753581b7b.jpg"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "data",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "daaaaaata",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.5)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => WorkersData(),
                          ),
                        );
                      },
                      color: Colors.red[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'تواصل ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
