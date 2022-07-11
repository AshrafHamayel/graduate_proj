  

import 'package:flutter/material.dart';


void main() => runApp(const SignupPage());

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
        backgroundColor: Color.fromARGB(255, 37, 35, 36),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child:  Text(
                    //  textDirection: TextDirection.rtl,
    
                    'اشتراك',
                    style: Theme.of(context).textTheme.headline1,
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
    
                    labelText: 'الاسم',
    
                    filled: true, //<-- SEE HERE
                    fillColor: Color.fromARGB(255, 244, 244, 247),
                  ),
                ),
              ),
              Container(
    
               padding: const EdgeInsets.all(10),
                child: TextField(
    
    
                  //controller: nameController,
                  decoration: const InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'الايميل',
    
                    filled: true, //<-- SEE HERE
                    fillColor: Color.fromARGB(255, 244, 244, 247),
                  ),
                ),
              ),
              Container(
               padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'كلمة السر',
                    filled: true, //<-- SEE HERE
                    fillColor: Color.fromARGB(255, 244, 244, 247),
                  ),
                ),
              ),
              Container(
              padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                 // controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    
                    labelText: 'تأكيد كلمة السر',
                    filled: true, //<-- SEE HERE
                    fillColor: Color.fromARGB(255, 244, 244, 247),
                  ),
                ),
              ),
              
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: const EdgeInsets.only(top:50),
    
                  child: ElevatedButton(
                    child: const Text('اشتراك الان ',style:TextStyle(
        fontSize: 20.0, // insert your font size here
     ),),
                    
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                   style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 217, 185, 87)),
    
                  )
                  
                  ),
             
             
            
            ],
          )),
    );
  }
}
