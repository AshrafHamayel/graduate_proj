import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        "img": "images/workers.png",
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
        "img": "images/workers.png",
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
        "img": "images/workers.png",
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
     
    ];
    return Container(
       margin: const EdgeInsets.only(top: 10,left: 8,right: 8),
      // padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,          
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,

          ),
          itemCount: myProducts.length,
          itemBuilder: (BuildContext ctx, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  image: AssetImage(myProducts[index]['img']),
                  child: InkWell(
                    onTap: myProducts[index]['fun'],
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
            );

            //  Container(
            //   alignment: Alignment.center,
            //   child: Text(myProducts[index]["name"]),
            //   decoration: BoxDecoration(
            //       color: Colors.amber,
            //       borderRadius: BorderRadius.circular(15)),
            // );
          }),
    );
  }
}
