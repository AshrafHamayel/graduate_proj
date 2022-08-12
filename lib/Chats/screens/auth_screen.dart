// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget{
  @override
_AuthScreenState createState()=>_AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {

   GoogleSignIn googleSignIn=GoogleSignIn();
   FirebaseFirestore firestore=FirebaseFirestore.instance;


Future signInFunction()async{
      GoogleSignInAccount? googleUser =await googleSignIn.signIn();
      if(googleUser==null){
        return;
      }

      final googleAuth=await googleUser.authentication;
      final credential =GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken:  googleAuth.idToken
      );
 
      UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email':userCredential.user!.email,
        'name':userCredential.user!.displayName,
        'image':userCredential.user!.photoURL,
        'uid':userCredential.user!.uid,
        'date':DateTime.now(),
        
      });
}

////


     @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded (
              child :Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:  NetworkImage("https://w7.pngwing.com/pngs/695/659/png-transparent-computer-icons-conversation-online-chat-share-miscellaneous-blue-text.png")
                  ) 
                ),
              )
          ),
          Text("Work Book Chats",style: TextStyle(fontSize: 36,fontWeight:FontWeight.bold ),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical:20 ),
           child: ElevatedButton(onPressed: ()async{
            await signInFunction();
           },
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://cdn.iconscout.com/icon/free/png-256/google-2296064-1912023.png',height:36,),
              SizedBox(width: 10,),
              Text("Sign in with Google",style: TextStyle(fontSize: 20),)
            ],

           ),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
           ),
           ),
           ),

            ],
          ),
        ),
      );
    }
}