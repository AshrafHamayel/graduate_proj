// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'Chats/screens/chat_screen.dart';
import 'Chats/screens/home_screen.dart';
import 'EditProfile.dart';
import 'MapTwoUser.dart';
import 'Ratings.dart';
import 'ResultFollow.dart';
import 'SettingsPage.dart';
import 'complaint.dart';
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

class workerProfile extends StatelessWidget {
  late final String UserId;
   late final String CurrentUser;

             late final String name;
   late final String UrlImage;
    workerProfile
    ({
    required this.UserId,
   required this.CurrentUser,
       required this.name,
    required this.UrlImage,
  });
  
 
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: workerProfile_Page( UserId:UserId, CurrentUser:CurrentUser,
      name:name,
        UrlImage:UrlImage,),
    
      appBar:  AppBar(
        elevation: 3,
        title:Text('صفحة العامل'),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),

    ),
    
    );
  }
}

class workerProfile_Page extends StatefulWidget {

 late final String UserId;
   late final String CurrentUser;
                 late final String name;
   late final String UrlImage;
    workerProfile_Page
    ({
    required this.UserId,
   required this.CurrentUser,
         required this.name,
    required this.UrlImage,
  });
  
  @override
  _WorkerProfilePage createState() => _WorkerProfilePage(
    UserId:UserId,
   CurrentUser:CurrentUser,
   name:name,
  UrlImage:UrlImage,
  );
}
     late UserModel Frind;
    late UserModel currentUser1;

class _WorkerProfilePage extends State<workerProfile_Page> {

   
   late final String UserId;
   late final String CurrentUser;
  late final String name;
   late final String UrlImage;
    _WorkerProfilePage
    ({
    required this.UserId,
   required this.CurrentUser,
         required this.name,
    required this.UrlImage,
  }); 



  Future <void>getInfo() async {

    var url = await"http://172.19.32.48:80/myProf/frindProf?frindId=$UserId&currentUser=$CurrentUser";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
       print('responsebody from line 167');

    //   print(responsebody);
    //  if(responsebody['pressAttention'].toString()=='true')
    //  pressAttention=true;
    //  if(responsebody['pressAttention'].toString()=='false')
    //  pressAttention=false;
    return await responsebody;
 

  }

 Future <void>AddToFavorites() async {

    var url = await"http://172.19.32.48:80/myProf/AddToFavorites?frindId=$UserId&currentUser=$CurrentUser";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    return await responsebody;
 

  }

Future <void>RemoveFromFavourites() async {

    var url = await"http://172.19.32.48:80/myProf/removeFromFavourites?frindId=$UserId&currentUser=$CurrentUser";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    return await responsebody;
 

  }






  final Storage storage=Storage();
 

   late String pathes='NOooo';


 late final String imageName;


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final imagepicker = ImagePicker();

  Widget _buildProfileImage(BuildContext context ,String imagee ,String Type) {
    if(Type=='Google')
    {
       return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("$imagee")
                        )),
          ),

        ],
      ),
    );
    }
    
       else{
 
                      return  FutureBuilder<String>(
                        future: storage.downloadURL(imagee),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String NewUrl=snapshot.data!.toString();
                                FirebaseFirestore.instance.collection('users').doc(UserId).update({'image':NewUrl});

                                return  Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color: Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 10))
                                        ],
                                        shape: BoxShape.circle,
                                        image:  DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage("$NewUrl")
                                                )),
                                  ),
                                  
                                ],
                              ),
                            );
                      } 
                                                    else 
                                                    {
                                                        return CircularProgressIndicator();
                                                    }
                                                },  
                                              );
                              
    }
   
  }

  Widget _buildFullName( String _fullName) {
    TextStyle _nameTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

  
         return Text(
      _fullName,
      style: _nameTextStyle,
    );
    
  }

   Widget _buildStatus(BuildContext context ,String RT,String Work,String city,String phoneN ,String Salary,String AVIL) {
    
              bool RTI=false;
            if(RT=='false'||RT=='NaN'||RT=='0')
           {
            RTI =true;
           }

             bool Avlia=true;
            if(AVIL=='false')
           {
            Avlia =false;
           }


           
               
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
       child: Column(
    // scrollDirection: Axis.vertical,
    // shrinkWrap: true,
            
            children: <Widget>[

             RTI?
             ListTile(
              title: Text( ' لا يمكن عرض التقييمات', style: const TextStyle( color: Color.fromARGB(255, 255, 0, 0), fontSize: 17.0,fontWeight:FontWeight.bold ), ),
                    leading: Icon(Icons.group_off_outlined,size: 30,color: Color.fromARGB(255, 255, 0, 0),),
                    subtitle: Text("لم يقم اي شخص بتقييمه بعد",style: TextStyle(fontSize: 12.5),),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){

                      


                    },

                ):ListTile(
              title: Text( 'التقييمات', style: const TextStyle( color: Color.fromARGB(255, 25, 0, 255), fontSize: 25.0,fontWeight:FontWeight.bold ), ),
                    leading: Icon(Icons.star,size: 50,color: Color.fromARGB(255, 204, 206, 125),),
                    subtitle: Text(" عرض سجل التقييمات",style: TextStyle(fontSize: 16),),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){

                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Ratings(UserId:UserId)), (route) => true);


                    },

                ),



              
             Avlia?
             ListTile(
              title: Text( ' متاح للعمل', style: const TextStyle( color: Color.fromARGB(255, 79, 184, 85), fontSize: 17.0,fontWeight:FontWeight.bold ), ),
                    leading: Icon(Icons.add_task_rounded,size: 30,color: Color.fromARGB(255, 79, 184, 85),),
                    subtitle: Text("انقر هنا لتغيير الحالة",style: TextStyle(fontSize: 12.5),),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ):ListTile(
              title: Text( 'غير متاح للعمل', style: const TextStyle( color: Color.fromARGB(255, 255, 0, 0), fontSize: 17.0,fontWeight:FontWeight.bold ), ),
                    leading: Icon(Icons.person_off_outlined,size: 30,color: Color.fromARGB(255, 255, 0, 0),),
                    subtitle: Text("انقر هنا لتغيير الحالة",style: TextStyle(fontSize: 12.5),),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){ },

                ),

              ListTile(
              title: Text( Work, style: const TextStyle( color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.handyman,size: 30,color: Color.fromARGB(255, 35, 36, 17),),
                    subtitle: Text(" المهنة"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),

                 ListTile(
              title: Text(city, style: const TextStyle( color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.location_pin,size: 30,color: Color.fromARGB(255, 8, 20, 187),),
                    subtitle: Text(" المدينة "),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MapTwoUser(currentUser:CurrentUser, UserId:UserId)));
                    },

                ),
 ListTile(
              title: Text( phoneN, style: const TextStyle( color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.phone,size: 30,color: Color.fromARGB(255, 34, 23, 59),),
                    subtitle: Text(" رقم الهاتف  "),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),

                 ListTile(
              title: Text( Salary, style: const TextStyle( color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.attach_money,size: 30,color: Color.fromARGB(255, 22, 53, 29),),
                    subtitle: Text(" اجرة العمل اليومي بالشيكل"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),


            ])
       
       
        
      
      
      
    );
  }
  Widget _buildStatItem(String label, String count) {

    if(label=='المتابعون'){

 TextStyle _statLabelTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 21.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

         Text(
          label,
          style: _statLabelTextStyle,
        ),

          TextButton(
            
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 22,fontWeight:FontWeight.bold),
              
            ),
            onPressed: () {
              
    
            },
            child:  Text(count),
            
          ),

       
      ],
    );
    }
    else{

       TextStyle _statLabelTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 21.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

         Text(
          label,
          style: _statLabelTextStyle,
        ),

          TextButton(
            
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 22,fontWeight:FontWeight.bold),
              
            ),
            onPressed: () {
              
      
              
            },
            child:  Text(count,style: TextStyle( color: Color.fromARGB(134, 14, 109, 1),),),
            
          ),

       
      ],
    );
    }
   
  }

  Widget _buildStatContainer(String _followers,String Ifollow ) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          
          _buildStatItem("المتابعون", _followers),

           _buildStatItem("يُتابعه", Ifollow),
        
        
          
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context ,String _bio) {
    TextStyle bioTextStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
       // style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }



  Future<List> getUserPosts() async {

    final  url = "http://172.19.32.48:80/addPost/myPosts?UserId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();
 
}

 Future <bool>AddLike(String idPost) async {

    var url = await"http://172.19.32.48:80/addPost/AddLike?currentUser=$UserId&PostId=$idPost";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    bool t=true;
    return  t;
 

  }


  Widget _buildStatPosts(String namePost,String description,String ImageUserURL, String ImageURL ,String Nlike,String DatePost, String postID) {
               var LikesNumber =0;


                          if(Nlike.length>3)
                          {
                          final NN = Nlike.split(',');
                          LikesNumber = int.parse(NN.length.toString());
                          }
                          

                         bool IsFind=Nlike.contains(UserId);

                      return  FutureBuilder<String>(
                        future: storage.downloadURLPost(ImageURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String ImageURLPost=snapshot.data!.toString();



                       return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageUserURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String UserPostURL=snapshot.data!.toString();

                                  
  return Container(
    margin: const EdgeInsets.all(10.0),
    color: Color.fromARGB(255, 239, 245, 237),
     width: MediaQuery.of(context).size.width * 0.95,
    height: MediaQuery.of(context).size.height * 0.68,
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
                onTap: () {},
              ),
             width: MediaQuery.of(context).size.width * 0.86,
    height: MediaQuery.of(context).size.height * 0.4195,
              fit: BoxFit.cover,
            ),
            
          ],
        ),
        
      ),
     
       Row(
                        children: <Widget>[
                          SizedBox(width: 30,),
                            LikeButton(
                               size: 36,
                               likeCount: LikesNumber,
                                onTap:(hhh)=>AddLike(postID),
                                   likeBuilder: (hh) {
                                                  return Icon(
                                                    Icons.thumb_up_alt,
                                                    color: IsFind ? Color.fromARGB(255, 6, 42, 245) : Colors.grey,
                                                    size: 36,
                                                  );
                                                },
                            ),
                            SizedBox(width: 18,),
                            IsFind ?   Text('اعجبك',  style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 22, 7, 7), fontSize: 16, ),):
                                       Text('اعجبني',  style: TextStyle(color: Color.fromARGB(255, 85, 84, 84), fontSize: 14, ), ),
                        ],
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


  
    
    Future<void>  navigateToNextScreen() async
    {

          DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(CurrentUser).get();
       
          currentUser1 = UserModel.fromJson(userData);

          DocumentSnapshot userData2 = await FirebaseFirestore.instance.collection('users').doc(UserId).get();

          Frind = UserModel.fromJson(userData2);
               
        
    }


Widget _buildButtons(String Fav1) {

     bool Fav=true;
            if(Fav1=='true'||Fav1=='0')
           {
            Fav =false;
           }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child:Fav? InkWell(
              onTap: () => {
                AddToFavorites().then((value) =>{
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:UserId , CurrentUser:CurrentUser,name:name,
        UrlImage:UrlImage,)), (route) => true),
                      })
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color:Color(0xFF404A5C),
                ),
                child:Center(
                  child: Text( "متابعة",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ),
            ):InkWell(
              onTap: () => {
                RemoveFromFavourites().then((value) =>{
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:UserId , CurrentUser:CurrentUser,name:name,
        UrlImage:UrlImage,)), (route) => true),
                      })
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color:Colors.blue,
                ),
                child:Center(
                  child: Text( "تمت المتابعة",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => {
                     
                   
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(

                             currentUser:currentUser1, 
                             friendId: Frind.uid,
                              friendName: Frind.name,
                               friendImage: Frind.image,
                               friendToken: Frind.token,
                                  name:name,
                                 UrlImage:UrlImage,
                               ))),



              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "مراسلة",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
late String downloadURL;


  Widget buildResultRating(String RE){
        print('RE =');
        print(RE);

           if(RE=='false'||RE=='NaN'||RE=='0')
           {
            return  Text('-',style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 202, 16, 16)),);
           }
           
               else{

                 var Rea = double.parse(RE);
                return RatingBar.builder(
                initialRating: Rea,
                minRating: 1,
                allowHalfRating: true,
                itemSize: 25,
                itemBuilder: (context, _) =>Icon(Icons.star,color: Colors.amber,) ,
                updateOnDrag: true,
                onRatingUpdate:(rating) => setState(() {}),

              );

               }
         

  }
  
 

  Widget _buildStatusNotWorker(BuildContext context,String city) {
    
        
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
       child: ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
            
            children: <Widget>[

               ListTile(
              title: Text( 'هذا الحساب للمستخدين الغير عمال', style: const TextStyle( color: Color.fromARGB(255, 120, 173, 241), fontSize: 15.0,fontWeight:FontWeight.bold ), ),
                    leading: Icon(Icons.admin_panel_settings,size: 25,color: Color.fromARGB(255, 56, 56, 100),),
                    subtitle: Text("  ",style: TextStyle(fontSize: 16),),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){

                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Ratings(UserId:UserId)), (route) => true);


                    },

                ),


             
            

           
                 ListTile(
              title: Text(city, style: const TextStyle( color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.location_pin,size: 30,color: Color.fromARGB(255, 8, 20, 187),),
                    subtitle: Text(" مكان السكن "),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),

            


            ])
       
       
        
      
      
      
    );
  }



  @override

  Widget build(BuildContext context) {
       
    Size screenSize = MediaQuery.of(context).size;
    
    navigateToNextScreen();

         return Container (
      
      child: Scaffold(
        
         body: FutureBuilder(
                     future:getInfo() ,
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   {   
           
       if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
       {


                if(snapshot.data["UserType"].toString()=='true')
       {

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 18.0),

                       
                     _buildProfileImage(context,snapshot.data["image"].toString(),snapshot.data["Type"].toString()),
                     _buildFullName(snapshot.data["name"].toString()),
                      _buildBio(context,snapshot.data['description'].toString()),
                     
                      _buildSeparator2(screenSize),
                      _buildStatusNotWorker(context,snapshot.data['city'].toString()),

                      _buildStatContainer(snapshot.data['followers'].toString(),snapshot.data['Ifollow'].toString()),
                      const SizedBox(height: 10.0),
                      _buildButtons(snapshot.data['fav'].toString()),
                      const SizedBox(height: 8.0),
                    //  _buildSeparator2(screenSize),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          );
       }
       else{
          
         return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 18.0),

                       
                     _buildProfileImage(context,snapshot.data["image"].toString(),snapshot.data["Type"].toString()),
                     _buildFullName(snapshot.data["name"].toString()),
                      _buildBio(context,snapshot.data['description'].toString()),
                        buildResultRating(snapshot.data['rating'].toString()),
                       

                      _buildSeparator2(screenSize),

                      _buildStatus(context,snapshot.data['rating'].toString(),snapshot.data['work'].toString(),snapshot.data['city'].toString(),snapshot.data['phoneNumber'].toString(),snapshot.data['Salary'].toString(),snapshot.data['Availability'].toString()),
                      _buildStatContainer(snapshot.data['followers'].toString(),snapshot.data['Ifollow'].toString()),
                      const SizedBox(height: 10.0),
                      _buildButtons(snapshot.data['fav'].toString()),
                      const SizedBox(height: 8.0),
                    //  _buildSeparator2(screenSize),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),


 
                      Container(
                height: 470,
                child: FutureBuilder<List>(
                                      future: getUserPosts(),
                                      builder: (context,snapshot){    


                                       if (snapshot.hasData)
                                         {
                                           
                                         return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                     
                                                return _buildStatPosts(snapshot.data![index]['name'].toString(),snapshot.data![index]['description'].toString(),snapshot.data![index]['imageuser'].toString(),snapshot.data![index]['imagepost'].toString(),snapshot.data![index]['Like'].toString(),snapshot.data![index]['date'].toString(),snapshot.data![index]['_id'].toString());
                                                  },
                                                );
                                         }
                                        
                                     return  Text('  ');
                                        
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
          
          
         },
        ),
      ),
    ); 
     
   
  }
}
