

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String email;
  String name;
  String image;
  Timestamp date;
  String token;
  String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.image,
    required this.date,
    required this.token,
    required this.uid,
    
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot){
    return UserModel(
      email: snapshot['email'],
       name: snapshot['name'],
        image: snapshot['image'],
         date: snapshot['date'],
         token:snapshot['token'],
          uid: snapshot['uid'],
    );
  }


}