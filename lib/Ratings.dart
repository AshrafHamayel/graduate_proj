// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'Chats/screens/home_screen.dart';
import 'EditProfile.dart';
import 'SettingsPage.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'mainPage.dart';
import 'myProfile.dart';
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Ratings extends StatelessWidget {
  late final String UserId;
    Ratings
    ({
    required this.UserId,
  
  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: Ratings_Page( UserId:UserId,),
    
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myProfile( UserId:UserId,)), (route) => false);
            },
          ),
        ],
      ),

      
    ),
    
    );
  }
}

class Ratings_Page extends StatefulWidget {

    late final String UserId;
    Ratings_Page
    ({
    required this.UserId,
  });
  @override
  _RatingsPage createState() => _RatingsPage(
    UserId:UserId,
  );
}

class _RatingsPage extends State<Ratings_Page> {


      late final String UserId;
    _RatingsPage
    ({
    required this.UserId,
  
  }); 

 
  Future <void>getInfo() async {

    var url = await"http://192.168.0.114:80/myProf/myProf?UserId=$UserId";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
      return await responsebody;
 

  }





  final Storage storage=Storage();
 FirebaseFirestore firestore = FirebaseFirestore.instance;





  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }



  Future<List> getUserComits() async
   {

    final  url = "http://192.168.0.114:80/addComit/youComits?FrindId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;
     print(responsebody);
    return responsebody.reversed.toList();
 

  }



  Widget _buildStatComit(String namePost,String description,String ImageUserURL, String ImageURL ,String DatePost,String Rating0) {


                      return  FutureBuilder<String>(
                        future: storage.downloadURLComits(ImageURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String ImageURLPost=snapshot.data!.toString();
                                  var Rating1 = double.parse(Rating0);


                       return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageUserURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String UserPostURL=snapshot.data!.toString();

                                  
  return Container(
    margin: const EdgeInsets.fromLTRB(30.0,20.0,30.0,20.0),
    color: Color.fromARGB(255, 247, 244, 213),
     width: MediaQuery.of(context).size.width * 0.70,
    height: MediaQuery.of(context).size.height * 0.60,
    child: Column(
      children: [
          ListTile(
                leading:CircleAvatar(
                radius: 45, // Image radius
                backgroundImage: NetworkImage(UserPostURL),
              ),
                        
                        title: Container(child: Text(namePost,style: TextStyle(fontSize: 18),)),
                        trailing: IconButton(
                            onPressed: () {
                              
                            },
                            icon: Icon(Icons.more_vert_outlined)
                            ),
                        isThreeLine: true,
                        subtitle: Text(DatePost),
                      ),



                    
                  RatingBar.builder(
                initialRating: Rating1,
                itemSize: 25,
                allowHalfRating: true,
                itemBuilder: (context, _) =>Icon(Icons.star,color: Colors.amber,) ,
                updateOnDrag: true,
                onRatingUpdate:(rating) {},

              ),

         Row( 
               children:  [
                  const SizedBox(width: 30.0),
                Text(description,  style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 22, 7, 7), fontSize: 15, ),
            ),
               ],
            ),


       Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(ImageURLPost),
            //  colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                       

                },
              ),
             width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.cover,
            ),
            
          ],
        ),
        
      ),
     
     
        _buildSeparator2(MediaQuery.of(context).size),


      ]

  ),
  );
   
                            } 
                                                   
                                                   
                                                   
                                                    else 
                                                    {
                                                      return Text('بانتظار التحميل ...');
                                                        //return CircularProgressIndicator();
                                                    }
                                                },  
                                              );







                               
                            } 
                                                    else 
                                                    {
                                                        return CircularProgressIndicator();
                                                    }
                                                },  
                                              );
                              
         
  }

late String downloadURL;

  @override

  Widget build(BuildContext context) {
       
    Size screenSize = MediaQuery.of(context).size;
    


         return Container (
      
      child: Scaffold(
        
         body: FutureBuilder(
                     future:getInfo() ,
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   {   

       if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
       {
       

       return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: screenSize.height / 18.0),


                    
                     
                      _buildSeparator2(screenSize),
                      const SizedBox(height: 20.0),
                       Text('الاشخاص القادرين على التقييم هم فقط من يوجد معهم محادثة خاصة',style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 2, 92, 29)),),
                    const SizedBox(height: 20.0),
                   _buildSeparator2(screenSize),
                      const SizedBox(height: 10.0),
                     
                      const SizedBox(height: 8.0),
                   
                    //  _buildSeparator2(screenSize),
                      SizedBox(
                        height: 10,
                      ),
              
                      SizedBox(
                        height: 50,
                      ),
                       Text('التقييمات التي تم حفظها ',style: TextStyle(fontSize: 20),),
                     
                       Container(
                height: 440,
                child: FutureBuilder<List>(
                                      future: getUserComits(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                     
                                           return _buildStatComit(snapshot.data![index]['name'].toString(),snapshot.data![index]['description'].toString(),snapshot.data![index]['imageuser'].toString(),snapshot.data![index]['imagecomit'].toString(),snapshot.data![index]['date'].toString(),snapshot.data![index]['rating'].toString());
                                                  },
                                                );
                                         }
                                        
                                   return  Text('  '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
                     
                     
     
                    ],
                  ),
                ),
              ),
            ],
          );
            }
          return Center(      
                  child: Text('  '),


                  );
          
          
         },
        ),
      ),
    ); 
     
   
  }
}
