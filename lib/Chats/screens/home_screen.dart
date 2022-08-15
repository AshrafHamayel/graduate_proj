import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/Chats/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../signIn.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var UID;
late UserModel user;
class _HomeScreenState extends State<HomeScreen> {



  Future<void> getEamil() async {
  SharedPreferences    preferences = await SharedPreferences.getInstance();
     UID = preferences.getString("UserId");

       print(' UID from home screen :');

  print(preferences.getString("UserId"));
     DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(UID).get();
      user = UserModel.fromJson(userData);
  return UID;

  }
  @override
  Widget build(BuildContext context) {
    getEamil();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: ()async{
              SharedPreferences preferences = await SharedPreferences.getInstance();
               await preferences.clear();
              await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(UID).collection('messages').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length < 1){
              return Center(
                child: Text("No Chats Available !"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_msg'];
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                  builder: (context,AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      var friend = asyncSnapshot.data;
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: CachedNetworkImage(
                            imageUrl:friend['image'],
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 50,
                          ),
                        ),
                        title: Text(friend['name']),
                        subtitle: Container(
                          child: Text("$lastMsg",style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                            currentUser: user,
                             friendId: friend['uid'],
                              friendName: friend['name'],
                               friendImage: friend['image'])));
                        },
                      );
                    }
                    return LinearProgressIndicator();
                  },

                );
              });
          }
          return Center(child: CircularProgressIndicator(),);
        }),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(user)));
        },
      ),
      
    );
  }
}