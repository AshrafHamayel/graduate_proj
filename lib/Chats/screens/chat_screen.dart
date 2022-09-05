// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../ratingPage.dart';
import '../../workerProfile.dart';
import '../models/user_model.dart';
import '../widgets/message_textfield.dart';
import '../widgets/single_message.dart';
import 'home_screen.dart';



class ChatScreen extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
    final String friendToken;
              late final String name;
   late final String UrlImage;

  ChatScreen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.friendToken,
        required this.name,
    required this.UrlImage,

  });

  @override
  
  Widget build(BuildContext context) {
      bool evaluati;
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(

       appBar: AppBar(
        title: Row(
          children: [
             SizedBox(width: 20,),
            Text(friendName,style: TextStyle(fontSize: 20),),
           SizedBox(width: 12,),
           CircleAvatar(
                radius: 22, // Image radius
                backgroundImage: NetworkImage(friendImage),
              ),
      
          ],
        ),


        
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 254, 255, 254),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen(
                    name:name,
                   UrlImage:UrlImage,)));
            },
          ),
        ],
      ),

       drawer: Drawer(
        
          child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
               builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data.docs.length < 1){
                       return ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('',style:TextStyle(fontSize: 20),), accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(child:  Icon(Icons.person)),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage("https://www.monkhouselaw.com/wp-content/uploads/2020/03/rights-of-workers-ontario.jpg"),fit: BoxFit.cover),

                 ),

                ),
               
                 ListTile(
                    title: Text(" عرض الملف الشخصي",style: TextStyle(fontSize: 19),),
                    leading: Icon(Icons.visibility_outlined),
                    subtitle: Text(" عرض المستخدم"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){

                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:friendId , CurrentUser:currentUser.uid,name:name,
        UrlImage:UrlImage,)), (route) => false);

                    },

                ),
                 
               ListTile(
                    title:Text("غير مصرح لك التقييم ",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 233, 18, 18)),),
                    leading: Icon(Icons.elevator_outlined),
                    subtitle: Text("قم بالتواصل مع هذا المستخدم اولا"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){


                    },

                ),
                 
           


            ],

          );
                     }
                   
                     return ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('',style:TextStyle(fontSize: 20),), accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(child:  Icon(Icons.person)),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage("https://www.monkhouselaw.com/wp-content/uploads/2020/03/rights-of-workers-ontario.jpg"),fit: BoxFit.cover),

                 ),

                ),
               
                 ListTile(
                    title: Text(" عرض الملف الشخصي",style: TextStyle(fontSize: 19),),
                    leading: Icon(Icons.visibility_outlined),
                    subtitle: Text(" عرض المستخدم"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){

                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:friendId , CurrentUser:currentUser.uid,name:name,
        UrlImage:UrlImage,)), (route) => false);

                    },

                ),
                 
               ListTile(
                    title:Text(" تقييم المستخدم",style: TextStyle(fontSize: 19,color: Color.fromARGB(255, 8, 1, 39)),),
                    leading: Icon(Icons.elevator_outlined),
                    subtitle: Text(" قم بتقييم هذا المستخدم"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){


                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>myRating( UserId:currentUser.uid,FrindId:friendId)), (route) => false);
          

                    },

                ),
                 
           


            ],

          );
                   }
                   return Center(
                     child: CircularProgressIndicator()
                   );
               }),


      ),
     

      body: Column(
        children: [
           Expanded(child: Container(
             padding: EdgeInsets.all(10),
             // ignore: prefer_const_constructors
             decoration: BoxDecoration(
               color: Colors.white,
               // ignore: prefer_const_constructors
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 topRight: Radius.circular(25)
               )
             ),
             child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
               builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data.docs.length < 1){
                      
                       return Center(
                         child: Text("ابدأ المحادثة الان"),
                       );
                     }
                     return ListView.builder(
                      
                       itemCount: snapshot.data.docs.length,
                       reverse: true,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context,index){
                        evaluati=true;
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.uid;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                       });
                   }
                   return Center(
                     child: CircularProgressIndicator()
                   );
               }),
           )),
           MessageTextField(currentUser.uid, friendId,friendToken),
        ],
      ),
      
    ),



    );
    
    
    
  }





}

