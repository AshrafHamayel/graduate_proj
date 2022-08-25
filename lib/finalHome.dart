// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state, camel_case_types, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, deprecated_member_use, sized_box_for_whitespace, empty_catches
import 'dart:convert';
import 'dart:math';

import 'package:graduate_proj/workerProfile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'as Path;
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class home_Page extends StatelessWidget {

 
 late final String currentUser;
    home_Page
    ({
    required this.currentUser,
  
  });


  _launchURL() async {
    const url = 'https://www.facebook.com/laith.jabali.9';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+972569957891',
      text: "مرحبا , احتاج مساعدة ",
    );
    await launch('$link');
  }

  _sendingMails() async {
    var url = Uri.parse("mailto:laithkingjabali@gmail.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _callNumber() async {
    var url = Uri.parse("tel:0569957891");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //----------------------------Get Name sec user---------------------------------------

Future getNameUserSec() async
  {
    
    final  url = "http://192.168.0.114:80/usersInfo/userSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body);
    return responsebody['NT'];
  }

//----------------------------Get Name Secand sec ---------------------------------------

Future getNameSecandSec() async
  {
    
    final  url = "http://192.168.0.114:80/usersInfo/getNameSecandSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body);
    return responsebody['NT'];
  }

//----------------------------Get Name Third sec ---------------------------------------

Future getNameThirdSec() async
  {
    
    final  url = "http://192.168.0.114:80/usersInfo/getNameThirdSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body);
    return responsebody['NT'];
  }



//-----------------------------Get users same sec---------------------------------------


List shuffle(List array) {
    var random = Random(); 

   
    if(array.length>6)
    {
  for (var i = 6; i > 0; i--) {

    
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
    }
    else{
  for (var i = array.length - 1; i > 0; i--) {

    
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;

    }
  
}


Future<List> getUsersSameSec() async
  {
   
    final  url = "http://192.168.0.114:80/usersInfo/usersSameSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body) as List<dynamic>;

    return shuffle(responsebody.reversed.toList());
    //return responsebody.reversed.toList();
  }

//----------------------------get Users Second Sec---------------------------------------

Future<List> getUsersSecondSec() async
  {
   
    final  url = "http://192.168.0.114:80/usersInfo/getUsersSecondSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody =  json.decode(response.body) as List<dynamic>;
  return shuffle(responsebody.reversed.toList());
  }
//-----------------------get Users Third Sec-------------------------------

Future<List> getUsersThirdSec() async
  {
    
    final  url = "http://192.168.0.114:80/usersInfo/getUsersThirdSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;
   return shuffle(responsebody.reversed.toList());
  }

//-----------------------get Users Fourth Sec-------------------------------

Future<List> getUsersFourthSec() async
  {
   
    final  url = "http://192.168.0.114:80/usersInfo/getUsersFourthSec?currentUser=$currentUser";
    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;
  return shuffle(responsebody.reversed.toList());
  }


// //-----------------------get Users Fifth Sec-------------------------------

// Future<List> getUsersFifthhSec() async
//   {
    
//     final  url = "http://192.168.0.114:80/usersInfo/getUsersFifthhSec";
//     final  response = await http.get(Uri.parse(url));
//     final  responsebody = json.decode(response.body) as List<dynamic>;
//     return responsebody.reversed.toList();
//   }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black.withOpacity(0.6),
        appBar: AppBar(
          title: Text("Work Book"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ),
        endDrawer: Drawer(
          backgroundColor: Color.fromARGB(255, 66, 64, 64),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("لاسم"),
                accountEmail: Text("الايميل"),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(),
              ),

              // DrawerHeader(child: Image(image: AssetImage("images/logo.jpg"))),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  autoplayDuration: Duration(seconds: 10),
                  dotSize: 6.0,
                  dotBgColor: Colors.black.withOpacity(0.2),
                  dotIncreasedColor: Colors.red.withOpacity(0.5),
                  dotPosition: DotPosition.bottomCenter,
                  showIndicator: true,
                  images: [
                    Image.asset(
                      "images/workbook.png",
                      fit: BoxFit.cover,
                    ),
                    InkWell(
                      child: GridTile(child: Image.asset("images/aboutus.png")),
                      onTap: () {
                        showModalBottomSheet(
                          enableDrag: true,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          barrierColor: Colors.grey.withOpacity(0.2),
                          context: context,
                          builder: (context) => ListView(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 3.0,
                                    width: 40.0,
                                    color: Color(0xFF32335C),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.withOpacity(.3),
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'معلومات عنا ',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.5),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "١٢+",
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              "نوع عمل",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.5),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "٢٧٥+",
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              "عامل",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(color: Colors.grey.withOpacity(0.5)),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Title(
                                              color: Colors.black,
                                              child: Text(
                                                "لماذا نحن موجودون؟",
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "يجعل موقعنا الامر سهلا في ايجاد عامل لتلبية حاجتك مما يوفر عليك الوقت واحيانا المال,وبالتاكيد نفس الشيء بالنسبة للعامل.\nاعثر على عامل او عمل من منزلك وببضع خطوات فقط.\n",
                                          ),
                                          Text(
                                              "تأسس موقعنا في عامل 2022, لتبسيط عملية العثور على عامل او عمل بوقت بسيط واسعار معقولة.\n"),
                                          Divider(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          Title(
                                              color: Colors.black,
                                              child: Text(
                                                "كيفية الاستخدام",
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "منصتنا سهلة الاستخدام وذات شفافية عالية للعثور على عامل او عمل,وذلك بناءً على التقيمات والخبرات. \n",
                                          ),
                                          Text(
                                              "ابحث الان عن طلبك واختر ما تحتاج,وعلى الفور سنطابق لك الافضل والاعلى تقيما.\n"),
                                          Divider(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child:
                          GridTile(child: Image.asset("images/contact2.png")),
                      onTap: () {
                        showModalBottomSheet(
                          enableDrag: true,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          barrierColor: Colors.grey.withOpacity(0.2),
                          context: context,
                          builder: (context) => ListView(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 3.0,
                                    width: 40.0,
                                    color: Color(0xFF32335C),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.withOpacity(.3),
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'تواصل معنا',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/cont.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ButtonTheme(
                                        minWidth: 350,
                                        child: ElevatedButton(
                                          child:
                                              const Text('اتصل على - 2595000'),
                                          onPressed: () {
                                            _callNumber();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ButtonTheme(
                                        minWidth: 350,
                                        child: ElevatedButton(
                                          child: const Text(
                                              ' WorkBook@gmail.com - راسلنا على  '),
                                          onPressed: () {
                                            _sendingMails();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ButtonTheme(
                                        minWidth: 350,
                                        child: ElevatedButton(
                                          child: const Text(
                                              'Facebook - تواصل عبر'),
                                          onPressed: () {
                                            _launchURL();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ButtonTheme(
                                        minWidth: 350,
                                        child: ElevatedButton(
                                          child: const Text(
                                              'WhatsApp - تواصل عبر '),
                                          onPressed: () {
                                            launchWhatsApp();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: FutureBuilder(
                                      future: getNameUserSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return Text(snapshot.data.toString() ,
                                                      style: TextStyle(fontSize: 22, color: Colors.white),
                                                    );
                                                                            }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Container(
                height: 202,
                child: FutureBuilder<List>(
                                      future: getUsersSameSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           if(snapshot.data!.length>7){
                                           return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: 7,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );
                                           }
                                           else{
                                      return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );

                                           }
                                      
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: FutureBuilder(
                                      future: getNameSecandSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return Text(snapshot.data.toString() ,
                                                      style: TextStyle(fontSize: 22, color: Colors.white),
                                                    );
                                                                            }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Container(
                height: 202,
                child: FutureBuilder<List>(
                                      future: getUsersSecondSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                           if(snapshot.data!.length>7){
                                           return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: 7,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );
                                           }
                                           else{
                                      return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );

                                           }
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: FutureBuilder(
                                      future: getNameThirdSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return Text(snapshot.data.toString() ,
                                                      style: TextStyle(fontSize: 22, color: Colors.white),
                                                    );
                                                                            }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Container(
                height: 202,
                child: FutureBuilder<List>(
                                      future: getUsersThirdSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                          if(snapshot.data!.length>7){
                                           return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: 7,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );
                                           }
                                           else{
                                      return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );

                                           }
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Divider(color: Colors.white),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: Text('أخرى ',style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
              Container(
                height: 202,
                child: FutureBuilder<List>(
                                      future: getUsersFourthSec(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                          if(snapshot.data!.length>7){
                                           return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: 7,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );
                                           }
                                           else{
                                      return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                               if(snapshot.data![index]["UserType"].toString()=='true'||snapshot.data![index]['_id'].toString()==currentUser||snapshot.data![index]["Availability"].toString()=='false')
                                                  return Text('',style: TextStyle(fontSize: 2),) ;

                                                
                                                return buildCard(context,snapshot.data![index]['image'].toString(),snapshot.data![index]['name'].toString(),snapshot.data![index]['work'].toString(),snapshot.data![index]['_id'].toString(),currentUser);
                                                  },
                                                );

                                           }
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
              Divider(color: Colors.white),
            
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
  final Storage storage=Storage();
  
Widget buildCard(BuildContext context ,String ImageUser ,String NameUser,String WorkUser,String IdUser,String currentUser) {

return FutureBuilder<String>(
                        future: storage.downloadURL(ImageUser),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String NewUrl=snapshot.data!.toString();

                                  return Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 220,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 2,
                                          // ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child:  CircleAvatar(
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.green,
                                              backgroundImage:NetworkImage(NewUrl),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text(
                                            NameUser,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          // SizedBox(
                                          //   height: 1,
                                          // ),
                                          Text(
                                            WorkUser,
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.black.withOpacity(0.5)),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            child: FlatButton(
                                              onPressed: () {

                                        
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>workerProfile( UserId:IdUser , CurrentUser:currentUser,)), (route) => true);


                                              },
                                              color: Color.fromARGB(255, 141, 137, 137),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                ' تواصل ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );


                                                          
                           } 
                                                  
                       return Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 220,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 2,
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text(
                                            'جار التحميل',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height:30,
                                          ),
                                         
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                           child: Material(
                                                  child: CircularProgressIndicator(),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );   
                                                  
                                                },  
                                              );




}
