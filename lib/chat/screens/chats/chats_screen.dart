// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field
import 'package:flutter/material.dart';
import '../../../SettingsPage.dart';
import '../../../main.dart';
import 'components/body.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
   return Directionality(textDirection: TextDirection.rtl, 
    child: Scaffold(
      body: Body(),
    
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
//Directionality
      drawer: Drawer(
        
          child: ListView(
            
            children: <Widget>[
              
                // ignore: prefer_const_constructors
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
          

            ],

          ),


      ),
    ),
    
    );


  }

 

}
