// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'EditProfile.dart';
import 'SettingsPage.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class workerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: workerProfile_Page(),
    
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
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.settings,
        //       color: Colors.green,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (BuildContext context) => SettingsPage()));
        //     },
        //   ),
        // ],
      ),

      endDrawer: Drawer(
          child: ListView(
            children: <Widget>[

            ],

          ),


      ),
    );
  }
}

class workerProfile_Page extends StatefulWidget {
  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<workerProfile_Page> {

  var email='asd@gmail.com';
     

  

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


// Future<void> getEamil() async {
//   SharedPreferences    preferences = await SharedPreferences.getInstance();
//     email = preferences.getString("email");
//   print(preferences.getString("email"));

//   }

  Future getInfo() async {
    //getEamil();
    var url = "http://192.168.0.114:80/myProf/myProf?email=$email";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return responsebody;
 

  }





  final Storage storage=Storage();
   

  late File _file;
   late String pathes='NOooo';
uploadImage() async {
    // var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _file = File(pickedImage.path);
      final imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

       storage.uploadFile(path,imageName).then((value) =>
       {

        print('done'),
         
        sendToDB(imageName),

       }
       );
      //  print(imageName);
      //   print(path);

    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
  }


Future sendToDB(String imagePath) async {

             var url = "http://192.168.0.114:80/myProf/saveImage?email=$email&imagePath=$imagePath";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

}




  final imagepicker = ImagePicker();

  Widget _buildProfileImage(BuildContext context ,String imagee) {
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
          // Positioned(
          //     bottom: 0,
          //     right: 0,
          //     child: Container(
          //       height: 40,
          //       width: 40,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           width: 4,
          //           color: Theme.of(context).scaffoldBackgroundColor,
          //         ),
          //         color: Colors.green,
          //       ),
          //       child: IconButton(
          //         padding: EdgeInsets.all(3),
          //         onPressed: () {

          //             uploadImage();
     
          //         },
          //         icon: const Icon(
          //           Icons.edit,
          //           color: Colors.white,
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
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

  Widget _buildStatus(BuildContext context ,String _status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
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

  Widget _buildStatContainer(String _followers ,String _Rating) {
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
        style: bioTextStyle,
      ),
    );
  }


  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: 2.0,
      color: Colors.black54,
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => {},
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color(0xFF404A5C),
                ),
                child: const Center(
                  child: Text(
                    "متابعة",
                    style: TextStyle(
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
              onTap: () => {},
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
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      
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

                      
                        FutureBuilder<String>(
                        future: storage.downloadURL(snapshot.data["image"]),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                            
                                return  _buildProfileImage(context,snapshot.data!);
                            } 
                            else 
                            {
                                return CircularProgressIndicator();
                            }
                        },  
                      ),


                     _buildFullName(snapshot.data["name"].toString()),
                      _buildStatus(context,snapshot.data['work'].toString()),
                      _buildStatContainer(snapshot.data['followers'].toString(),snapshot.data['evaluation'].toString()),
                      _buildBio(context,snapshot.data['description'].toString()),
                      const SizedBox(height: 10.0),
                      _buildButtons(),
                      const SizedBox(height: 8.0),
                      _buildSeparator(screenSize),
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
