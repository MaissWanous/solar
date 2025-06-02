import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.yellow,
     leading: Icon(
       Icons.menu,
     ),
       title: Text(
         'First App'
       ),
       actions: [
         IconButton(
             onPressed:()
    {
      print('Hello 1');
    },
             icon: Icon(
               Icons.notification_important,
             )),
         IconButton(
             onPressed: ()
             {
               print('Hello2');
             },
             icon:
             Icon(
               Icons.search,
             )),

       ],

   ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(50.0),
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(
                 20.0,
               ),
             ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
             child: Stack(
               alignment: Alignment.bottomCenter,
               children: [
                 Image(
                   image: NetworkImage(
                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3KLsKw0jLKi6EOWlMs2QnOvqlopxW-8i54w&s',

                   ),
                   height: 300.0,
                   width:300.0,
                   fit:BoxFit.cover ,
                 ),
                 Container(
                   color: Colors.white,
                   width: 200.0,
                   padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                   ),
                   child: Text(
                     'Flower',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.amber,
                       fontSize: 20.0
                     ),
                   ),
                 ),

               ],
             ),
           ),
         ),
       ],
     ),

     );
 }

}