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
    return Column(
      
     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
          
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
        
          children: [
          
               Container(
                
                height: 150,
                width: 380,           
                decoration:BoxDecoration(
                  color: Color.fromARGB(221, 59, 57, 80),          
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
               ],
        ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
         
                children: [
                  Column(
                     
          
                    children: [
                      Container(
                        
                        height: 180,
                        width: 180,           
                        decoration:BoxDecoration(
                          color: Color.fromARGB(221, 59, 57, 80),          
                          borderRadius: BorderRadius.circular(15)
                        ),
                        
                      
                      ),
                      Container(
                    
                    height: 250,
                    width: 180,           
                    decoration:BoxDecoration(
                      color: Color.fromARGB(221, 59, 57, 80),          
                      borderRadius: BorderRadius.circular(15)
                    ),
                  )
                    ],
                  ),
                 Column(
               
                 
                    children: [
                      Container(
                        
                        height: 250,
                        width: 180,           
                        decoration:BoxDecoration(
                          color: Color.fromARGB(221, 59, 57, 80),          
                          borderRadius: BorderRadius.circular(15)
                        ),
                        
                      
                      ),
                      Container(
                    
                     
                    height: 180,
                    width: 180,           
                    decoration:BoxDecoration(
                      color: Color.fromARGB(221, 59, 57, 80),          
                      borderRadius: BorderRadius.circular(15)
                    ),
                  )
                    ],
                  ),
                ],
              )
              
              
         
      ],
    );
  }

}