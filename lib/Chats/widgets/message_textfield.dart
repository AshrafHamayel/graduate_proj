// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;
  final String friendToken;
  
  MessageTextField(this.currentId,this.friendId,this.friendToken);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

var serverKey =
      "AAAATaiNjQM:APA91bGD7PdUfj1D6igGGWNPQpiwpJ8RH5I2MKGvRv75mi3Nur3NXaEDEwyPvpfOjVrgq8wZvAi3Xd1AU3GLqSra_2S5lQc_GHS4cAmvLlKMGMCRkRZ96uOtFerRxqR5gEyjyTLFlYT-";
  sendNotification(String body, String token) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': 'WorkBook'},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );
  }

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
       padding: EdgeInsetsDirectional.all(8),
       child: Row(
         children: [
           Expanded(child: TextField(
             controller: _controller,
              decoration: InputDecoration(
                labelText:"Type your Message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25)
                )
              ),
           )),
           SizedBox(width: 20,),
           GestureDetector(
             onTap: ()async{
               String message = _controller.text;
               _controller.clear();
               await FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).collection('chats').add({
                  "senderId":widget.currentId,
                  "receiverId":widget.friendId,
                  "message":message,
                  "type":"text",
                  "date":DateTime.now(),
               }).then((value) {
                 FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).set({
                     'last_msg':message,
                 });
               });

               await FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).collection("chats").add({
                 "senderId":widget.currentId,
                 "receiverId":widget.friendId,
                 "message":message,
                 "type":"text",
                 "date":DateTime.now(),

               }).then((value){
                 FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).set({
                   "last_msg":message
                 });
               });
              sendNotification(message, widget.friendToken);
             },
             child: Container(
               padding: EdgeInsets.all(8),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.blue,
               ),
               child: Icon(Icons.send,color: Colors.white,),
             ),
           )
         ],
       ),
      
    );
  }
}