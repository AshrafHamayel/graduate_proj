import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'myProfile.dart';
void main() => runApp(MYACC());

class MYACC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 36),
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  late File iimage;
  uploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      iimage = File(pickedImage.path);
    } else {}
  }

  final imagepicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 30,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => myProfile()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              
            },
          ),
        ],
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
                "تعديل الملف الشخصي",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://media.elcinema.com/uploads/_315x420_4d499ccb5db06ee250289a1d8c753b347b8a31d419fd1eaf80358de753581b7b.jpg"))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.all(3),
                            onPressed: () {
                              uploadImage();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("الاسم", "الاسم", false),
              buildTextField("الايميل", "ex@gmail.com", false),
              buildTextField("كلمة السر", "********", true),
              buildTextField("الموقع", "TLV, Israel", false),
              buildTextField("المهنة", "TLV, Israel", false),

              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: const Text("اللغاء",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "حفظ",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
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
          border: const UnderlineInputBorder(),
          hintText: labelText,
        ),
      ),
    );
  }
}
