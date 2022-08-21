import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/Chats/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../SettingsPage.dart';
import '../../main.dart';
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

   out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }

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
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      appBar: AppBar(
        
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
                  builder: (BuildContext context) => MyApp()));
            },
          ),
        ],
      ),
       drawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('',style:TextStyle(fontSize: 20),), accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(child:  Icon(Icons.person)),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage("https://www.monkhouselaw.com/wp-content/uploads/2020/03/rights-of-workers-ontario.jpg"),fit: BoxFit.cover),

                 ),

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
               ListTile(
                    title: Text("الاعدادات"),
                    leading: Icon(Icons.settings),
                    subtitle: Text("Settings"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
                    },
                ),
              Center(
              child: OutlinedButton(
                
                onPressed: () async {
                              out();
                             await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: const Text("تسجيل الخروج",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
            )


            ],

          ),


      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(UID).collection('messages').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length < 1){
              return Center(
                child: Text("اضغط على العدسة بالاسفل و ابدأ بالمحادثة "),
              );
            }
            return ListView.builder(
            //  reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_msg'];
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                  builder: (context,AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      var friend = asyncSnapshot.data;
                      return Directionality(textDirection: TextDirection.rtl, 
                      
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 45, // Image radius
                            backgroundImage: NetworkImage(friend['image']),
                          ),
                        title: Text(friend['name'],style: TextStyle(fontSize: 18),),
                        subtitle: Container(
                          child: Text("$lastMsg",style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                            currentUser: user,
                             friendId: friend['uid'],
                              friendName: friend['name'],
                               friendImage: friend['image'],
                                friendToken: friend['token'],
                               
                               )));
                        },
                      ),
                      
                      
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
         backgroundColor: Color.fromARGB(255, 66, 64, 64),
        child: Icon(Icons.search,color: Color.fromARGB(255, 255, 255, 255),size: 25,),
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(user)));
        },
      ),
      
    )
    
    );
  }
}