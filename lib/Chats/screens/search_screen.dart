import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SettingsPage.dart';
import '../../signIn.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';
import 'home_screen.dart';


class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult =[];
  bool isLoading = false;

  void onSearch()async{
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').where("name",isEqualTo: searchController.text).get().then((value){
       if(value.docs.length < 1){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No User Found")));
            setState(() {
      isLoading = false;
    });
    return;
       }
       value.docs.forEach((user) {
          if(user.data()['email'] != widget.user.email){
               searchResult.add(user.data());
          }
        });
     setState(() {
      isLoading = false;
    });
    });
  }

   out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child:Scaffold(
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
      body: Column(
        children: [
           Row(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: TextField(
                     controller: searchController,
                     decoration: InputDecoration(
                       hintText: "ادخل اسم العامل ",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10)
                       )
                     ),
                   ),
                 ),
               ),
               IconButton(onPressed: (){
                  onSearch();
               }, icon: Icon(Icons.search_sharp),iconSize: 30,)
             ],
           ),
           if(searchResult.length > 0)
              Expanded(child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    
                    leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:searchResult[index]['image'],
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 55,
                            width: 55,
                          ),
                        ),
                
                    title: Text(searchResult[index]['name']),
                    subtitle: Text(searchResult[index]['email']),
                    trailing: IconButton(onPressed: (){
                        setState(() {
                          searchController.text = "";
                        });
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                             currentUser: widget.user, 
                             friendId: searchResult[index]['uid'],
                              friendName: searchResult[index]['name'],
                               friendImage: searchResult[index]['image'])));
                    }, icon: Icon(Icons.wechat_outlined ,size: 35,)),
                  );
                }))
           else if(isLoading == true)
              Center(child: CircularProgressIndicator(),)
        ],
      ),
      
    ),
    
    );
    
  }
}