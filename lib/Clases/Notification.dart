//
// import 'package:agretech_app/Pages/home_page.dart';
// import 'package:flutter/material.dart';
//
// class Notification extends State<>{
//   void GenerateNotification(){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Stack(
//         children: [
//           Container(
//               height: 90,
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 48,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Note",
//                           style: TextStyle(
//                               fontSize: 18, color: Colors.white),
//                         ),
//                         Text(
//                           "Entered username is wrong!",
//                           style: TextStyle(
//                               fontSize: 12, color: Colors.white),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               )),
//         ],
//       ),
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//     ));
//   }
// }