
import 'dart:convert';

import 'package:http/http.dart' as http;



import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';

class api   {
 
 
 static Future<http.Response> createUser(String email ,String name , String password) {
  return http.post(
    Uri.parse('172.19.59.34:9500/signUp/signUp?email=$email&name=$name&password=$password'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: jsonEncode(<String, String>{
    //   'title': title,
    // }),
  );
}
}


Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}