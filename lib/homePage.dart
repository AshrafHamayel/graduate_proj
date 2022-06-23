import 'package:flutter/material.dart';
class HomePage extends StatelessWidget{
var services = [
  "hello",
  "hi"
];

var images = [
  "images/gg.png",
  "images/bulder.jpg"
];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: GridView.builder(
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2.5)

        ), 
      
      itemBuilder:(BuildContext context , int index ){
        return Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
            Image.asset(images[index],height: 50,width:50,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(services[index],style:TextStyle(fontSize: 18,height: 1.2,fontWeight: FontWeight.bold),textAlign:TextAlign.center ,),
                )
               
            ],
          ),
        );
      } 
      ),
      );
  }

}