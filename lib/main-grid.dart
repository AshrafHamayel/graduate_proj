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
    return  Container(
         
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Material(
                      child: Ink.image(
                        fit: BoxFit.fill,
                        width:MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height* 0.22,
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
              SizedBox(height: 10,),
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
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.25,
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
                        width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.32,
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
                           width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.32,
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
                             width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.25,
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
          
          );
    
  }
}
