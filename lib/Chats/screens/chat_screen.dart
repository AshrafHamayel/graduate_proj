// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/message_textfield.dart';
import '../widgets/single_message.dart';
import 'home_screen.dart';

class ChatScreen extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  
  ChatScreen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(

       appBar: AppBar(
        title: Row(
          children: [
             SizedBox(width: 20,),
            Text(friendName,style: TextStyle(fontSize: 20),),
           SizedBox(width: 12,),
            ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: CachedNetworkImage(
                            imageUrl:friendImage,
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 44,
                            width: 44,
                          ),
                        ),
           
           
          ],
        ),


        
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
            },
          ),
        ],
      ),

       drawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('أشرف حمايل',style:TextStyle(fontSize: 20),), accountEmail: Text('asrf@gmail.com'),
                  currentAccountPicture: CircleAvatar(child:  Icon(Icons.person)),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage("https://www.monkhouselaw.com/wp-content/uploads/2020/03/rights-of-workers-ontario.jpg"),fit: BoxFit.cover),

                 ),

                ),
               
                 ListTile(
                    title: Text("تغيير نوع العمل "),
                    leading: Icon(Icons.work),
                    subtitle: Text("change work"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
                 ListTile(
                    title: Text(" تقديم شكوى "),
                    leading: Icon(Icons.drafts_sharp),
                    subtitle: Text(" Make a complaint"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
              ListTile(
                    title: Text("  موقعي "),
                    leading: Icon(Icons.edit_location_alt_sharp),
                    subtitle: Text(" My location"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){},

                ),
             
           


            ],

          ),


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
                         child: Text("Say Hi"),
                       );
                     }
                     return ListView.builder(
                       itemCount: snapshot.data.docs.length,
                       reverse: true,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context,index){
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.uid;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                       });
                   }
                   return Center(
                     child: CircularProgressIndicator()
                   );
               }),
           )),
           MessageTextField(currentUser.uid, friendId),
        ],
      ),
      
    ),



    );
    
    
    
  }
}