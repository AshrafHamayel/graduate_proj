import 'package:flutter/material.dart';
import '../../../../models/ChatElements.dart';
import '../../../models/Chat.dart';
import '../../messages/message_screen.dart';
import 'chat_card.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path/path.dart'as Path;
import 'dart:io';

class Body extends StatelessWidget {

  var Myemail;
     

  

Widget buildd(BuildContext context) {
  return FutureBuilder(
    future: getEamil(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Myemail;
      }
      return CircularProgressIndicator(); // or some other widget
    },
  );
}
Future<void> getEamil() async {
  SharedPreferences    preferences = await SharedPreferences.getInstance();
    Myemail = preferences.getString("email");
  print(preferences.getString("email"));

  }



 Future <List<chatsElements>>getInfo() async {

    getEamil();
      print("Email is:");
      print(Myemail);
 
    var url = "http://10.0.2.2:8000/chatMessage/getPepole?MyEmail=$Myemail";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body).cast<Map<String, dynamic>>();
  
  print(responsebody);
    return responsebody.map<chatsElements>((json) => chatsElements.fromMap(json)).toList();
 

  }


  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
  body: FutureBuilder<List<chatsElements>>(
                     future:getInfo() ,
       builder: (context, snapshot) 
       {
 if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
       {
                print(snapshot);

         return Stack(
      children: <Widget>[
        SafeArea(
          child: SingleChildScrollView(
            child: Expanded(

          child: Column(
            children: [
                 // Expanded(
                    
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                      itemCount: chatsData.length,
                      itemBuilder: (context, index) => ChatCard(
                        chat: chatsData[index],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagesScreen(),
                          ),
                        ),
                      ),
                    ),
                 // ),
                ],

          )
          )
                  )

        )

      ]

         );

       }

        return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.2,
                  image: const AssetImage('images/LO.png'),
                ),
              ),
            ),
          ],
        ),
       
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: CircularProgressIndicator(),
                  ),
                ),
               
              ],
          
        )
      ],
    ));




       }

  )

       )


    );
    

  }

}


