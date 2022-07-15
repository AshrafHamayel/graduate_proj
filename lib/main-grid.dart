// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MainGrid extends StatefulWidget {
  const MainGrid({Key? key}) : super(key: key);

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myProducts = [
      {
        "img": "images/search.png",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
      {
        "img": "images/gg.png",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
      {
        "img": "images/workers.png",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
      {
        "img": "images/about_us.png",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
      {
        "img": "images/sui.jpg",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
      {
        "img": "images/bulder.jpg",
        "fun": () {
          print("object 12");
          // Navigator.of(context).pushNamed("");
        },
      },
    ];
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
             crossAxisSpacing: 20,
              mainAxisSpacing: 20,

              ),
              itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(15),
              //       child: Material(
              //         child: Ink.image(
              //           fit: BoxFit.cover,
              //           width: MediaQuery.of(context).size.width - 20,
              //           height: MediaQuery.of(context).size.height - 580,
              //           image: const AssetImage('images/workers.png'),
              //           child: InkWell(
              //             onTap: () {/* ... */},
              //             child: const Align(
              //               child: Padding(
              //                 padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
              //                 child: Text(
              //                   '',
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.w900,
              //                       color: Colors.white70,
              //                       fontSize: 20),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Material(
                          child: Ink.image(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 210,
                            height: MediaQuery.of(context).size.height - 580,
                            image: const AssetImage('images/search.png'),
                            child: InkWell(
                              onTap: () {/* ... */},
                              child: const Align(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white70,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                       const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width - 210,
                        height: MediaQuery.of(context).size.height - 510,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(221, 59, 57, 80),
                            borderRadius: BorderRadius.circular(15)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Material(
                          child: Ink.image(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 210,
                            height: MediaQuery.of(context).size.height - 510,
                            image: const AssetImage('images/account.png'),
                            child: InkWell(
                              onTap: () {/* ... */},
                              child: const Align(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white70,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                       const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Material(
                          child: Ink.image(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 210,
                            height: MediaQuery.of(context).size.height - 580,
                            image: const AssetImage('images/callUS.png'),
                            child: InkWell(
                              onTap: () {/* ... */},
                              child: const Align(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white70,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
