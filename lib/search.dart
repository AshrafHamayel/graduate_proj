// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:graduate_proj/workersDetails.dart';
import 'package:path/path.dart';

class Workers extends StatefulWidget {
  @override
  _WorkersState createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: (){
          },
          icon: const Icon(
            Icons.search,
            color: Colors.green,
          ),
        ),
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text('العمال'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
      ),
      
      body: ListView.builder(
        
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (BuildContext contxt, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    
                child: Column(
                  
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        
                          height: 50,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.black26),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                          
                       
                            decoration: InputDecoration(
                            
                          suffixIcon:   IconButton( color: Colors.grey, onPressed: () { showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        barrierColor: Colors.orange.withOpacity(0.2),
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                Navigator.of(context).pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('Copy link'),
              onTap: () => {},
            ),
          ],
        ),
      ); },  icon: const Icon(
            Icons.search,
            color: Colors.green,
          ),),
                             
                              hintText: 'بحث',
                            
                              
                              border: InputBorder.none,
                            ),
                           
                          ),
                        ),
                    ),
                   
                        Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                        color: Colors.grey.withOpacity(.3)),
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.filter_list,
                                  color: Colors.grey,
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                                Text(
                                  'الفلاتر ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ],
                            ),
                          )))
                ],
              ),
              SizedBox(height:10),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'الاسم',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'الوظيفة',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 55,
                                  width: 55,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.green,
                                    backgroundImage: NetworkImage(
                                        "https://media.elcinema.com/uploads/_315x420_4d499ccb5db06ee250289a1d8c753b347b8a31d419fd1eaf80358de753581b7b.jpg"),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WorkersData()));
                                },
                                color: Colors.red[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'تواصل ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              
    );
    
  }
}
