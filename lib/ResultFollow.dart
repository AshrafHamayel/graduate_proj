// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'myProfile.dart';
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class FollowResult extends StatelessWidget {
  late final String UserId;
    late final String Type;
     late final String CurrentUser;
              late final String name;
   late final String UrlImage;

    FollowResult
    ({
    required this.UserId,
      required this.Type,
    required this.CurrentUser,
          required this.name,
    required this.UrlImage,

  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
    

  @override
 
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: FollowResult_Page(UserId:UserId,
    Type:Type,
        CurrentUser:CurrentUser,
        name:name,
        UrlImage:UrlImage,

),
    
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myProfile( UserId:UserId,name:name,
        UrlImage:UrlImage,)), (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text('المتابعون'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),

    ),
    
    );
  }
}

class FollowResult_Page extends StatefulWidget {

    late final String UserId;
    late final String Type;
     late final String CurrentUser;
                   late final String name;
   late final String UrlImage;
    FollowResult_Page
    ({
   required this.UserId,
      required this.Type,
    required this.CurrentUser,
          required this.name,
    required this.UrlImage,
  });
  @override
  _FollowResultPage createState() => _FollowResultPage(
    UserId:UserId,
    Type:Type,
    CurrentUser:CurrentUser,
    name:name,
        UrlImage:UrlImage,
  );
}

class _FollowResultPage extends State<FollowResult_Page> {


  late final String UserId;
    late final String Type;
     late final String CurrentUser;
                   late final String name;
   late final String UrlImage;
    _FollowResultPage
    ({
     required this.UserId,
      required this.Type,
    required this.CurrentUser,

      required this.name,
    required this.UrlImage,
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

Future<List> getFollow() async {

    final  url = "http://172.19.32.48:80/myProf/getFollow?UserId=$UserId&Type=$Type";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();
 

  }



 Widget _buildStatApplicants(String nameUser,String desUser,String ImageUserURL, String UserId,String currentUser) {

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
                            child:CircleAvatar(
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
                                desUser,
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

                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:UserId , CurrentUser:currentUser,name:name,
        UrlImage:UrlImage,)), (route) => true);
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
    


         return  Container(
                height: 440,
                child: FutureBuilder<List>(
                                      future: getFollow(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                     
                                 return  _buildStatApplicants(snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['image'].toString(),snapshot.data![index]['_id'].toString(),CurrentUser);
                                                  },
                                                );
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              );
     
   
  }
}
