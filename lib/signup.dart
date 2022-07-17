  
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'signIn.dart';

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
               buildTextField("الاسم", "الاسم", false),
              buildTextField("الايميل", "ex@gmail.com", false),
              buildTextField("كلمة السر", "********", true),
               buildTextField("تأكيد كلمة السر", "TLV, Israel", true),
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

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) 
  
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(

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



