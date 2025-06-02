import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';




class UsersScreen extends StatelessWidget {
  //const UsersScreen({super.key});
  List<UserModel>usrs=[
    UserModel( 1,  'Sdra',  '0994009205'),
    UserModel( 2,  'Farah',  '0994009205'),
    UserModel( 3,  'Aisha',  '0994009205'),
    UserModel( 1,  'Sdra',  '0994009205'),
    UserModel( 2,  'Farah',  '0994009205'),
    UserModel( 3,  'Aisha',  '0994009205'),
    UserModel( 1,  'Sdra',  '0994009205'),
    UserModel( 2,  'Farah',  '0994009205'),
    UserModel( 3,  'Aisha',  '0994009205'),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body:ListView.separated(
          itemBuilder: (context,index) =>buildUserItem(usrs[index]),
          separatorBuilder:(context,index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: usrs.length,)
    );
  }
}

Widget buildUserItem(UserModel user) =>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 25.0,
        child: Text(
          '${user.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          Text(
            '${user.phone}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);
