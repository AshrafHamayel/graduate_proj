// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'EditProfile.dart';
import 'Ratings.dart';
import 'SettingsPage.dart';
import 'Tenders.dart';
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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Post extends StatelessWidget {
  late final String UserId;
        late final String name;
   late final String UrlImage;
    Post
    ({
    required this.UserId,
        required this.name,
    required this.UrlImage,
  
  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


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

    var url = await"http://172.19.32.48:80/myProf/setNewPos?UserId=$UserId&LAT=$lat&LONG=$long";

    var response = await http.post(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }

  
  @override
  
  Widget build(BuildContext context) {
           getPer(context);
  getLatAndLong();
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(

      body: Posts_Page(
         UserId:UserId,  
         name:name,
        UrlImage:UrlImage,),
    
      appBar:   AppBar(
        
        elevation: 3,
       title: Row(
          children: [
             SizedBox(width: 20,),
            Text('المنشورات',style: TextStyle(fontSize: 20),),
           SizedBox(width: 12,),
     
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
         actions:<Widget> [
IconButton(
  onPressed: (){  
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
       }, 
       
           icon: Icon(Icons.arrow_forward)
)
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => myComplaint(UserId:UserId)));
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
                               
                        Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => Tenders(UserId:UserId,name:name,
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
    ),
    
    );
  }
}

class Posts_Page extends StatefulWidget {

    late final String UserId;
          late final String name;
   late final String UrlImage;
    Posts_Page
    ({
    required this.UserId,
        required this.name,
    required this.UrlImage,
  
  });
  @override
  _PostsPage createState() => _PostsPage(
    UserId:UserId,
      name:name,
        UrlImage:UrlImage,
  );
}

class _PostsPage extends State<Posts_Page> {


      late final String UserId;
            late final String name;
   late final String UrlImage;
    _PostsPage
    ({
    required this.UserId,
        required this.name,
    required this.UrlImage,
  
  }); 


  Future <void>getInfo() async {

    var url = await"http://172.19.32.48:80/myProf/myProf?UserId=$UserId";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }





  final Storage storage=Storage();
 

  late File _file;

   late String pathes='NOooo';
uploadImage() async {
    return await showDialog(context: context, 
builder: (context){
return AlertDialog(
  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
              const SizedBox(height: 20),

       Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
               child:ElevatedButton.icon(

           onPressed: ()async{
           var pickedImage = await imagepicker.getImage(source: ImageSource.camera);
         if (pickedImage != null) {
      _file = File(pickedImage.path);
      final imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

       storage.uploadFile(path,imageName).then((value) =>
       {

        
         
        sendToDB(imageName).then((value) =>{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Post( UserId:UserId,name:name,UrlImage:UrlImage,)), (route) => false),
        }),

       }
       );
    
    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
              return;
 
          }, 
          icon: Icon(Icons.camera_alt_outlined),  //icon data for elevated button
          label: Text("اللتقاط صورة ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 143, 140, 140)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),

          Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child:ElevatedButton.icon(

           onPressed: ()async{
             var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
           if (pickedImage != null) {
      _file = File(pickedImage.path);
      final imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

       storage.uploadFile(path,imageName).then((value) =>
       {

        
         
        sendToDB(imageName).then((value){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Post( UserId:UserId,name:name, UrlImage:UrlImage,)), (route) => false);
        }),

       }
       );
    
    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
    return;
           
          }, 
          icon: Icon(Icons.image),  //icon data for elevated button
          label: Text(" اختر من المعرض ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 70, 6, 245)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),
    ],
  )
  
  
  )
  
  ),

);
}

);
  }
late File _filePost;
 late final String imageName;

Future<void> showcamera(BuildContext context)async{
return await showDialog(context: context, 
builder: (context){
return AlertDialog(
  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
              const SizedBox(height: 20),

       Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
               child:ElevatedButton.icon(

           onPressed: ()async{
           var pickedImage = await imagepicker.getImage(source: ImageSource.camera);
            if (pickedImage != null) {
      _filePost = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadImagesPost(path,imageName).then((value) =>
       {

        print(' upload Image Post done'),
         
       
       }
       );
   

    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
              return;
 
          }, 
          icon: Icon(Icons.camera_alt_outlined),  //icon data for elevated button
          label: Text("اللتقاط صورة ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 143, 140, 140)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),

          Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child:ElevatedButton.icon(

           onPressed: ()async{
             var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
              if (pickedImage != null) {
      _filePost = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadImagesPost(path,imageName).then((value) =>
       {

        print(' upload Image Post done'),
         
       
       }
       );
   

    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
    return;
           
          }, 
          icon: Icon(Icons.image),  //icon data for elevated button
          label: Text(" اختر من المعرض ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 70, 6, 245)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),
    ],
  )
  
  
  )
  
  ),

);
}

);
}


Future<void> showPost(BuildContext context)async{
return await showDialog(context: context, 
builder: (context){

  
  final TextEditingController _textController =TextEditingController();
return AlertDialog(
  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
      TextFormField(
        controller: _textController,
        validator:((value) {
          return value!.isNotEmpty ?null:"غير صحيح";
      
        }
        ),
        decoration:InputDecoration(hintText:"ادخل وصف"),
      ),
              const SizedBox(height: 20),

      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
       
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: MediaQuery.of(context).size.height * 0.12,
                  image:FileImage(_filePost),
                  child: InkWell(
                    onTap: () {
                      
                          
                    },
                    child: const Align(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white70,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    ],
  )
  
  
  )
  
  ),
  actions:<Widget> [
TextButton(onPressed: (){  
             
       sendPostToDB(_textController.text,imageName);

       }, child: Text("نشر",style:const TextStyle( color: Color.fromARGB(255, 22, 0, 216), fontSize: 17.0,),))
  ],
);
}

);
}







Future sendToDB(String imagePath) async {

             var url = "http://172.19.32.48:80/myProf/saveImage?UserId=$UserId&imagePath=$imagePath";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

            

}

  FirebaseFirestore firestore = FirebaseFirestore.instance;

Future sendPostToDB(String description,String imagepost ) async 
{

             var url = "http://172.19.32.48:80/addPost/newPost?UserId=$UserId&description=$description&imagepost=$imagepost";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

              if (responsebody['NT']=='done')
       {
    
          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text(' تم حفظ المنشور')) );
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Post( UserId:UserId,name:name,UrlImage:UrlImage,)), (route) => false);

       }

       else{
               ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('لم يتم حفظ المنشور')) );

       }



}






  final imagepicker = ImagePicker();

  Widget _buildProfileImage(BuildContext context ,String imagee ,String Type) {
    if(Type=='Google')
    {
       return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.3),
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
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 5,
                                              blurRadius: 20,
                                              color: Colors.black.withOpacity(0.3),
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


  Widget _buildpost() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
            
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)),
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                           
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                          
                          )))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {

                                  showcamera(context).then((value) =>
                                        {

                                          showPost(context),

                                        });
                           
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color.fromARGB(255, 7, 40, 226),
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text(
                                  'اضف منشور',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 70, 9, 238), fontSize: 15,fontWeight:FontWeight.bold),
                                ),
                              ],
                            ),
                          )))
                ],
              )
            ],
          ),
        ),
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



  Future<List> getPostsGeneral() async {

    final  url = "http://172.19.32.48:80/addPost/allPosts?UserId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();
 

  }


    Future<List> getPostsFollowers() async {

    final  url = "http://172.19.32.48:80/addPost/getPostsFollowers?UserId=$UserId";

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
    color: Color.fromARGB(255, 255, 255, 255),
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
                                                        return Text(' ');
                                                    }
                                                },  
                                              );
                              
         
  }



   Future <void>GeneralPosts() async {

    var url = await"http://172.19.32.48:80/addPost/GeneralPosts?currentUser=$UserId";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    return await responsebody;
 

  }

Future <void>FollowersPosts() async {

    var url = await"http://172.19.32.48:80/addPost/FollowersPosts?currentUser=$UserId";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    return await responsebody;
 

  }




Widget _buildButtons(String Stat) {

     bool Fav=true;
            if(Stat=='general')
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

                GeneralPosts().then((value) =>{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Post( UserId:UserId,name:name,UrlImage:UrlImage,)), (route) => false),
                    })

              },
              child:  Container(
                height: 40.0,
               width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                //  border: Border.all(),
                  color:Color.fromARGB(239, 255, 251, 251),
                ),
                child:Center(
                  child: Row(
                    children: [
                      SizedBox(width: 120,),
                      Text( "عام",style: TextStyle(
                   
                       color: Color.fromARGB(255, 128, 127, 127),
                     fontWeight: FontWeight.w600,
                      fontSize: 13
                    ),
                  ),
                         Text( "  /  ",style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),

                  Text( "اتابعه",style: TextStyle(
                       color: Color.fromARGB(255, 20, 2, 180),
                     
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                    ),
                  ),
                    ],
                    
                  )
                ),
              ),
            ):InkWell(
              onTap: () => {

                FollowersPosts().then((value) =>{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Post( UserId:UserId,name:name,UrlImage:UrlImage,)), (route) => false),
                    })

              },
              child: Container(
                height: 40.0,
               width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                //  border: Border.all(),
                  color:Color.fromARGB(239, 255, 251, 251),
                ),
                child:Center(
                  child: Row(
                    children: [
                      SizedBox(width: 120,),
                      Text( "عام",style: TextStyle(
                      color: Color.fromARGB(255, 20, 2, 180),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                         Text( "  /  ",style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),

                  Text( "اتابعه",style: TextStyle(
                      color: Color.fromARGB(255, 128, 127, 127),
                      fontWeight: FontWeight.w600,
                       fontSize: 13
                    ),
                  ),
                    ],
                    
                  )
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
        
        ],
      ),
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

           if(snapshot.data["TypePosts"].toString()=='general')
       {
     if(snapshot.data["UserType"].toString()=='true')
       {

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                       _buildButtons('general'),
                     
                   Container(
                  height:470,
                child: FutureBuilder<List>(
                                      future: getPostsGeneral(),
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
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
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


        else
        {

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                     
                    _buildButtons('general'),
                     SizedBox(
                        height:10,
                      ),
                      _buildpost(),

                      SizedBox(
                        height: 10,
                      ),
                   Container(
                height:470,
                child: FutureBuilder<List>(
                                      future: getPostsGeneral(),
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
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
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

       }

   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////    
     else{


  if(snapshot.data["UserType"].toString()=='true')
       {

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                       _buildButtons('Followers'),
                    
                   
                   Container(
                  height:470,
                child: FutureBuilder<List>(
                                      future: getPostsFollowers(),
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
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
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


        else
        {

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                     
                    _buildButtons('Followers'),
                     SizedBox(
                        height: 10,
                      ),
                      _buildpost(),

                      SizedBox(
                        height: 10,
                      ),
                   Container(
                height:470,
                child: FutureBuilder<List>(
                                      future: getPostsFollowers(),
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
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
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
