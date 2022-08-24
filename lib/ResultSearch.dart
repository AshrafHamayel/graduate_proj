// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/search.dart';
import 'package:graduate_proj/workerProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'EditProfile.dart';
import 'Ratings.dart';
import 'SettingsPage.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'mainPage.dart';
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ResultSearch extends StatelessWidget {
  late final String currentUser;
  late final String NameWorker;
  late final String Work;
  late final String City;
    late final String closest;

    ResultSearch
    ({
    required this.currentUser,
    required this.NameWorker,
    required this.Work,
    required this.City,
      required this.closest,
  
  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: ResultSearch_Page( 
         currentUser:currentUser,
    NameWorker:NameWorker,
    Work:Work,
    City:City,
    closest:closest,
      ),
    
      appBar: AppBar(
        
        // toolbarHeight: 30,
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SearchWorker(currentUser:currentUser)));
            },
          ),
        ],
      ),

    ),
    
    );
  }
}

class ResultSearch_Page extends StatefulWidget {

    late final String currentUser;
  late final String NameWorker;
  late final String Work;
  late final String City;
   late final String closest;
    ResultSearch_Page
    ({
    required this.currentUser,
    required this.NameWorker,
    required this.Work,
    required this.City,
     required this.closest,
  });
  
  @override
  _ResultSearch createState() => _ResultSearch(
    currentUser:currentUser,
    NameWorker:NameWorker,
    Work:Work,
    City:City,
    closest:closest,
  );
}

class _ResultSearch extends State<ResultSearch_Page> {


   late final String currentUser;
  late final String NameWorker;
  late final String Work;
  late final String City;
   late final String closest;
    _ResultSearch
    ({
    required this.currentUser,
    required this.NameWorker,
    required this.Work,
    required this.City,
    required this.closest,
  
  });



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




Future<List> SendInfoSearch() async
  { 
    final  url = "http://192.168.0.114:80/search/getResultSearch?currentUser=$currentUser&nameWorker=$NameWorker&work=$Work&city=$City&closest=$closest";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body) as List<dynamic>;
    print('responsebody ---------Search');
    print(responsebody);
    return responsebody.reversed.toList();

  }




 Widget buildStatCard(String nameUser,String WorkUser,String ImageUserURL, String UserId,String currentUser) {

        return  FutureBuilder<String>(
      future: storage.downloadURL(ImageUserURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                             if (snapshot.hasData)
                             {
                                String UserImage=snapshot.data!.toString();
                                return  Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                       
                          Container(
                            height: 55,
                            width: 55,
                            child:  CircleAvatar(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.green,
                              backgroundImage: NetworkImage(UserImage),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                             Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  <Widget>[
                              Text(
                                nameUser,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                WorkUser,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: FlatButton(
                          onPressed: () {

                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:UserId , CurrentUser:currentUser,)), (route) => true);
                          },
                          color: Color.fromARGB(255, 51, 54, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'تواصل ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
                                
                            }
                            else 
                                                    {
                                                      return Text('بانتظار التحميل ...');
                                                        //return CircularProgressIndicator();
                                                    }

                        }

 );
                        
 
}

late String downloadURL;

  @override

  Widget build(BuildContext context) {
       
    Size screenSize = MediaQuery.of(context).size;
    


         return   Container(
                          height: 440,
                          child: FutureBuilder<List>(
                                      future:  SendInfoSearch(),
                                       builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                          print('snapshot.data!.length');
                                          print(snapshot.data!.length);
                                          if(snapshot.data!.length>=1)
                                          {
                                              return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                                  
                                                     if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser)
                                                  return Text('',style: TextStyle(fontSize: 2),) ;
                                                 return buildStatCard(snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['image'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );

                                          }
                                           else{
                                                  return Center(
                                                    child: Text('لا يوجد نتائج مطابقة',style: TextStyle(fontSize: 35,color: Color.fromARGB(255, 252, 3, 3)),),
                                                  );

                                           }
                                       
                                         }
                                        
                                      return Center(
                                                    child: Text('جار التحميل...',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 15, 136, 61)),),
                                                  );
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ); 
     
   
  }
}
