// ignore_for_file: use_key_in_widget_constructors, unused_import, camel_case_types, deprecated_member_use, library_private_types_in_public_api, file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'SettingsPage.dart';
import 'myProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class changemypassord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  // late File iimage;
  // uploadImage() async {
  //   var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     iimage = File(pickedImage.path);
  //   } else {}
  // }

 
      final ControllerOldPass = TextEditingController();
      final ControllerNewPass = TextEditingController();
      final ControllerconfNewPass = TextEditingController();


showAlertDialog(String textMessage) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
             Navigator.of(context).pop();

     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Abort"),
    // ignore: unnecessary_string_interpolations
    content: Text("$textMessage"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


  var UserId;
  getEamil() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserId = preferences.getString("UserId");
  
  }
   Future editPassword(String oldPass, String NewPass, String ConfNewPass ) async 
   {

    getEamil();

    
                          if(oldPass+"--"=="--")
                        showAlertDialog('Enter the old Pass!');
                     else if(NewPass+"--"=="--")
                        showAlertDialog('Enter the New Pass!');   
                         else if(ConfNewPass+"--"=="--")
                        showAlertDialog('Enter the Conf New Pass!');    


                    else
                    { 
                      var url = "http://192.168.0.114:80/myProf/editPassword?UserId=$UserId&Opassword=$oldPass&Npassword=$NewPass&NCpassword=$ConfNewPass";
                 var response = await http.post(Uri.parse(url));
             var responsebody = json.decode(response.body);
             
    

             if (responsebody['NT']=='done')
                            {
                                showAlertDialog('تم تحديث كلمة السر بنجاح');
                                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));

                            }
            else  if (responsebody['NT']=='password does not match')
                   {
                    showAlertDialog('كلمة السر غير متطابقة');

                   }
                    else  if (responsebody['NT']=='The password is incorrect')
                   {
                    showAlertDialog('كلمة السر غير صحيحة');

                   }
                    else  
                   {
                    showAlertDialog('خطأ ');

                   }
                  



    }

   
 
  }


  final imagepicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsPage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
             "تغيير كلمة السر",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("كلمة السر الحالية", true,ControllerOldPass),
              buildTextField("كلمة السر الجديدة", true,ControllerNewPass),
              buildTextField("اعادة كتابة كلمة السر الجديدة", true,ControllerconfNewPass),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SettingsPage()));
                    },
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "الغاء",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      editPassword(ControllerOldPass.text,ControllerNewPass.text,ControllerconfNewPass.text);
                    },
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "حفظ",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, bool isPasswordTextField,TextEditingController myController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
         controller:    myController,
        textAlign: TextAlign.end,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(),
          alignLabelWithHint: true,
          prefixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          border: const UnderlineInputBorder(),
          hintText: labelText,
        ),
      ),
    );
  }
}
