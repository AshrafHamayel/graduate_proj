// ignore_for_file: unused_import, depend_on_referenced_packages, camel_case_types
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';
import 'signup.dart';

class api {
  static Future<http.Response> createUser(
      String email, String name, String password) {
    return http.post(
      Uri.parse('http://10.0.2.2:8000/signUp/signUp?email=$email&name=$name&password=$password'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      // body: jsonEncode(<String, String>{
      //   'title': title,
      // }),
    );
    

  }

   static Future<http.Response> login(
      String email,String password) {
    return http.post(
      Uri.parse(
          'http://10.0.2.2:8000/login/login?email=$email&password=$password'),
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
