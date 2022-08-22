
  // ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors, unused_local_variable, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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


//   var UserId;

// Future<String> getUserId() async {
//   SharedPreferences   preferences = await SharedPreferences.getInstance();
//     UserId = await preferences.getString("UserId");
//     print (' UID from _AddUserInfo :');
//   print(preferences.getString("UserId"));

//      return UserId;
//   }
  final Storage storage=Storage();

 Future CreatUser(String Work, String Description, String PhoneNumber ,String Salary,String City )async {
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

                      else  if(City+"--"=="--")
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( content: Text('ادخل المدينة رجاءً')) );

                        
else{

          final fbm = await FirebaseMessaging.instance.getToken();
       var url = "http://192.168.0.114:80/signUp/addInfoUser?UserId=$currentUser&Work=$Work&Description=$Description&PhoneNumber=$PhoneNumber&Salary=$Salary&City=$City&Iterest1=$checked";
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
 List<bool?> checked = [false, false, false, false, false, false, false, false];
  List<String> typeOfWork = [
    "مجال عملي",
    "البناء بشكل عام ",
    "الدهان و الجبصين",
    "اعمال الحدائق",
    "التمديدات الصحية و الكهرابئية",
    "القريمد و الديكور",
    " تصليح و صيانة امور متنوعة",
     " صيانة و غسيل مركبات ",
   
  ];

  cities? _city = cities.everywhere;
  Widget _buildcheckbox(bool? chked, String worktype, int Li) {
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
            checked[Li] = chked;
          },
        );
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
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
              

                
                    
              buildTextField("..., نوع العمل : بناء ,  دهان  , قصارة , بليط", "ex@gmail.com", false ,ControllerWork),
               buildTextField("صف نفسك", "الاسم", false ,ControllerDescription),
              buildTextField(" رقم الهاتف", "********", true , ControllerPhoneNumber),
              buildTextField(" الاجرة اليومية بالشيكل", "********", true , ControllerSalary),
                buildTextField(" المدينة", "********", true , ControllerCity),
                ListTile(
                                leading: Icon(Icons.app_registration_rounded),
                                title: Text(
                                  'رجاءا اختر الامور التي تهتم بها',
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
                                                ' اختر اهتماماتك',
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
                                            for (int i = 0; i < 8; i++)
                                              _buildcheckbox(checked[i], typeOfWork[i], i),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),





              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  RaisedButton(
                    onPressed: () async{
                    
                       await CreatUser(ControllerWork.text,ControllerDescription.text,ControllerPhoneNumber.text,ControllerSalary.text,ControllerCity.text);

                    },
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
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




