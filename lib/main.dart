import 'package:flutter/material.dart';
import 'package:udemy_flutter/Modules/Login/Login.dart';
//import 'package:udemy_flutter/bmiResult_screen.dart';
import 'package:udemy_flutter/modules/general_preview/general_preview.dart';

import 'Modules/bmi/bmi_screen.dart';
import 'modules/counter/counter_screen.dart';
import 'Modules/Home/home-screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home:General_Preview(),
     );
  }


}




