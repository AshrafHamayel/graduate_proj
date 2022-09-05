
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

class AddUserInfo extends StatelessWidget {
    late final String currentUser;
    AddUserInfo
    ({
    required this.currentUser,
  
  });



  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: AddUser_Info(
        currentUser:currentUser,
      ),
    );
  }
}

class AddUser_Info extends StatefulWidget {
    late final String currentUser;
    AddUser_Info
    ({
    required this.currentUser,
  
  });
  @override
  _AddUserInfo createState() => _AddUserInfo(
    currentUser:currentUser,

  );
}
enum cities { everywhere, mycity }
class _AddUserInfo extends State<AddUser_Info> {

    late final String currentUser;
    _AddUserInfo
    ({
    required this.currentUser,
  
  });
    
      late final ControllerWork = TextEditingController();
      late final ControllerDescription = TextEditingController();
      late final ControllerPhoneNumber = TextEditingController();
      late final ControllerSalary = TextEditingController();
     late  final ControllerCity = TextEditingController();


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


 Future CreatUser(String Work, String Description, String PhoneNumber ,String Salary )async {


  print('lat');
    print(lat);
    print('long');
    print(long);

                    if(Work+"--"=="--")
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل نوع العمل رجاءً')) );

                     else if(Description+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل الوصف رجاءً')) );

                    else if(PhoneNumber+"--"=="--")
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل رقم الهاتف رجاءً')) );

                    else  if(Salary+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل الاجرة اليومية رجاءً')) );

                      else  if(dropdownvalue+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل المدينة رجاءً')) );

                        
else{

          final fbm = await FirebaseMessaging.instance.getToken();
       var url = "http://172.19.32.48:80/signUp/addInfoUser?UserId=$currentUser&Work=$Work&Description=$Description&PhoneNumber=$PhoneNumber&Salary=$Salary&City=$dropdownvalue&&LAT=$lat&LONG=$long";
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

      appBar:AppBar(
          title: Text("بناء الملف الشخصي"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 66, 64, 64),
         // leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
              

                
                    
              buildTextField("..., نوع العمل : بناء ,  دهان  , قصارة , بليط", "ex@gmail.com", false ,ControllerWork),
              buildTextField("صف نفسك", "الاسم", false ,ControllerDescription),
              buildTextField(" رقم الهاتف", "********", false , ControllerPhoneNumber),
              buildTextField(" الاجرة اليومية بالشيكل", "********", false , ControllerSalary),
            //  buildTextField(" ادخل مكان سكنك", "********", false , ControllerCity),
              buildDrop(ControllerCity),

         
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

                      
                   
                    
                       await CreatUser(ControllerWork.text,ControllerDescription.text,ControllerPhoneNumber.text,ControllerSalary.text);

                    },style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
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


  late String dropdownvalue ;

  Widget buildDrop(TextEditingController contr){
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
          value: 'اختر مدينة',
          
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 42,
        
          
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
            dropdownvalue = newValue!;
          
            });
          },
     menuMaxHeight: 500,
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




