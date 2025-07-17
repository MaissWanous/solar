import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/settings_menu.dart';

class Profile_Customer extends StatefulWidget {

  @override
  State<Profile_Customer> createState() => _Profile_CustomerState();
}


const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);


class _Profile_CustomerState extends State<Profile_Customer> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         children: [
           Row(
             children: [
               CircleAvatar(
                 radius: 40.0,
                 backgroundColor:yellow,
               ),
               SizedBox(width: 20.0,),
               Text(
                 'Ibrahem Smith',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 20.0,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
           ),
           SizedBox(height: 55.0,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Expanded(
                 child: Row(
                   children: [
                     Container(
                       height: 60.0,
                       width: 60.0,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color: off_white,
                       ),
                       child: Center(
                         child: Icon(
                           Icons.phone,
                           color: Colors.black,
                           size: 30.0,
                         ),
                       ),
                     ),
                     SizedBox(width: 12.0),
                     Text(
                       '+987456321',
                     ),
                   ],
                 ),
               ),
               SizedBox(width: 20.0),
               Expanded(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Container(
                       height: 60.0,
                       width: 60.0,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color: off_white,
                       ),
                       child: Center(
                         child: Icon(
                           Icons.location_pin,
                           color: Colors.black,
                           size: 30.0,
                         ),
                       ),
                     ),
                     SizedBox(width: 12.0),
                     Text(
                       'Syria,Homs',
                     ),
                   ],
                 ),
               ),
             ],
           ),


         ],
       ),
     ),
    );
  }
}
