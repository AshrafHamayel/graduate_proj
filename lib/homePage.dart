import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HomePage extends StatelessWidget {
  var services = ["hello", "hi"];

  var images = ["images/gg.png", "images/bulder.jpg"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 150,
              width: 370,
              decoration: BoxDecoration(
                  color: Color.fromARGB(221, 59, 57, 80),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(221, 59, 57, 80),
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(221, 59, 57, 80),
                      borderRadius: BorderRadius.circular(15)),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(221, 59, 57, 80),
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(height: 10),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {},
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('images/about.png'),
                          opacity: 145,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'معلومات عنا',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.greenAccent,
                            fontStyle: FontStyle.italic),
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
  }
}
