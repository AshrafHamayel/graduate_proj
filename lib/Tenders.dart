// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, deprecated_member_use, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'Chats/models/user_model.dart';
import 'EditProfile.dart';
import 'Ratings.dart';
import 'SettingsPage.dart';
import 'TendersResult.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userInfo.dart';
import 'mainPage.dart';
import 'signIn.dart';
import 'storage_sercice.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/postModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Tenders extends StatelessWidget {
  late final String UserId;
    Tenders
    ({
    required this.UserId,
  
  });
  
    out() async {
SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();


  }
  
  @override
  
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: Tenders_Page( UserId:UserId,),
    
      appBar: AppBar(
        
        // toolbarHeight: 30,
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

    ),
    
    );
  }
}

class Tenders_Page extends StatefulWidget {

    late final String UserId;
    Tenders_Page
    ({
    required this.UserId,
  
  });
  @override
  _TendersPage createState() => _TendersPage(
    UserId:UserId,
  );
}

class _TendersPage extends State<Tenders_Page> {


      late final String UserId;
    _TendersPage
    ({
    required this.UserId,
  
  }); 


  Future <void>getInfo() async {

    var url = await"http://192.168.0.114:80/myProf/myProf?UserId=$UserId";

    var response = await http.get(Uri.parse(url));
    var responsebody = json.decode(response.body);
  

    return await responsebody;
 

  }





  final Storage storage=Storage();
 








Future sendToDB(String imagePath) async {

             var url = "http://192.168.0.114:80/myProf/saveImage?UserId=$UserId&imagePath=$imagePath";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

            

}

  FirebaseFirestore firestore = FirebaseFirestore.instance;





  Widget _buildFullName( String _fullName) {
    TextStyle _nameTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

  
         return Text(
      _fullName,
      style: _nameTextStyle,
    );
    
  }


  Widget _buildSeparator2(Size screenSize)
   {
    return Container(
      width: screenSize.width,
      height: 0.5,
      color: Color.fromARGB(136, 140, 140, 141),
      margin: const EdgeInsets.only(top: 4.0),
    );
  }
late String dropdownvalueCity='اختر مدينة' ;
 late  final ControlleCity = TextEditingController();

  Widget buildDropCity(TextEditingController contr){
    var items = [
	'اختر مدينة',
	'القدس',
	'حيفا',
	'يافا',
	'الخليل',
  'بيت لحم',
  'نابلس',
  'غزة',
  'أريحا',
  'نابلس',
  'طولكرم',
  'رام الله',
  '	جنين',
  'طوباس',
  '	قلقيلية',
  '	سلفيت',
];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField(
           decoration: InputDecoration( border: const OutlineInputBorder(),),
          // Initial Value
          value: dropdownvalueCity,
          
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 18,
        
          
          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
            value: items,
            
            child: Text(items,style: TextStyle(fontSize: 18),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
            dropdownvalueCity = newValue!;
          
            });
          },
     menuMaxHeight: 500,
          ),
    );
  }

late String dropdownvalueWork ='اختر مجال العمل';
 late  final ControlleWork = TextEditingController();
  Widget buildDropWork(TextEditingController contr){
    var items = [
	'اختر مجال العمل',
 ' البناء بشكل عام ',
    'التميديات الكهربائية و الصحية',
    'الدهان و ديكورات الجبصين',
    ' البلاط',
    ' منسق حدائق و جنائن',
    'القرميد و ديكوراته',
    ' صيانة و تصليح',
    ' ما يخص المركبات',
];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField(
           decoration: InputDecoration( border: const OutlineInputBorder(),),
          // Initial Value
          value: dropdownvalueWork,
         
          
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 18,
        
          
          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
            value: items,
            
            child: Text(items,style: TextStyle(fontSize: 18),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
            dropdownvalueWork = newValue!;
          
            });
          },
     menuMaxHeight: 500,
          ),
    );
  }


  Future<List> getTenders() async {

    final  url = "http://192.168.0.114:80/addTenders/myTenders?UserId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();
 

  }

    Future<List> getTendersForWorker() async {

    final  url = "http://192.168.0.114:80/addTenders/getTendersForWorker?UserId=$UserId";

    final  response = await http.get(Uri.parse(url));
    final  responsebody = json.decode(response.body) as List<dynamic>;

    return responsebody.reversed.toList();
 

  }



 late File _file;
  

late File _fileComit;
String imageName='null';

Future<void> showcamera(BuildContext context)async{

return await showDialog(context: context, 
builder: (context){
return AlertDialog(
  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
              const SizedBox(height: 20),

       Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
               child:ElevatedButton.icon(

           onPressed: ()async{
           var pickedImage = await imagepicker.getImage(source: ImageSource.camera);
            if (pickedImage != null) {
      _fileComit = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadFile(path,imageName).then((value) =>
       {
 Navigator.of(context).pop(),
       
       }
       );
   

    } 
    else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image not selected'))
      );
      
    }
              return;
 
          }, 
          icon: Icon(Icons.camera_alt_outlined),  //icon data for elevated button
          label: Text("اللتقاط صورة ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 143, 140, 140)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),

          Row(
               mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child:ElevatedButton.icon(

           onPressed: ()async{
             var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
              if (pickedImage != null) {
      _fileComit = File(pickedImage.path);
       imageName=pickedImage.path.split("/").last;
       final path =pickedImage.path;

   

       print(imageName);
       storage.uploadFile(path,imageName).then((value) =>
       {

        Navigator.of(context).pop(),
         
       
       }
       );
   

    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' لم يتم اختيار الصورة'))
      );
      
    }
    return;
           
          }, 
          icon: Icon(Icons.image),  //icon data for elevated button
          label: Text(" اختر من المعرض ",style:TextStyle(fontSize: 17),), //label text 
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 70, 6, 245)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),

              ),


                  ) 
            ),
          ]
          ),
    ],
  )
  
  
  )
  
  ),

);
}

);
}


Future sendComitToDB(String description,String imageComit ) async 
{

             var url = "http://192.168.0.114:80/addTenders/newtenders?UserId=$UserId&description=$description&imageComplaint=$imageComit&sectionTenders=$dropdownvalueWork&CityTenders=$dropdownvalueCity";
            var response = await http.post(Uri.parse(url));
            var responsebody = json.decode(response.body);

              if (responsebody['NT']=='done')
       {
       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('تم نشر العطاء')) );
       }

       else{

               ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('لم يتم حفظ العطاء')) );

           }



}

  final imagepicker = ImagePicker();

  Widget _buildStatTenders(String nameUser,String description,String ImageUserURL, String ImageTenders ,String Sec,String city,String DateTenders,String _idTen) {


                      return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageTenders),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String ImageURLPost=snapshot.data!.toString();



                       return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageUserURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String UserPostURL=snapshot.data!.toString();

                                  
  return Container(
    margin: const EdgeInsets.all(10.0),
    color: Color.fromARGB(255, 247, 231, 181),
     width: MediaQuery.of(context).size.width * 0.95,
    height: MediaQuery.of(context).size.height * 0.75,
    child: Column(
      children: [
          ListTile(
                leading:CircleAvatar
                (
                radius: 45, // Image radius
                backgroundImage: NetworkImage(UserPostURL),
              ),
                        
                        title: Container(child: Text(nameUser,style: TextStyle(fontSize: 18),)),
                        trailing: IconButton(
                            onPressed: () {
                              
                            },
                            icon: Icon(Icons.more_vert_outlined)
                            ),
                        isThreeLine: true,
                        subtitle: Text(DateTenders),
                      ),


 _buildSeparator2(MediaQuery.of(context).size),
Row( 
               children:  [
                
                  const SizedBox(width: 30.0),
                Text('مجال العطاء : $Sec',  style: TextStyle(color: Color.fromARGB(255, 64, 64, 65), fontSize: 13, ),
            ),
               ],
            ),

 const SizedBox(width: 20.0),
Row( 
               children:  [
                
                  const SizedBox(width: 30.0),
                Text('مدينة العطاء : $city',  style: TextStyle(color: Color.fromARGB(255, 64, 64, 65), fontSize: 13, ),
            ),
               ],
            ),


 _buildSeparator2(MediaQuery.of(context).size),
         Row( 
               children:  [

                  const SizedBox(width: 30.0),
                Text('الوصف : $description',  style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 22, 7, 7), fontSize: 15, ),
            ),
               ],
            ),


       Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(ImageURLPost),
            //  colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {},
              ),
             width: MediaQuery.of(context).size.width * 0.86,
    height: MediaQuery.of(context).size.height * 0.4195,
              fit: BoxFit.cover,
            ),
            
          ],
        ),
        
      ),
     

                    Row(
                        children: <Widget>[
                            Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.3)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TendersResult( TendersId:_idTen,currentUser:UserId)), (route) => false);

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Color.fromARGB(255, 158, 158, 158)
                                                        .withOpacity(.3)))),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.group_add_rounded,
                                              color: Color.fromARGB(255, 129, 180, 127),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Text(
                                             'عرض المتقدمين للعطاء',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                 color: Color.fromARGB(255, 0, 0, 0),
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                     _buildSeparator2(MediaQuery.of(context).size),


      ]

  ),
  );
   
                            } 
                                                   
                                                   
                                                   
                                                    else 
                                                    {
                                                      return Text('بانتظار التحميل ...');
                                                        //return CircularProgressIndicator();
                                                    }
                                                },  
                                              );







                               
                            } 
                                                    else 
                                                    {
                                                        return Text(' ');
                                                    }
                                                },  
                                              );
                              
         
  }


 Future <void>AddToApplicants(String Tid) async
  {

    var url = await"http://192.168.0.114:80/addTenders/AddToApplicants?TendersId=$Tid&currentUser=$UserId";

    var response = await http.post(Uri.parse(url));
var responsebody = json.decode(response.body);
    return await responsebody;
 

  }


 Widget _buildStatTendersForWorker(String nameUser,String description,String ImageUserURL, String ImageTenders ,String DateTenders,String _idTen) {


                      return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageTenders),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String ImageURLPost=snapshot.data!.toString();



                       return  FutureBuilder<String>(
                        future: storage.downloadURL(ImageUserURL),
                        builder: (BuildContext context, AsyncSnapshot <String>snapshot)
                        {
                            if (snapshot.hasData)
                             {
                                String UserPostURL=snapshot.data!.toString();

                                  
  return Container(
    margin: const EdgeInsets.all(10.0),
    color: Color.fromARGB(255, 194, 194, 194),
     width: MediaQuery.of(context).size.width * 0.95,
    height: MediaQuery.of(context).size.height * 0.70,
    child: Column(
      children: [
          ListTile(
                leading:CircleAvatar
                (
                radius: 45, // Image radius
                backgroundImage: NetworkImage(UserPostURL),
              ),
                        
                        title: Container(child: Text(nameUser,style: TextStyle(fontSize: 18),)),
                        trailing: IconButton(
                            onPressed: () {
                              
                            },
                            icon: Icon(Icons.more_vert_outlined)
                            ),
                        isThreeLine: true,
                        subtitle: Text(DateTenders),
                      ),






         Row( 
               children:  [

                  const SizedBox(width: 30.0),
                Text('الوصف : $description',  style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 22, 7, 7), fontSize: 15, ),
            ),
               ],
            ),


       Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(ImageURLPost),
            //  colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {},
              ),
             width: MediaQuery.of(context).size.width * 0.86,
    height: MediaQuery.of(context).size.height * 0.4195,
              fit: BoxFit.cover,
            ),
            
          ],
        ),
        
      ),
     

                    Row(
                        children: <Widget>[
                            Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              Colors.grey.withOpacity(0.3)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
            AddToApplicants(_idTen).then((value) =>{
                   Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => Tenders(UserId:UserId))),
                      });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Color.fromARGB(255, 158, 158, 158)
                                                        .withOpacity(.3)))),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.widgets_rounded,
                                              color: Color.fromARGB(255, 245, 128, 124),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10)),
                                            Text(
                                             'تقديم للعطاء',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                 color: Color.fromARGB(255, 0, 0, 0),
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                     _buildSeparator2(MediaQuery.of(context).size),


      ]

  ),
  );
   
                            } 
                                                   
                                                   
                                                   
                                                    else 
                                                    {
                                                      return Text('بانتظار التحميل ...');
                                                        //return CircularProgressIndicator();
                                                    }
                                                },  
                                              );







                               
                            } 
                                                    else 
                                                    {
                                                        return Text(' ');
                                                    }
                                                },  
                                              );
                              
         
  }



Future<void> showCominet(BuildContext context)async{

return await showDialog(context: context, 
builder: (context){

return AlertDialog(


  content: Form(child: Directionality(textDirection: TextDirection.rtl,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [

      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
       
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.30,
                  image:FileImage(_fileComit),
                  child: InkWell(
                    onTap: () {
                    
                          
                    },
                    // child: const Align(
                    //   child: Padding(
                    //     padding: EdgeInsets.fromLTRB(10, 140, 50, 10),
                    //     child: Text(
                    //       '',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w900,
                    //           color: Colors.white70,
                    //           fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
    ],
  )
  
  
  )
  
  ),
  actions:<Widget> [
TextButton(
  onPressed: (){  
                Navigator.of(context).pop();
       }, 
       
       child: Text("موافق",style:const TextStyle( color: Color.fromARGB(255, 22, 0, 216), fontSize: 17.0,),))
  ],
);
}

);
}

    final TextEditingController  MyTenders = TextEditingController();

 Widget _buildTenders() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Card(
          child: Column(
            children:  <Widget>[
          Card(
            color: Color.fromARGB(255, 220, 248, 217),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 3, //or null 
                decoration: InputDecoration.collapsed(hintText: "اضف وصف"),
                controller:MyTenders ,
              ),
            )
          )
        ]
          ),
        ),
      ),
    );
  }
Widget _buildComit() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 67,
        width: 150,
        child: Card(
          child: Column(
            children: <Widget>[
            
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)),
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                           
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                          
                          )))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {

                                  showcamera(context).then((value) =>
                                        {

                                          showCominet(context),

                                        });
                           
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color.fromARGB(255, 126, 207, 131),
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text(
                                  ' اضف صورة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 15, 10, 10), fontSize: 16),
                                ),
                              ],
                            ),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

Widget _buildButtons() {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:25.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child:InkWell(
              onTap: () => {
                   
       sendComitToDB(MyTenders.text,imageName).then((value) =>
       {

    Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => Tenders(UserId:UserId))),


        })

       

              },
              child: Container(
                height: 50.0,
              
                decoration: BoxDecoration(
                  border: Border.all(),
                  color:Color(0xFF404A5C),
                ),
                child:Center(
                  child: Text( "طرح العطاء",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5,
                    ),
                  ),
                )
              ),
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
       
    Size screenSize = MediaQuery.of(context).size;
    


         return Container (
      
      child: Scaffold(
        
         body: FutureBuilder(
                     future:getInfo() ,
                     
       builder: (BuildContext context, AsyncSnapshot snapshot) 
   {   

       if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData)
       {
         
    String nm=snapshot.data["name"].toString();
                    if(snapshot.data["UserType"].toString()=='true')
                    {
 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 18.0),

                      Text('مرحبا بك في صفحة العطاءات',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 32, 7, 255)),),
                      _buildSeparator2(screenSize),

                       _buildTenders(),
                       _buildComit(),
                     const SizedBox(height: 20.0),
                     buildDropWork(ControlleWork),
                   const SizedBox(height: 20.0),

                     buildDropCity(ControlleCity),
                     _buildButtons(),

                      SizedBox(
                        height: 10,
                      ),


             Text('العطاءات التي قمت بطرحها',style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 252, 89, 89)),),

                   Container(
                height: 440,
                child: FutureBuilder<List>(
                                      future: getTenders(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                     
                                         return _buildStatTenders(snapshot.data![index]['name'].toString(),snapshot.data![index]['description'].toString(),snapshot.data![index]['imageuser'].toString(),snapshot.data![index]['imageTenders'].toString(),snapshot.data![index]['Section'].toString(),snapshot.data![index]['CityTenders'].toString(),snapshot.data![index]['date'].toString(),snapshot.data![index]['_id'].toString());
                                                  },
                                                );
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
                     
          
                    ],
                  ),
                ),
              ),
            ],
          );

                  }








                  else{

 return Stack(
            children: <Widget>[
          
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 18.0),

                      Text('يمكنك هنا مشاهدة العطاءات المطروحة',style: TextStyle(fontSize: 22,color: Color.fromARGB(255, 32, 7, 255)),),
                    Text('التي تخص مدينتك و مجال عملك',style: TextStyle(fontSize: 22,color: Color.fromARGB(255, 32, 7, 255)),),

                      _buildSeparator2(screenSize),
                      
                      

                      SizedBox(
                        height: 10,
                      ),
                   Container(
                height: 500,
                child: FutureBuilder<List>(
                                      future: getTendersForWorker(),
                                      builder: (context,snapshot){

                                       if (snapshot.hasData)
                                         {
                                           
                                         return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index)
                                                  {
                                     
                                         return _buildStatTendersForWorker(snapshot.data![index]['name'].toString(),snapshot.data![index]['description'].toString(),snapshot.data![index]['imageuser'].toString(),snapshot.data![index]['imageTenders'].toString(),snapshot.data![index]['date'].toString(),snapshot.data![index]['_id'].toString());
                                                  },
                                                );
                                         }
                                        
                                     return Text(' ...جار التحميل '); // or some other widget
                                // return CircularProgressIndicator(); // or some other widget

                                        
                                      }
                                    ),
              ),
                     
          
                    ],
                  ),
                ),
              ),
            ],
          );

                  }


      
      
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
          
          
         },
        ),
      ),
    ); 
     
   
  }
}
