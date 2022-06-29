import 'package:flutter/material.dart';
import 'signup.dart';

void main() => runApp(const SignIn());

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  //static const String _title = 'Sample App';

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
    return Padding(
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
                child: const Text(
                  //  textDirection: TextDirection.rtl,

                  'تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),

                  labelText: 'الايميل',

                  filled: true, //<-- SEE HERE
                  fillColor: Color.fromARGB(255, 244, 244, 247),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'نسيت كلمة السر',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('تسجيل الدخول'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                const Text(
                  'ليس لديك حساب ؟',
                  style: TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                ),
                TextButton(
                  child: const Text(
                    'اشترك الان',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
