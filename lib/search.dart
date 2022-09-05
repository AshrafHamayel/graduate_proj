// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, unused_element, non_constant_identifier_names, avoid_unnecessary_containers, prefer_final_fields, unused_field, camel_case_types

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/storage_sercice.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Chats/models/user_model.dart';
import 'ResultSearch.dart';
import 'SettingsPage.dart';
import 'Tenders.dart';
import 'complaint.dart';
import 'main.dart';
import 'signIn.dart';
import 'workerProfile.dart';
import 'Map.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'as Path;
class SearchWorker extends StatefulWidget {
    late final String currentUser;
            late final String name;
   late final String UrlImage;
   
    SearchWorker
    ({
    required this.currentUser,
        required this.name,
    required this.UrlImage,
  
  });
 
  @override
  _SearchWorkerState createState() => _SearchWorkerState(currentUser:currentUser,
     name:name,
        UrlImage:UrlImage,
  
  );
}


enum cities { everywhere, mycity }
enum Works {MyWork,Building,WaterAndElectricity,PaintAndPlaster,Tiles,Worker,GardenCoordinator,Brick,Reformer,Trolleys,VarietyWorker}
class _SearchWorkerState extends State<SearchWorker> {
 late final String currentUser;
           late final String name;
   late final String UrlImage;
    _SearchWorkerState
    ({
    required this.currentUser,
        required this.name,
    required this.UrlImage,
  
  });


 bool checkedClosest = false;

 
  cities? _city = cities.everywhere;
    Works? work = Works.MyWork;
  Widget _buildcheckbox(bool? chked, String worktype) {
    return StatefulBuilder(
      builder: ((context, setState) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            worktype,
            textDirection: TextDirection.rtl,
          ),
          value: chked,
          onChanged: (v) {
            setState(
              () {
                chked = v;
              },
            );
            checkedClosest = chked!;
          },
        );
      }),
    );
  }

  Widget _buildradiobox(String cityname, int Li) {
    return StatefulBuilder(
      builder: ((context, setState) {
        return RadioListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            cityname,
            textDirection: TextDirection.rtl,
          ),
          value: cities.values[Li],
          groupValue: _city,
          onChanged: (cities? value) {
            setState(
              () {
                _city = value;
              },
            );
          },
        );
      }),
    );
  }

    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  
  Widget _buildradioboxWork(String Workname, int Li) {
    return StatefulBuilder(
      builder: ((context, setState) {
        return RadioListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            Workname,
            textDirection: TextDirection.rtl,
          ),
          value: Works.values[Li],
          groupValue: work,
          onChanged: (Works? value) {
            setState(
              () {
                work = value;
              },
            );
          },
        );
      }),
    );
  }


  Future <void>getInfo() async 
  {
    var url = await"http://172.19.32.48:80/myProf/myProf?UserId=$currentUser";
    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
   
   return await responsebody;
  }

  Future getPer(context) async {
    bool ser;
    LocationPermission per;
    ser = await Geolocator.isLocationServiceEnabled();
    if (ser == false) {
      // ignore: avoid_single_cascade_in_expression_statements
      AwesomeDialog(
          context: context,
          //  title: Text("services"),
          body: Text("S not enabled"))
        ..show();
    }
    per = await Geolocator.requestPermission();
    if (per == LocationPermission.denied)
      per = await Geolocator.requestPermission();

    return per;
  }



  late Position myP;
  double? lat, long;

  Future<void> getLatAndLong() async {
    myP = await Geolocator.getCurrentPosition().then((value) => value);
    lat = myP.latitude;
    long = myP.longitude;
    
   
  }
  Future <void>setPos() async {

    var url = await"http://172.19.32.48:80/myProf/setNewPos?UserId=$currentUser&LAT=$lat&LONG=$long";

    var response = await http.post(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }

  

final NameWorker = TextEditingController();
  @override
  Widget build(BuildContext context) {
           getPer(context);
  getLatAndLong();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
           title: Row(
          children: [
          
        
       Text('البحث',style: TextStyle(fontSize: 20),),
          
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
                leading:(
IconButton(
  onPressed: (){  
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
       }, 
       
           icon: Icon(Icons.arrow_back)
)
                ),
      ),
        endDrawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                UserAccountsDrawerHeader(accountName: Text('',style:TextStyle(fontSize: 18,color: Color.fromARGB(255, 243, 243, 243)),), accountEmail: Text(name,style:TextStyle(fontSize: 20,color: Color.fromARGB(255, 243, 243, 243)),),

                 decoration:BoxDecoration(
                  color: Color.fromARGB(255, 2, 20, 3),
                  image: DecorationImage(image: NetworkImage(UrlImage),fit: BoxFit.cover),

                 ),

                ),
               
             
                SizedBox(height: 20,),
                 ListTile(
                    title: Text(" تقديم شكوى ",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.drafts_sharp),
                    subtitle: Text(" Make a complaint"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => myComplaint(UserId:currentUser)));
                    },

                ),
                  SizedBox(height: 20,),

             
              ListTile(
                    title: Text("  تحديث موقعي ",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.edit_location_alt_sharp),
                    subtitle: Text(" My location"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                                   setPos().then((value) =>{

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('تم تحديث الموقع')) ),
                      });


                    },

                ),
               SizedBox(height: 20,),

                 ListTile(
                    title: Text("العطاءات",style: TextStyle(fontSize: 18),),
                    leading: Icon(Icons.grading_outlined),
                    subtitle: Text("مناقصات و عطاءات"),
                    isThreeLine: true,
                    dense: true,
                    onTap: (){
                               
                        Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => Tenders(UserId:currentUser,name:name,
        UrlImage:UrlImage,)));
                    },

                ),
                SizedBox(height: 20,),

               ListTile(
                    title: Text("الاعدادات",style: TextStyle(fontSize: 18),),
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
      body: FutureBuilder(
             future:getInfo(),
     builder: (BuildContext context, AsyncSnapshot snapshot) {

      if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
        String Cityy =snapshot.data['city'].toString();
         String Workk =snapshot.data['work'].toString();

          List<String> typeOfWork =
   [
    '  مهن مشابه لمجال عملك  ($Workk)',
    ' البناء بشكل عام ',
    '  التميديات الكهربائية و الصحية ',
    'الدهان و ديكورات الجبصين ',
    ' البلاط',
    ' العمال المساعدين ',
    ' منسق حدائق و جنائن ',
    ' القرميد و ديكوراته',
    ' صيانة و تصليح',
    ' ما يخص المركبات',
    ' اعمال متنوعة',
  ];

         List<String> myCH = [
                    "اي مكان",
                    "$Cityy",
                    
                  ];
          return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext contxt, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                   controller: NameWorker,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResultSearch(
                               currentUser:currentUser,
                                NameWorker:NameWorker.text,
                                Work:work.toString(),
                                City:_city.toString(),
                                closest:checkedClosest.toString(),
                                name:name,
                                UrlImage:UrlImage,

                            
                              
                              )), (route) => true);

                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                      ),
                      hintText: 'ادخل اسم العامل',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          barrierColor: Colors.grey.withOpacity(0.2),
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 3.0,
                                  width: 40.0,
                                  color: Color(0xFF32335C)),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.withOpacity(.3),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    StatefulBuilder(
                                      builder: ((context, setState) {
                                        return TextButton(
                                          child: const Text(
                                            'اعادة تعيين',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                          onPressed: () {
                                          
                                             checkedClosest = false;
                                           work = Works.MyWork;
                                            _city = cities.everywhere;

                                          },
                                        );
                                      }),
                                    ),
                                    SizedBox(
                                      width: 200,
                                    ),
                                    Text(
                                      'الفلاتر',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on_outlined),
                                title: Text(
                                  'الموقع',
                                  textDirection: TextDirection.rtl,
                                ),
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
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                            height: 3.0,
                                            width: 100.0,
                                            color: Color(0xFF32335C)),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                'موقع العمل',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 1, 8, 8),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Container(
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: IconButton(
                                                          color: Colors.grey,
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.search,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        hintText:
                                                            'بحث عن مدينة',
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                for (int i = 0; i < 2; i++)
                                                  _buildradiobox(myCH[i], i),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                
                                leading: Icon(Icons.handyman_outlined),
                                title: Text(
                                  'العمل',
                                  textDirection: TextDirection.rtl,
                                ),
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
                                    builder: (context) => ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext contxt, int index) =>Column(
                                      
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                            height: 3.0,
                                            width: 40.0,
                                            color: Color(0xFF32335C)),
                                        Container(
                                          
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                'نوع العمل',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                        ),
                                        Column(
                                           
                                          children: [
                                             for (int i = 0; i < 11; i++) 
                                              _buildradioboxWork(typeOfWork[i], i),
                                          ],
                                        ),
                                      ],
                                    ),

                                    )
                                  );
                                },
                              ),
                            //  _buildcheckbox(checkedClosest, 'ترتيب حسب الاعلى تقييما'),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(.3),
                            ),
                            top: BorderSide(
                              color: Colors.grey.withOpacity(.3),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.filter_list,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            Text(
                              'الفلاتر ',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              //     Container(
              //   height: 360.0,
              //   width: double.infinity,
              //   child: Carousel(
              //     boxFit: BoxFit.cover,
              //     autoplay: true,
              //     autoplayDuration: Duration(seconds: 10),
              //     dotSize: 3.0,
              //     dotBgColor: Color.fromARGB(255, 142, 245, 173).withOpacity(0.2),
              //     dotIncreasedColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              //     dotPosition: DotPosition.bottomCenter,
              //     showIndicator: true,
              //     images: [
              //       Image.asset(
              //         "images/p1.png",
              //         fit: BoxFit.cover,
              //       ),
              //       Image.asset(
              //         "images/aboutus.png",
              //         fit: BoxFit.cover,
              //       ),
              //       Image.asset(
              //         "images/contact2.png",
              //         fit: BoxFit.cover,
              //       ),
              //     ],
              //   ),
              // ),
                                
            ],
          ),
        ),
      );

      }
       
   return Container(
            
        child: Column(
          
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.2,
                  image: const AssetImage('images/LO.png'),
                ),
              ),
            ),
          ],
        ),
       
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: CircularProgressIndicator(),
                  ),
                ),
               
              ],
          
        )

            
      ],
    
    
    ));
     }
     

      ),
    );
  }



}
