import 'package:flutter/material.dart';
class HomePage extends StatelessWidget{
var services = [
  "hello",
  "hi"
];


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
        ), 
      
      itemBuilder:(BuildContext context , int index){
        return Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset("imgs/clen.jpg",height: 50,width: 50,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Clener",style:TextStyle(fontSize: 16,height: 1.2,fontWeight: FontWeight.bold),textAlign:TextAlign.center ,),
                )
              
            ],
          ),
        );
      } 
      );
  }

}