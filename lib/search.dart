// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, unused_element, non_constant_identifier_names, avoid_unnecessary_containers, prefer_final_fields, unused_field, camel_case_types

import 'package:flutter/material.dart';
import 'package:graduate_proj/workersDetails.dart';
import 'package:path/path.dart';

import 'main.dart';

class Workers extends StatefulWidget {
  @override
  _WorkersState createState() => _WorkersState();
}

enum cities { everywhere, mycity }

class _WorkersState extends State<Workers> {
  List<bool?> checked = [false, false, false, false, false];
  List<String> typeOfWork = [
    "عامل بناء",
    "عامل دهان",
    "عامل بلاط",
    "منسق حدائق",
    "عتال"
  ];
  List<String> myCH = [
    "اي مكان",
    "بيتا",
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

  Widget _buildradiobox(String cityname, int Li) {
    return StatefulBuilder(
      builder: ((context, setState) {
        return RadioListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            cityname,
            textDirection: TextDirection.rtl,
          ),
          value: cities.values[Li],
          groupValue: _city,
          onChanged: (cities? value) {
            setState(
              () {
                _city = value;
              },
            );
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                      ),
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
                                      color: Colors.grey.withOpacity(.3),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'اعادة تعيين',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        for (int i = 0; i < 5; i++) {
                                          checked[i] = false;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 200,
                                    ),
                                    Text(
                                      'الفلاتر',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on_outlined),
                                title: Text(
                                  'الموقع',
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
                                                'موقع العمل',
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
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 1, 8, 8),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Container(
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: IconButton(
                                                          color: Colors.grey,
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.search,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        hintText:
                                                            'بحث عن مدينة',
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                for (int i = 0; i < 2; i++)
                                                  _buildradiobox(myCH[i], i),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.handyman_outlined),
                                title: Text(
                                  'العمل',
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
                                        Icon(
                                          Icons.drag_handle_outlined,
                                        ),
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
                                                'نوع العمل',
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
                                            for (int i = 0; i < 5; i++)
                                              _buildcheckbox(
                                                  checked[i], typeOfWork[i], i),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(.3),
                            ),
                            top: BorderSide(
                              color: Colors.grey.withOpacity(.3),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.filter_list,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            Text(
                              'الفلاتر ',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WorkersData(),
                              ),
                            );
                          },
                          color: Colors.red[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'تواصل ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
