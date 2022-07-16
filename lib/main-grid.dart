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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // child: GridView.builder(
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisSpacing: 10,
        //   mainAxisSpacing: 10,
        //   crossAxisCount: 1,
        // ),
        // itemCount: 1,
        // itemBuilder: (BuildContext context, int index) {
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Material(
                    child: Ink.image(
                      fit: BoxFit.fill,
                      width: 370,
                      height: 170,
                      image: const AssetImage('images/workers.png'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Material(
                        child: Ink.image(
                          fit: BoxFit.fill,
                          width: 180,
                          height: 180,
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
                      height: 250,
                      width: 180,
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
                          fit: BoxFit.fill,
                          width: 180,
                          height: 250,
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
                          fit: BoxFit.fill,
                          width: 180,
                          height: 180,
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
        )
        // }
        // ),
        );
  }
}
