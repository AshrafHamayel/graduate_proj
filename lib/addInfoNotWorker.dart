
  // ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors, unused_local_variable, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduate_proj/storage_sercice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'signIn.dart';
//void main() => runApp(AddUserInfo());

class AddInfoNotWorker extends StatelessWidget {
    late final String currentUser;
    AddInfoNotWorker
    ({
    required this.currentUser,
  
  });



  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: AddInfoNotWorker_page(
        currentUser:currentUser,
      ),
    );
  }
}

class AddInfoNotWorker_page extends StatefulWidget {
    late final String currentUser;
    AddInfoNotWorker_page
    ({
    required this.currentUser,
  
  });
  @override
  _AddUserInfo createState() => _AddUserInfo(
    currentUser:currentUser,

  );
}
enum cities { everywhere, mycity }
class _AddUserInfo extends State<AddInfoNotWorker_page> {

    late final String currentUser;
    _AddUserInfo
    ({
    required this.currentUser,
  
  });
  
      late final ControllerDescription = TextEditingController();
     late  final ControllerCity = TextEditingController();


//   var UserId;

// Future<String> getUserId() async {
//   SharedPreferences   preferences = await SharedPreferences.getInstance();
//     UserId = await preferences.getString("UserId");
//     print (' UID from _AddUserInfo :');
//   print(preferences.getString("UserId"));

//      return UserId;
//   }
  final Storage storage=Storage();
Future getPer() async {
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


 Future CreatUser(String Description,String City )async {


              
                      if(Description+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل الوصف رجاءً')) );

                      else  if(City+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل المدينة رجاءً')) );

                        
else{

          final fbm = await FirebaseMessaging.instance.getToken();
       var url = "http://192.168.0.114:80/signUp/addNotWorkerInfo?UserId=$currentUser&Description=$Description&City=$City&&LAT=$lat&LONG=$long";
       var response =await http.post(Uri.parse(url));
      var responsebody= jsonDecode(response.body) ;

      // print(responsebody['NT']);
       if (responsebody['NT']=='done')
       {

      print('done');

       Navigator.push( context,MaterialPageRoute(builder: (context) => MyApp()));

   
          
       }
       
      else if (responsebody['NT']=='Email Not exists !')
       {
     
           print('Email Not exists !');

         
       }


      else {
                
                 ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text(' لم يتم الحفظ , هناك خطأ ما')) );

          }

}



    
  }

  @override
  Widget build(BuildContext context) {
      getPer();
  getLatAndLong();
    return Scaffold(

      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
       elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {

            Navigator.pop(context,
              MaterialPageRoute(builder: (context) => SignIn()));
          },
        ),
       
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                " انشاء حساب جديد  ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 15,
              ),
             
              const SizedBox(
                height: 35,
              ),
              

                
                    
          
               buildTextField("اضف وصف لصفحتك  ", "الاسم", false ,ControllerDescription),
              buildTextField(" ادخل مكان سكنك", "********", false , ControllerCity),

         
         Text( 'رجاءا قم بتفعيل خاصية GPS لحفظ موقعك', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 34, 1, 155)),),




              

              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  ElevatedButton(
                    onPressed: () async{


                   
                    
                       await CreatUser(ControllerDescription.text,ControllerCity.text);

                    },
                    style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),elevation: 2,padding: const EdgeInsets.symmetric(horizontal: 50),primary: Colors.green ),
                    
                    child: const Text(
                      "  تخزين",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                          
                    ),
                  )
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }




  Widget buildTextField(String labelText, String placeholder, bool isTextFields ,TextEditingController myController ) 
  
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller:   myController,

        textAlign: TextAlign.end,
        
        
        decoration: InputDecoration(
          
          // contentPadding: EdgeInsets.all(),
          alignLabelWithHint: true,
          prefixIcon: isTextFields? IconButton(
                
                  onPressed: () {
                    setState(() {
                      

                    });
                  },

                  icon: const Icon(
                    Icons.align_horizontal_left_sharp,
                    color: Colors.grey,
                  ),
                )
              : null,
          border: const OutlineInputBorder(),

          hintText: labelText,
  
         
        ),
      ),
    );
  }
}




