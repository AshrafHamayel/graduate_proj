// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'EditProfile.dart';
import 'SettingsPage.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class myProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfile_Page(),
      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}

class UserProfile_Page extends StatefulWidget {
  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfile_Page> {
  // Widget _buildCoverImage(Size screenSize) {
  //   return Container(
  //       // height: screenSize.height / 3.6,
  //       // decoration: const BoxDecoration(
  //       //   image: DecorationImage(
  //       //     image: AssetImage('images/probackgrond.jpg'),
  //       //     fit: BoxFit.cover,
  //       //   ),
  //       // ),
  //       );
  // }
  // ignore: prefer_typing_uninitialized_variables
  var _fullName;
  var _status;
  var _bio;
  var _followers;
  var _Rating;

  var email;
  getEamil() async {
    //SharedPreferences.setMockInitialValues({});

    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("email")!;

    //  print(preferences.getString("email"));
  }

  Future getInfo() async {
    getEamil();
    print("email");
    var url = "http://10.0.2.2:8000/myProf/myProf?email=$email";
    var response = await http.get(Uri.parse(url));
    var encodeFirst = json.encode(response.body);
    var responsebody = json.decode(encodeFirst);
    if (responsebody[0] == null) {
      CircularProgressIndicator();
    } else {
      //var responsebody= jsonDecode(response.body) ;
      _fullName = responsebody[0]['name'];
      _status = responsebody[0]['work'];
      _bio = responsebody[0]['description'];
      _followers = responsebody[0]['followers'];
      _Rating = responsebody[0]['evaluation'];
      // _status=responsebody[0]['work'];
    }
  }

  late File _file;

  uploadImage() async {
    // var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _file = File(pickedImage.path);
    } else {
      Text("Image not selected");
    }
  }

  Future upload() async {
// ignore: unnecessary_null_comparison
    if (_file == null) {
      return;
    }

    String base64 = base64Encode(_file.readAsBytesSync());
    String immName = _file.path.split("/").last;
    // ignore: avoid_print
    print(immName);
  }

  final imagepicker = ImagePicker();

  Widget _buildProfileImage(BuildContext context) {
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
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://media.elcinema.com/uploads/_315x420_4d499ccb5db06ee250289a1d8c753b347b8a31d419fd1eaf80358de753581b7b.jpg"))),
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

                    // Image.file(iimage);
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

  Widget _buildFullName() {
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

  Widget _buildStatus(BuildContext context) {
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

  Widget _buildStatContainer() {
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
          _buildStatItem("التقيم", _Rating),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
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

  Widget _buildpost() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person_outline),
                ),
                title: TextFormField(
                  maxLines: 10,
                  minLines: 1,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 10),
                      hintText: 'شاركنا عملك',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    onPressed: upload,
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.grey,
                                    )),
                                Padding(padding: EdgeInsets.only(right: 10)),
                              ],
                            ),
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    )),
                                Padding(padding: EdgeInsets.only(right: 10)),
                              ],
                            ),
                          )))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    getInfo();

    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              //   _buildCoverImage(screenSize),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 18.0),
                      _buildProfileImage(context),
                      _buildFullName(),
                      _buildStatus(context),
                      _buildStatContainer(),
                      _buildBio(context),
                      const SizedBox(height: 10.0),
                      _buildButtons(),
                      const SizedBox(height: 8.0),
                      _buildSeparator(screenSize),
                      SizedBox(
                        height: 10,
                      ),
                      _buildpost(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
