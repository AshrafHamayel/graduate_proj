// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/main.dart';
import 'package:graduate_proj/signup.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class SignUpOptions extends StatefulWidget {

  @override
  _SignUpOptionsState createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {
  
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await firestore.collection('users').doc(userCredential.user!.uid).get();

    if(userExist.exists){
      print("User Already Exists in Database");
    }else{
       await firestore.collection('users').doc(userCredential.user!.uid).set({
      'email':userCredential.user!.email,
      'name':userCredential.user!.displayName,
      'image':userCredential.user!.photoURL,
      'uid':userCredential.user!.uid,
      'date':DateTime.now(),
    });
    }
     showPassword(context);
   

  }




  Future signInwithFacebook()async{
  

  }



Future<void> showPassword(BuildContext context)async{
return await showDialog(context: context, 
builder: (context){
  final TextEditingController _passwordController =TextEditingController();
    final TextEditingController _confPasswordController =TextEditingController();

return AlertDialog(
  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
      TextFormField(
        controller: _passwordController,
        validator:((value) {
          return value!.isNotEmpty ?null:"غير صحيح";
      
        }
        ),
        decoration:InputDecoration(hintText:" ادخل كلمة السر"),
      ),
              const SizedBox(height: 35),

      TextFormField(
        controller: _confPasswordController,
        validator:((value) {
          return value!.isNotEmpty ?null:"غير صحيح";
      
        }
        ),
        decoration:InputDecoration(hintText:" تأكيد كلمة السر"),
      ),
    ],
  )
  
  
  )
  
  ),
  actions:<Widget> [
TextButton(onPressed: (){ 
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false);


 }, child: Text("تخزين",style:const TextStyle( color: Color.fromARGB(255, 22, 0, 216), fontSize: 17.0,),))
  ],
);
}

);
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
                   

          children: [

            Expanded(
              child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('images/LO.png'),
                  )
                ),
              ),
            ),
            // Text("كتاب العمال",style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),

               //        with Email --------------------------------------------------
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child:ElevatedButton.icon(
          onPressed: (){
             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                   
          }, 
          icon: Icon(Icons.alternate_email_rounded),  //icon data for elevated button
          label: Text("اشترك باستخدام عنوان البريد الاكتروني",style:TextStyle(fontSize: 19.5),), //label text 
            style: ButtonStyle(
              
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 100, 214, 34)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
              ),
                  ) 
            ),
          ]
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
          label: Text("Google اشتراك عن طريق حساب ",style:TextStyle(fontSize: 20),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 56, 53, 53)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
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
            signInwithFacebook();
          
          }, 
          icon: Icon(Icons.facebook),  //icon data for elevated button
          label: Text("Facebook اشتراك عن طريق حساب ",style:TextStyle(fontSize: 16),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 62, 63, 158)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
              ),
                  ) 
            ),
          ]


            ),







            
            Row(),
            Row(),

          ],
        ),

        
      ),
      
    );
  }
}