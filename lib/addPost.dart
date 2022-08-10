// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'package:path/path.dart';
import 'EditProfile.dart';
import 'SettingsPage.dart';
import 'addPost.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'mainPage.dart';
import 'myProfile.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class addPost extends StatelessWidget {
   var email;
// Widget buildd(BuildContext context) {
//   return FutureBuilder(
//     future: getEamil(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return email;
//       }
//       return CircularProgressIndicator(); // or some other widget
//     },
//   );
// }
Future<void> getEamil(String Em ,BuildContext context) async 
{

            email=Em;
            uploadImagePost();
            print(email);
           build(context);
         
  // SharedPreferences    preferences = await SharedPreferences.getInstance();
  //   email = preferences.getString("email");
  // print(preferences.getString("email"));

  }




  Future getInfo() async {
   // getEamil();
    var url = "http://10.0.2.2:8000/myProf/myProf?email=$email";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return responsebody;
 

  }



  final imagepicker = ImagePicker();


  final Storage storage=Storage();
   



   late String pathes='NOooo';

  late File _filePost;

uploadImagePost() async {
    // var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _filePost = File(pickedImage.path);
      final imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

       storage.uploadFile(path,imageName).then((value) =>
       {

        print('done'),
         
      ///  sendToDB(imageName),

       }
       );
      //  print(imageName);
      //   print(path);

    } else 
    {
     
     print("no image");
      
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
    
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
                  builder: (BuildContext context) => myProfile()));
            },
          ),
        ],
      ),
    
    ),
        

    );
  }
}
