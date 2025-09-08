import 'package:flutter/material.dart';
import 'package:udemy_flutter/Modules/Login/Login.dart';
import 'package:udemy_flutter/add_link.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/general_preview/general_preview.dart';
import 'package:udemy_flutter/layout/home_layout.dart' as layout;
import 'package:udemy_flutter/modules/home/home_all_customer.dart' as module;
import 'package:udemy_flutter/modules/home/home_solar_panels_customer.dart';
import 'package:udemy_flutter/modules/login/Register.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_all.dart';
import 'package:udemy_flutter/modules/review/rate_product.dart';
import 'package:udemy_flutter/modules/review/review.dart';
import 'package:udemy_flutter/modules/technical/list_technical.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home:General_Preview (),
     );
  }


}




