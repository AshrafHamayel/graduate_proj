
  // ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors, unused_local_variable, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduate_proj/storage_sercice.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'addInfoNotWorker.dart';
import 'addUserInfo.dart';
import 'signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(SignupPage());

class SignupPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: Signup_Page(),
    );
  }
}

class Signup_Page extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<Signup_Page> {
  bool showPassword = false;
      final ControllerEmail = TextEditingController();
      final ControllerName = TextEditingController();
      final ControllerPass = TextEditingController();
      final ControllerconfPass = TextEditingController();

 bool AccountTypy = false;
 GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late File iimage;

showAlertDialog(String textMessage) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
             Navigator.of(context).pop();

     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Abort"),
    // ignore: unnecessary_string_interpolations
    content: Text("$textMessage"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
shareEamil(String UserId)async
{
  
          SharedPreferences preferences =await SharedPreferences.getInstance();
          preferences.setString("UserId", UserId);
           
        
}
  final Storage storage=Storage();

 Future CreatUser(String email, String name, String password ,String confPassword )async {
                    if(email+"--"=="--")
                        showAlertDialog('Enter the Email!');
                     else if(name+"--"=="--")
                        showAlertDialog('Enter the name!');    
                    else if(password+"--"=="--")
                        showAlertDialog('Enter the password!');     
                    else  if(confPassword+"--"=="--")
                        showAlertDialog('Enter Confirm Password!');     
                        
else{

          final fbm = await FirebaseMessaging.instance.getToken();
          String T=AccountTypy.toString();
       var url = "http://192.168.0.114:80/signUp/signUp?email=$email&name=$name&password=$password&confPassword=$confPassword&fbm=$fbm&userType=$T";
       var response =await http.post(Uri.parse(url));
      var responsebody= jsonDecode(response.body) ;

      // print(responsebody['NT']);
       if (responsebody['NT']=='done')
       {


    DocumentSnapshot userExist = await firestore.collection('users').doc(responsebody['uid'].toString()).get();

    if(userExist.exists)
    {
          showAlertDialog(' لديك حساب بالفعل');

    }
    
                    else
                    {
                         firestore.collection('users').doc(responsebody['uid'].toString()).set({
                                                  'email':email,
                                                  'name':name,
                                                  'image':'https://firebasestorage.googleapis.com/v0/b/work-book-62ba4.appspot.com/o/Images%2FNoImage.jpg?alt=media&token=74a4be84-df37-4510-b88e-431e980e608e',
                                                  'uid':responsebody['uid'].toString(),
                                                  'token':responsebody['token'].toString(),
                                                  'date':DateTime.now(),
                                                });  
                                          
                                           shareEamil(responsebody['uid'].toString()).then((value) =>{
                                            if(AccountTypy)
                                            {
                                            Navigator.push( context,MaterialPageRoute(builder: (context) => AddInfoNotWorker(currentUser:responsebody['uid'].toString(),))),        
                                            }
                                                 

                                            else
                                            {
                                            Navigator.push( context,MaterialPageRoute(builder: (context) => AddUserInfo(currentUser:responsebody['uid'].toString(),))),
                                            }
                                            


                      });
                          }
      

          
       }
       
      else if (responsebody['NT']=='Email exists !')
       {
     
           showAlertDialog('هذا الحساب موجود بالفعل ');
       
       }

      else if (responsebody['NT']=='Invalid Email !')
       {
      
           showAlertDialog('ايميل غير صالح ');

       }
        else if (responsebody['NT']=='password does not match')
       {
      
                    showAlertDialog('كلمة السر غير متطابقة');

       }


      else {
                    showAlertDialog('خطأ ');

          }

}



    
  }


  uploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      iimage = File(pickedImage.path);
    } else {}
  }

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
            AccountTypy = chked!;
          },
        );
      }),
    );
  }

  final imagepicker = ImagePicker();
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
               buildTextField("الاسم", "الاسم", false ,ControllerName),
              buildTextField("الايميل", "ex@gmail.com", false ,ControllerEmail),
              buildTextField("كلمة السر", "********", true , ControllerPass),
             
               buildTextField("تأكيد كلمة السر", "********", true , ControllerconfPass),
                _buildcheckbox(AccountTypy, 'انا لست عامل '),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  ElevatedButton(
                    onPressed: () async{
                    
                       await CreatUser(ControllerEmail.text,ControllerName.text,ControllerPass.text,ControllerconfPass.text);

                    },style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),elevation: 2,padding: const EdgeInsets.symmetric(horizontal: 50),primary: Colors.green ),
                   
                    child: const Text(
                      " اشتراك الان",
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

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField ,TextEditingController myController ) 
  
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller:    myController,

        textAlign: TextAlign.end,
        
        obscureText: isPasswordTextField ? showPassword : false,
        
        decoration: InputDecoration(
          
          // contentPadding: EdgeInsets.all(),
          alignLabelWithHint: true,
          prefixIcon: isPasswordTextField
              ? IconButton(
                
                  onPressed: () {
                    setState(() {
                      
                      showPassword = !showPassword;
                    });
                  },

                  icon: const Icon(
                    Icons.remove_red_eye,
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



