
  // ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'myProfile.dart';
import 'signIn.dart';
import 'api.dart'  ;

void main() => runApp(SignupPage());

class SignupPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: Signup_Page(),
    );
  }
}

class Signup_Page extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<Signup_Page> {
  bool showPassword = false;
      final ControllerEmail = TextEditingController();
      final ControllerName = TextEditingController();
      final ControllerPass = TextEditingController();
      final ControllerconfPass = TextEditingController();

  late File iimage;

 Future getpost(String email, String name, String password )async {
       var url = "http://10.0.2.2:8000/signUp/signUp?email=$email&name=$name&password=$password";
       var response =await http.post(Uri.parse(url));
      var responsebody= jsonDecode(response.body) ;
     // var responsebody= response.body ;

       //print(responsebody);
       return responsebody;
  }


  uploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      iimage = File(pickedImage.path);
    } else {}
  }

  final imagepicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

            Navigator.pop(context,
              MaterialPageRoute(builder: (context) => SignIn()));
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.settings,
        //       color: Colors.green,
        //     ),
        //     onPressed: () {
        //       //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
        //     },
        //   ),
        // ],
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
                " انشاء حساب جديد  ",
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
               buildTextField("الاسم", "الاسم", false ,ControllerName),
              buildTextField("الايميل", "ex@gmail.com", false ,ControllerEmail),
              buildTextField("كلمة السر", "********", true , ControllerPass),
               buildTextField("تأكيد كلمة السر", "TLV, Israel", true , ControllerconfPass),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
              //     OutlinedButton(
              //       onPressed: () {Navigator.pop(context,
              // MaterialPageRoute(builder: (context) => SignIn()));},
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0))),
              //       ),
              //       child: const Text("اللغاء",
              //           style: TextStyle(
              //               fontSize: 14,
              //               letterSpacing: 2.2,
              //               color: Colors.black)),
              //     ),
                  RaisedButton(
                    onPressed: () {
                      
                     var resa= getpost(ControllerEmail.text,ControllerName.text,ControllerPass.text);

                            print(resa);
                            // Navigator.push( context,
                            // MaterialPageRoute(builder: (context) => myProfile()));
                     // api.createUser(ControllerEmail.text,ControllerName.text,ControllerPass.text);
                    },
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      " اشتراك الان",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField ,TextEditingController myController ) 
  
  {
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
          border: const OutlineInputBorder(),

          hintText: labelText,
        ),
      ),
    );
  }
}



