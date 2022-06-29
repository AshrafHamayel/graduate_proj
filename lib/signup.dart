import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 37, 35, 36),
    
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("اشتراك",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 238, 232, 235)

                  ),),
                  SizedBox(height: 20,),
                  Text("انشاء حساب جديد  ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Color.fromARGB(255, 241, 237, 237)),)


                ],
              ),
              Column(

                children: <Widget>[
                  inputFile(label: "الاسم", ),
                  inputFile(label: "الايميل"),
                  inputFile(label: "كلمة السر", obscureText: true),
                  inputFile(label: "تأكيد كلمة السر ", obscureText: true),
                   inputFile(label: "dfsfsd",),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),



                    )

                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {},
                  color: Colors.amberAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "اشترك الان", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,

                  ),
                  ),

                ),



              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("؟ لديك حساب بالفعل ",style:TextStyle(color: Colors.white),),
                  
                  Text(" سجل الدخول", style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                     color: Colors.white,

                  ),
                  )
                ],
              )



            ],

          ),


        ),

      ),

    );
  }
}



// we will be creating a widget for text field
Widget inputFile({label, obscureText = false})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0,
                horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              ),

            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}