
  // ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors, unused_local_variable, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'main.dart';
import 'myProfile.dart';
import 'signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


 GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
      Future signUpTofirebase(String email,String name,String userId,String ImageUrl,String password)async{

   
    DocumentSnapshot userExist = await firestore.collection('users').doc(userId).get();

    if(userExist.exists)
    {
          showAlertDialog(' لديك حساب بالفعل');

    }
    
    else
    {
       await firestore.collection('users').doc(userId).set({
      'email':email,
      'name':name,
      'image':ImageUrl,
      'uid':userId,
       'password':password,
      'date':DateTime.now(),
    });
    }
   

  }




  late File iimage;

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
shareEamil(String email)async
{
  
          SharedPreferences preferences =await SharedPreferences.getInstance();
          preferences.setString("email", email);
           
     //    print(preferences.getString("email"));
        
}

 Future CreatUser(String email, String name, String password ,String confPassword )async {
                    if(email+"--"=="--")
                        showAlertDialog('Enter the Email!');
                     else if(name+"--"=="--")
                        showAlertDialog('Enter the name!');    
                    else if(password+"--"=="--")
                        showAlertDialog('Enter the password!');     
                    else  if(confPassword+"--"=="--")
                        showAlertDialog('Enter Confirm Password!');     
                        
else{


       var url = "http://10.0.2.2:8000/signUp/signUp?email=$email&name=$name&password=$password&confPassword=$confPassword";
       var response =await http.post(Uri.parse(url));
      var responsebody= jsonDecode(response.body) ;

      // print(responsebody['NT']);
       if (responsebody['NT']=='done')
       {
             await signUpTofirebase(email,name,responsebody['uid'].toString(),responsebody['imegUrl'].toString(),password);
              shareEamil(email);
            // ignore: use_build_context_synchronously

            Navigator.push( context,
            MaterialPageRoute(builder: (context) => MyApp()));
       }
       
      else if (responsebody['NT']=='Email exists !')
       {
     
           showAlertDialog('هذا الحساب موجود بالفعل ');
       
       }

      else if (responsebody['NT']=='Invalid Email !')
       {
      
           showAlertDialog('ايميل غير صالح ');

       }
        else if (responsebody['NT']=='password does not match')
       {
      
                    showAlertDialog('كلمة السر غير متطابقة');

       }


      else {
                    showAlertDialog('خطأ ');

          }

}



    
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
             
               buildTextField("تأكيد كلمة السر", "********", true , ControllerconfPass),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  RaisedButton(
                    onPressed: () async{
                    
                       await CreatUser(ControllerEmail.text,ControllerName.text,ControllerPass.text,ControllerconfPass.text);

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



