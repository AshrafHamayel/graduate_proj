// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/search.dart';
import 'package:graduate_proj/workerProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'EditProfile.dart';
import 'Ratings.dart';
import 'SettingsPage.dart';
import 'UsersInMap.dart';
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
import 'package:custom_info_window/custom_info_window.dart';

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


 Widget buildStatCardOnMap(String nameUser,String WorkUser,String ImageUserURL, String UserId,String currentUser) {

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



  Future <void>getInfo() async {

    var url = await"http://192.168.0.114:80/myProf/myProf?UserId=$currentUser";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }
CustomInfoWindowController _customInfoWindowController=CustomInfoWindowController();
Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

late String downloadURL;

  @override

  var myIcon;
   var WorkerIcon;

bool mapVis=false;
void initState() {
          mapVis=!mapVis;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(35, 35)), 'images/pp.png').then((onValue) { myIcon = onValue; });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(30, 30)), 'images/Workerr.png').then((onValue1) { WorkerIcon = onValue1; });

 }

  Widget build(BuildContext context) {
       
    Size screenSize = MediaQuery.of(context).size;
    


         return   FutureBuilder(
          future:getInfo(),
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   
   {   
    
    if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)

       {
             var LatUser = double.parse(snapshot.data["latitude"].toString());
             var LongUser = double.parse(snapshot.data["longitude"].toString());
           CameraPosition  kGooglePlex = CameraPosition(
      target: LatLng(LatUser, LongUser),
      zoom: 12,
    );
   


                                                      final MarkerId MymarkerId = MarkerId(snapshot.data['_id'].toString());
                                              final Marker myMark =Marker(
                                                      
                                                      markerId: MarkerId(snapshot.data["_id"].toString()),
                                                    position: LatLng(LatUser, LongUser),
                                                   
                                                    
                                                     onTap:(){ 
                                                      _customInfoWindowController.addInfoWindow!(
                                                        Text('هذا انت  ',style: TextStyle(fontSize:30,color: Color.fromARGB(20, 7, 3, 247))),
                                                        LatLng(LatUser, LongUser),
                                                      );
                                                     },
                                                     
                                                     icon:myIcon,
                                                     );

                                                 markers[MymarkerId] = myMark;

                                                late var LatUser1;
                                                 late var LongUser1;
                                                  
          return  Column(
          
                children: [
                       Container(
                            height: 530,
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
                                                        LatUser1 = double.parse(snapshot.data![index]["latitude"].toString());
                                                        LongUser1 = double.parse(snapshot.data![index]["longitude"].toString());
                          
                                                        final MarkerId markerId = MarkerId(snapshot.data![index]['name'].toString());
                                                       print(LatUser1);
          
                                                       final Marker marker =Marker(
                                                        
                                                      markerId: MarkerId(index.toString()),
                                                      position: LatLng(LatUser1, LongUser1),
                                                      icon: BitmapDescriptor.defaultMarker,
                                                         onTap:(){ 
                                                      _customInfoWindowController.addInfoWindow!(
                                                        
                                   buildStatCardOnMap(snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['image'].toString(),snapshot.data![index]['_id'].toString(),currentUser),

                                                          // Container(
                                                          //    height:MediaQuery.of(context).size.height *0.15,
                                                          //    width: MediaQuery.of(context).size.width,
                                                          //     decoration: BoxDecoration(
                                                          //       color: Colors.white,
                                                          //       border: Border.all(color:Colors.grey),
                                                          //       borderRadius:  BorderRadius.circular(10.0),
          
                                                          //     ),
                                                          //     child: Column(
                                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                                          //       children: [
                                                          //         Container(
                                                          //           height:MediaQuery.of(context).size.height *0.15,
                                                          //          width: MediaQuery.of(context).size.width,
                                                          //           decoration:const BoxDecoration(
                                                          //             image: DecorationImage(
                                                          //               image: NetworkImage('https://www.mapitstudio.com/wp-content/uploads/2021/04/sieninis-medinis-pasaulio-zemelapis-su-saliu-valstybiu-pavadinimais-kelioniu-zemelapis-azuolas-map-it-studio.jpg'),
                                                          //               fit: BoxFit.fitWidth,
                                                          //               filterQuality: FilterQuality.high),
                                                          //               borderRadius: const BorderRadius.all(Radius.circular(10.0),
                                                          //               ),
                                                          //               color: Colors.red,
                                                          //           ),
                                                          //         ),
          
                                                          //       ],
          
                                                          //     ),
                                                          // ),
                                                          LatLng(LatUser1, LongUser1),
                                                       );
                                                       }
                                                       );
          
                                                  
                                                    markers[markerId] = marker;
                                                  
                                                 if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
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
                ),
 SizedBox(height: 20,),
                Row(
                  children: [

    SizedBox(width:10,),
              
Text('اضغط هنا للعرض على الخريطة',style: TextStyle(fontSize: 20),),
Text('  >',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 65, 67, 73)),),
    SizedBox(width:20,),

        FloatingActionButton(
         backgroundColor: Color.fromARGB(255, 82, 133, 241),
        child: Icon(Icons.map,color: Color.fromARGB(255, 255, 255, 255),size: 25,),
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersInMap(
           
           markers:markers,
          currentUser:currentUser,
          kGooglePlex:kGooglePlex,
        customInfoWindowController:_customInfoWindowController,
        mapVis:mapVis,

           )));
        },
      ),

      
                  ],
                )
          

                ],
          
            
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


);

       

        
      
         
         
         
         
         
         
         
         
         
         
         
         
         
     
   
  }
}



//  Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children:<Widget>[
//               Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//                child:ElevatedButton.icon(

//            onPressed: ()async{
            
            
//           }, 
//           icon: Icon(Icons.map_outlined),  //icon data for elevated button
//           label: Text("عرض على الخريطة",style:TextStyle(fontSize: 17),), //label text 
//           style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 56, 53, 53)),
//                 padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12,horizontal: 70)),

//               ),


//                   ) 
//             ),
//           ]
//           ),