// // import 'package:chat/constants.dart';
// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:graduate_proj/tes.dart';

// import 'constants.dart';

// // import 'components/body.dart';

// class ChatsScreen extends StatefulWidget {
//   @override
//   _ChatsScreenState createState() => _ChatsScreenState();
// }

// class _ChatsScreenState extends State<ChatsScreen> {
//   int _selectedIndex = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("Chats"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Body(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: kPrimaryColor,
//         child: Icon(
//           Icons.person_add_alt_1,
//           color: Colors.white,
//         ),
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }

//   BottomNavigationBar buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: _selectedIndex,
//       onTap: (value) {
//         setState(() {
//           _selectedIndex = value;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
//         BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
//         BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
//         BottomNavigationBarItem(
//           icon: CircleAvatar(
//             radius: 14,
//             backgroundImage: AssetImage("assets/images/user_2.png"),
//           ),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
// }
