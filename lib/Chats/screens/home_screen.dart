import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/Chats/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../SettingsPage.dart';
import '../../Tenders.dart';
import '../../complaint.dart';
import '../../main.dart';
import '../../signIn.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  
          late final String name;
   late final String UrlImage;

       HomeScreen
    ({
        required this.name,
    required this.UrlImage,
  
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(
       name:name,
        UrlImage:UrlImage,
  );
}

var UID;
late UserModel user;


class _HomeScreenState extends State<HomeScreen> {
          late final String name;
   late final String UrlImage;
          _HomeScreenState
    ({
        required this.name,
    required this.UrlImage,
  
  });
   out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }

  Future<void> getEamil() async {
  SharedPreferences    preferences = await SharedPreferences.getInstance();
     UID = preferences.getString("UserId");

       print(' UID from home screen :');

  print(preferences.getString("UserId"));
     DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(UID).get();
      user = UserModel.fromJson(userData);
  return UID;

  }

    Future getPer(context) async {
    bool ser;
    LocationPermission per;
    ser = await Geolocator.isLocationServiceEnabled();
    if (ser == false) {
      // ignore: avoid_single_cascade_in_expression_statements
      AwesomeDialog(
          context: context,
          //  title: Text("services"),
          body: Text("S not enabled"))
        ..show();
    }
    per = await Geolocator.requestPermission();
    if (per == LocationPermission.denied)
      per = await Geolocator.requestPermission();

    return per;
  }



  late Position myP;
  double? lat, long;

  Future<void> getLatAndLong() async {
    myP = await Geolocator.getCurrentPosition().then((value) => value);
    lat = myP.latitude;
    long = myP.longitude;
    
   
  }
  Future <void>setPos() async {

    var url = await"http://172.19.32.48:80/myProf/setNewPos?UserId=$UID&LAT=$lat&LONG=$long";

    var response = await http.post(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }

  
  @override
  Widget build(BuildContext context) {
           getPer(context);
  getLatAndLong();
    getEamil();
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      appBar: AppBar(
            title: Row(
          children: [
             SizedBox(width: 20,),
            Text(name,style: TextStyle(fontSize: 20),),
           SizedBox(width: 12,),
           CircleAvatar(
                radius: 22, // Image radius
                backgroundImage: NetworkImage(UrlImage),
              ),
      
          ],
        ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
         actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 254, 255, 254),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
            },
          ),
        ],
        ),
       drawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('',style:TextStyle(fontSize: 18,color: Color.fromARGB(255, 243, 243, 243)),), accountEmail: Text(name,style:TextStyle(fontSize: 20,color: Color.fromARGB(255, 243, 243, 243)),),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage(UrlImage),fit: BoxFit.cover),

                 ),

                ),
               
             
                SizedBox(height: 20,),
                 ListTile(
                    title: Text(" تقديم شكوى ",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.drafts_sharp),
                    subtitle: Text(" Make a complaint"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => myComplaint(UserId:UID)));
                    },

                ),
                  SizedBox(height: 20,),

             
              ListTile(
                    title: Text("  تحديث موقعي ",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.edit_location_alt_sharp),
                    subtitle: Text(" My location"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                                   setPos().then((value) =>{

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('تم تحديث الموقع')) ),
                      });


                    },

                ),
               SizedBox(height: 20,),

                 ListTile(
                    title: Text("العطاءات",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.grading_outlined),
                    subtitle: Text("مناقصات و عطاءات"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                               
                        Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => Tenders(UserId:UID,name:name,
        UrlImage:UrlImage,)));
                    },

                ),
                SizedBox(height: 20,),

               ListTile(
                    title: Text("الاعدادات",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.settings),
                    subtitle: Text("Settings"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
                    },
                ),
              Center(
              child: OutlinedButton(
                
                onPressed: () async {
                              out();
                             await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: const Text("تسجيل الخروج",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
            )


            ],

          ),


      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(UID).collection('messages').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length < 1){
              return Center(
                child: Text("اضغط على العدسة بالاسفل و ابدأ بالمحادثة "),
              );
            }
            return ListView.builder(
            //  reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_msg'];
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                  builder: (context,AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      var friend = asyncSnapshot.data;
                      return Directionality(textDirection: TextDirection.rtl, 
                      
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 45, // Image radius
                            backgroundImage: NetworkImage(friend['image']),
                          ),
                        title: Text(friend['name'],style: TextStyle(fontSize: 18),),
                        subtitle: Container(
                          child: Text("$lastMsg",style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                            currentUser: user,
                             friendId: friend['uid'],
                              friendName: friend['name'],
                               friendImage: friend['image'],
                                friendToken: friend['token'],
                                name:name,
                                UrlImage:UrlImage,
                               )));
                        },
                      ),
                      
                      
                      );
                    }
                    return LinearProgressIndicator();
                  },

                );
              });
          }
          return Center(child: CircularProgressIndicator(),);
        }),

      floatingActionButton: FloatingActionButton(
         backgroundColor: Color.fromARGB(255, 66, 64, 64),
        child: Icon(Icons.search,color: Color.fromARGB(255, 255, 255, 255),size: 25,),
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(
            user:user,
              name:name,
              UrlImage:UrlImage,
           
           )));
        },
      ),
      
    )
    
    );
  }
}