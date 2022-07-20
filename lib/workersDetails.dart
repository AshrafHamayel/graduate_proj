// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:graduate_proj/posts.dart';

class WorkersData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final String todo=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Data"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: const Text('suii'),
      ),
    );
  }
}
