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
            late final String name;
   late final String UrlImage;


  SearchScreen({required this.user,
      required this.name,
    required this.UrlImage,

  });

  @override
  _SearchScreenState createState() => _SearchScreenState(name:name,
        UrlImage:UrlImage,);
}

class _SearchScreenState extends State<SearchScreen> {

          late final String name;
   late final String UrlImage;
         _SearchScreenState
    ({
        required this.name,
    required this.UrlImage,
  
  });
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult =[];
  bool isLoading = false;

  void onSearch()async{
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').where("name",isGreaterThan: searchController.text).get().then((value){
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
          title: Text("البحث"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
         // leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
                               friendImage: searchResult[index]['image'],
                               friendToken: searchResult[index]['token'],
                                  name:name,
                                 UrlImage:UrlImage,
                               )));
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