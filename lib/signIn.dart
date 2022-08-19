// ignore_for_file: sort_child_properties_last, prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, file_names, use_build_context_synchronously, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'SignUpOptions.dart';
import 'signup.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'myProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

shareEamil(String email)async
{
  
          SharedPreferences preferences =await SharedPreferences.getInstance();
          preferences.setString("UserId", email);
           
        print(preferences.getString("UserId"));
        
}




  // late File iimage;
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


 Future SignINWithEmail(String email,String password )async {
 

                          if(email+"--"=="--")
                       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل الايميل رجاءً')) );

                     else if(password+"--"=="--")
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('!ادخل كلمة السر')) );


                    else

                    {

        var url = "http://192.168.0.114:80/login/login?email=$email&password=$password";
        var response =await http.post(Uri.parse(url));
          var responsebody= jsonDecode(response.body) ;
     

          if (responsebody['NT']=='not found')
          {
      
            showAlertDialog('Email not found !');
            
           
           }

            else  if (responsebody['NT']=='The password is incorrect')
          {
      
            showAlertDialog('The password is incorrect');
           
           }

             else  if (responsebody['NT']=='done')
          {
    
            shareEamil(responsebody['uid']);
         DocumentSnapshot userExist = await firestore.collection('users').doc(responsebody['uid'].toString()).get();

    if(userExist.exists)
    {
     
      return Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
    }
    else
    {
       await firestore.collection('users').doc(responsebody['uid'].toString()).set({
      'email':email,
      'name':responsebody['name'].toString(),
      'image':responsebody['imegUrl'].toString(),
      'uid':responsebody['uid'].toString(),
       'token':responsebody['token'].toString(),
      'date':DateTime.now(),
    });
    
            Navigator.push( context,MaterialPageRoute(builder: (context) => MyApp()));
    }
   
             
           
           }


       
          else 
           {

          showAlertDialog('هناك خطأ ما');
       
           }


                    }


  }



 GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseFirestore firestore = FirebaseFirestore.instance;
 late UserCredential userCredential;

  Future signInwithGoogle()async{
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

     userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


   
           CreatUser(userCredential.user!.email, userCredential.user!.displayName,userCredential.user!.photoURL).then((value) =>{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false),

           } );


  }




 Future CreatUser(String? email, String? name,String? imge)async {
           final fbm = FirebaseMessaging.instance.getToken();
                  
       var url = "http://192.168.0.114:80/signUp/addUserFromGoogleOrFacebook?email=$email&name=$name&image=$imge&fbm=$fbm";
       var response =await http.post(Uri.parse(url));
      var responsebody= jsonDecode(response.body) ;

    DocumentSnapshot userExist = await firestore.collection('users').doc(responsebody['uid'].toString()).get();

       if (responsebody['NT']=='done')
       {
   
       await firestore.collection('users').doc(responsebody['uid'].toString()).set(
          {
      'email':email,
      'name':name,
      'image':imge,
      'uid':responsebody['uid'].toString(),
     'token':responsebody['token'].toString(),

      'date':DateTime.now(),
         });

        shareEamil(responsebody['uid'].toString()).then((value) =>{
                        Navigator.push( context,MaterialPageRoute(builder: (context) => MyApp())),
                      });

 
       
    }     
  
       
      else if (responsebody['NT']=='Email exists !'|| userExist.exists)
       {
      shareEamil(responsebody['uid'].toString()).then((value) =>{
                        Navigator.push( context,MaterialPageRoute(builder: (context) => MyApp())),
                      });

       }
     

      else {
                    showAlertDialog('هناك خطأ ما ');

          }


  }

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
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 30,
              ),
              // const SizedBox(
              //   height: 10,
              // ),
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
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                      
                  //  await GoogleSignIn().signOut();
                  //   await FirebaseAuth.instance.signOut();
                    SignINWithEmail(ControllerEmail.text,ControllerPass.text);


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
               const SizedBox(
                height: 15,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  const Text(
                    '   او قم بتسجيل الدخول  بواسطة  ' ,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 18),
                  )
            
                ],
                //mainAxisAlignment: MainAxisAlignment.center,
              ),
              


                 //        Google --------------------------------------------------
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child:ElevatedButton.icon(

           onPressed: ()async{
            await signInwithGoogle();
          }, 
          icon: Icon(Icons.email_sharp),  //icon data for elevated button
          label: Text("     Google حساب     ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 56, 53, 53)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),

            //        Facebook --------------------------------------------------
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
  children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child:ElevatedButton.icon(
          onPressed: ()async{
           //  await  signInwithFacebook();
          
          }, 
          icon: Icon(Icons.facebook),  //icon data for elevated button
          label: Text("Facebook   حساب     ",style:TextStyle(fontSize: 16),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 62, 63, 158)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
              ),
                  ) 
            ),
          ]


            ),

  //        with Email --------------------------------------------------
 const SizedBox(
                height: 15,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  const Text(
                    'ليس لديك حساب ؟',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 22),
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
                  ),

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
      padding: const EdgeInsets.only(bottom: 10.0),
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
