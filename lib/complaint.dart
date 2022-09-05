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
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class myComplaint extends StatelessWidget {
  late final String UserId;
    myComplaint
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
      body: myComplaint_Page( UserId:UserId,),
    
      appBar: AppBar(
          title: Text("الشكاوي"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
         // leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ),

      
    ),
    
    );
  }
}

class myComplaint_Page extends StatefulWidget {

    late final String UserId;
     late final String FrindId;
    myComplaint_Page
    ({
    required this.UserId,
  });
  @override
  _myComplaint createState() => _myComplaint(
    UserId:UserId,
  );
}

class _myComplaint extends State<myComplaint_Page> {


      late final String UserId;
    _myComplaint
    ({
    required this.UserId,
  
  }); 

 
  Future <void>getInfo() async {

    var url = await"http://172.19.32.48:80/myProf/myProf?UserId=$UserId";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
      return await responsebody;
 

  }





  final Storage storage=Storage();
  late File _file;
  

late File _fileComit;
String imageName='null';

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
      _fileComit = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadImagesComits(path,imageName).then((value) =>
       {
 Navigator.of(context).pop(),
       
       }
       );
   

    } 
    else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('  لم يتم تحديد الصورة'))
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
      _fileComit = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadImagesComits(path,imageName).then((value) =>
       {

        Navigator.of(context).pop(),
         
       
       }
       );
   

    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' لم يتم اختيار الصورة'))
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




  FirebaseFirestore firestore = FirebaseFirestore.instance;

Future sendComitToDB(String description,String imageComit ) async 
{

             var url = "http://172.19.32.48:80/addComplaint/newcomplaint?UserId=$UserId&description=$description&imageComplaint=$imageComit";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

              if (responsebody['NT']=='done')
       {
       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text(' تم حفظ الشكوى')) );
       }

       else{

               ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('لم يتم حفظ الشكوى')) );

           }



}

  final imagepicker = ImagePicker();

  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

Future<void> showCominet(BuildContext context)async{

return await showDialog(context: context, 
builder: (context){

return AlertDialog(


  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [

      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
       
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.30,
                  image:FileImage(_fileComit),
                  child: InkWell(
                    onTap: () {
                    
                          
                    },
                    // child: const Align(
                    //   child: Padding(
                    //     padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                    //     child: Text(
                    //       '',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w900,
                    //           color: Colors.white70,
                    //           fontSize: 20),
                    //     ),
                    //   ),
                    // ),
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
TextButton(
  onPressed: (){  
                Navigator.of(context).pop();
       }, 
       
       child: Text("موافق",style:const TextStyle( color: Color.fromARGB(255, 22, 0, 216), fontSize: 17.0,),))
  ],
);
}

);
}

 Widget _buildComit() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 67,
        width: 150,
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

                                          showCominet(context),

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
                                  Icons.camera_alt_rounded,
                                  color: Color.fromARGB(255, 126, 207, 131),
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text(
                                  ' اضف صورة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 15, 10, 10), fontSize: 16),
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


  final TextEditingController  MyComplaint = TextEditingController();
  
 Widget _buildComplaint() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Card(
          child: Column(
            children:  <Widget>[
          Card(
            color: Color.fromARGB(255, 234, 237, 255),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 10, //or null 
                decoration: InputDecoration.collapsed(hintText: " ادخل وصف  هنا"),
                controller:MyComplaint ,
              ),
            )
          )
        ]
          ),
        ),
      ),
    );
  }

 

Widget _buildButtons() {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:25.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child:InkWell(
              onTap: () => {
                   
       sendComitToDB(MyComplaint.text,imageName).then((value) =>
       {

       Navigator.pop(context),

        })

       

              },
              child: Container(
                height: 50.0,
              
                decoration: BoxDecoration(
                  border: Border.all(),
                  color:Color(0xFF404A5C),
                ),
                child:Center(
                  child: Text( "ارسال",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5,
                    ),
                  ),
                )
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
       
                    String nm=snapshot.data["name"].toString();

       return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height:20),
                  
                     
                      const SizedBox(height: 20.0),
                      Text('مرحبا  $nm ',style: TextStyle(fontSize: 24,color: Colors.amber),),
                        const SizedBox(height: 20.0),
                       Text('اذا كانت لديك شكوى على عامل ما قم بتبليغنا رجاءا',style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 20.0),
                   
                    _buildSeparator2(screenSize),
                    _buildComplaint(),
                    _buildComit(),
                     const SizedBox(height: 30.0),
                     _buildButtons(),
                    ],
                  ),
                ),
              ),
            ],
          );
            }
          return Center(      
                  child:  Text('  '),
                  );
          
          
         },
        ),
      ),
    ); 
     
   
  }
}
