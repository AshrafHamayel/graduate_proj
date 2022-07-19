// ignore_for_file: sort_child_properties_last, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'signup.dart';
import 'main.dart';
import 'api.dart' ;

void main() => runApp(SignIn());

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      body: Sign_In(),
    );
  }
}

class Sign_In extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<Sign_In> {
  bool showPassword = false;

  final ControllerEmail = TextEditingController();
      final ControllerPass = TextEditingController();


  late File iimage;
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
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        // toolbarHeight: 30,
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
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
                "   رجاءً قم بتسجيل الدخول للاستمرار ",
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
              buildTextField("الايميل", "ex@gmail.com", false,ControllerEmail),
              buildTextField("كلمة السر", "********", true,ControllerPass),
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        'نسيت كلمة السر',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  // OutlinedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => MyApp()),
                  //     );
                  //   },
                  //   style: ButtonStyle(
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0))),
                  //   ),
                  //   child: const Text("اللغاء",
                  //       style: TextStyle(
                  //           fontSize: 14,
                  //           letterSpacing: 2.2,
                  //           color: Colors.black)),
                  // ),
                  RaisedButton(
                    onPressed: () {
                      api.login(ControllerEmail.text,ControllerPass.text);


                    },
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  const Text(
                    'ليس لديك حساب ؟',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  TextButton(
                    child: const Text(
                      'اشترك الان',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
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
