import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' ;
import 'package:shared_preferences/shared_preferences.dart';
import 'mainPage.dart';
import 'signIn.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  
   Future<Widget> userSignedIn()async{
  
  SharedPreferences    preferences = await SharedPreferences.getInstance();
    var UserId = preferences.getString("UserId");
  print(preferences.getString("UserId"));


    User? user = FirebaseAuth.instance.currentUser;
    if( UserId !=null)
    {
      return mainPage(
        currentUser:UserId,
      );
    }
    else
    {
      return SignIn();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:const  TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            color: Colors.red,
            decorationColor: Colors.amber
          )
        )

      ),
      home:FutureBuilder(
        future: userSignedIn(),
        builder: (context,AsyncSnapshot<Widget> snapshot){
          if(snapshot.hasData){
            return snapshot.data!;
          }
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
          );
        })
      // mainPage(),
    );
  }
}
