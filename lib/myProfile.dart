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
import 'EditProfile.dart';
import 'SettingsPage.dart';
import 'addPost.dart';
import 'main.dart';
import 'dart:convert';
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

class myProfile extends StatelessWidget {
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: UserProfile_Page(),
    
      appBar: AppBar(
        
        // toolbarHeight: 30,
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.green,
        //   ),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => MyApp()),
        //     );
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
            },
          ),
        ],
      ),
//Directionality
      drawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('أشرف حمايل',style:TextStyle(fontSize: 20),), accountEmail: Text('asrf@gmail.com'),
                  currentAccountPicture: CircleAvatar(child:  Icon(Icons.person)),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage("https://www.monkhouselaw.com/wp-content/uploads/2020/03/rights-of-workers-ontario.jpg"),fit: BoxFit.cover),

                 ),

                ),
               
                 ListTile(
                    title: Text("تغيير نوع العمل "),
                    leading: Icon(Icons.work),
                    subtitle: Text("change work"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
                 ListTile(
                    title: Text(" تقديم شكوى "),
                    leading: Icon(Icons.drafts_sharp),
                    subtitle: Text(" Make a complaint"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
              ListTile(
                    title: Text("  موقعي "),
                    leading: Icon(Icons.edit_location_alt_sharp),
                    subtitle: Text(" My location"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
               ListTile(
                    title: Text("الاعدادات"),
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

class UserProfile_Page extends StatefulWidget {
  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfile_Page> {

  var UserId;
     

  

Widget buildd(BuildContext context) 
{
  return FutureBuilder(
    future: getEamil(),
    builder: (context, snapshot) {
      
      if (snapshot.hasData) {
        
        return UserId;
      }
      return CircularProgressIndicator(); // or some other widget
    },
  );
}
Future<String> getEamil() async {
  SharedPreferences   preferences = await SharedPreferences.getInstance();
    UserId = await preferences.getString("UserId");
    print (' UID from home muProfile :');
  print(preferences.getString("UserId"));

     return UserId;
  }

  Future <void>getInfo() async {

    var url = await"http://192.168.0.114:80/myProf/myProf?UserId=$UserId";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }





  final Storage storage=Storage();
    final addPost AddPost=addPost();
 

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
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myProfile()), (route) => false),
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
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myProfile()), (route) => false);
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
              const SizedBox(height: 35),

      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
       
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.30,
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

             var url = "http://192.168.0.114:80/myProf/saveImage?UserId=$UserId&imagePath=$imagePath";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

            

}

  FirebaseFirestore firestore = FirebaseFirestore.instance;

Future sendPostToDB(String description,String imagepost ) async 
{

             var url = "http://192.168.0.114:80/addPost/newPost?UserId=$UserId&description=$description&imagepost=$imagepost";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

              if (responsebody['NT']=='done')
       {
           await firestore.collection('users').doc(UserId).collection('Posts').doc(UserId).set({
     
      'name':responsebody['name'].toString(),
      'uid':responsebody['id'].toString(),
      'imageuser':responsebody['imageuser'].toString(),
      'imagepost':responsebody['imagepost'].toString(),
      'description':responsebody['description'].toString(),
      'numberLike':responsebody['numberLike'].toString(),
      'date':DateTime.now(),
      'numberDisLike':responsebody['numberDisLike'].toString(),

      
    }); 
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myProfile()), (route) => false);

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
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Colors.green,
                ),
                child: IconButton(
                  padding: EdgeInsets.all(3),
                  onPressed: () {

                      uploadImage();
     
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )),
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
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ),
                                          color: Colors.green,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.all(3),
                                          onPressed: () {

                                              uploadImage();
                            
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
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

  Widget _buildStatus(BuildContext context ,String Work,String city,String phoneN ,String Salary) {
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
              title: Text( Work, style: const TextStyle( color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.work),
                    subtitle: Text(" المهنة"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),

                 ListTile(
              title: Text(city, style: const TextStyle( color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.location_pin),
                    subtitle: Text(" المدينة "),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
 ListTile(
              title: Text( phoneN, style: const TextStyle( color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.phone),
                    subtitle: Text(" رقم الهاتف  "),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),

                 ListTile(
              title: Text( Salary, style: const TextStyle( color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.w300, ), ),
                    leading: Icon(Icons.attach_money),
                    subtitle: Text(" اجرة العمل اليومي بالشيكل"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),


            ])
       
       
        
      
      
      
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer(String _followers ,String _Rating,String _Ifollow) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
            _buildStatItem("التقيم", _Rating),
          _buildStatItem("المتابعون", _followers),
         _buildStatItem("أتابعه", _Ifollow),
        
          
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
                                  Icons.add_box,
                                  color: Colors.grey,
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text(
                                  'اضف منشور',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
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

  // Widget _buildSeparator(Size screenSize) {
  //   return Container(
  //     width: screenSize.width,
  //     height: 2.0,
  //     color: Colors.black54,
  //     margin: const EdgeInsets.only(top: 4.0),
  //   );
  // }

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

    final  url = "http://192.168.0.114:80/addPost/myPosts?UserId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody;
 

  }



  Widget _buildStatPosts(String namePost,String description,String ImageUserURL, String ImageURL ,String Nlike,String NDisLike,String DatePost) {


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
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.3)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Color.fromARGB(255, 158, 158, 158)
                                                        .withOpacity(.3)))),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Color.fromARGB(255, 114, 111, 111),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Text(
                                              '$Nlike اعجبني' ,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                 color: Color.fromARGB(255, 36, 33, 33),
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: InkWell(
                                        onTap: () {

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(.3)))),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.thumb_down_alt_outlined,
                                                  color: Color.fromARGB(255, 114, 111, 111),

                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10)),
                                              Text(
                                                ' $NDisLike  لم يعجبني',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 36, 33, 33),
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    
                     _buildSeparator2(MediaQuery.of(context).size),


      ]

  ),
  );
   
                            } 
                                                   
                                                   
                                                   
                                                    else 
                                                    {
                                                      return Text('... جار اظهار منشوراتك ');
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
    

  return FutureBuilder(
    future: getEamil(),
    builder: (context, snapshot) {
      
      if (snapshot.hasData) {
        
         return Container (
      
      child: Scaffold(
        
         body: FutureBuilder(
                     future:getInfo() ,
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   {   


           print('snapshot :-');
           print(snapshot.data);
           
       if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
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

                      _buildStatus(context,snapshot.data['work'].toString(),snapshot.data['city'].toString(),snapshot.data['phoneNumber'].toString(),snapshot.data['Salary'].toString()),
                      _buildStatContainer(snapshot.data['followers'].toString(),snapshot.data['evaluation'].toString(),snapshot.data['Ifollow'].toString()),
                      const SizedBox(height: 10.0),
                      //_buildButtons(),
                      const SizedBox(height: 8.0),
                    //  _buildSeparator2(screenSize),
                      SizedBox(
                        height: 10,
                      ),
                      _buildpost(),

                      SizedBox(
                        height: 10,
                      ),

                      FutureBuilder<List>(
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
                                     
                                                    print('snapshot.data![index][name] --');
                                                     print(snapshot.data![index]['name'].toString());
                                                     
                                                return _buildStatPosts(snapshot.data![index]['name'].toString(),snapshot.data![index]['description'].toString(),snapshot.data![index]['imageuser'].toString(),snapshot.data![index]['imagepost'].toString(),snapshot.data![index]['numberLike'].toString(),snapshot.data![index]['numberDisLike'].toString(),snapshot.data![index]['date'].toString(),);
                                                  },
                                                );
                                         }
                                        
                                     return Text('لم تقم بنشر اي منشور بعد '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
          //  Widget _buildStatPosts(String namePost,String description,String ImageUserURL, String ImageURL ,String Nlike,String NDisLike,String DatePost) {

                      // _buildStatPosts('https://blog.educationalgate.com/uploads/images/image_750x_5ddcde6d9eddf.jpg','3','5'),
                      //  _buildStatPosts('https://pbs.twimg.com/media/E2KAN8-WUAA1ZZp.jpg:large','10','50'),
                      //   _buildStatPosts('https://cdn.molhem.com/public/articles/4852/main/16096694781191141585-4852.jpg','14','73'),
                    ],
                  ),
                ),
              ),
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
          
          
         },
        ),
      ),
    ); 
       
      }
      return CircularProgressIndicator(); // or some other widget
    },
  );


     
   
  }
}
