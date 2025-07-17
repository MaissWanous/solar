import 'dart:io';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/add_product/add_battery.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Profile_Shopkeeper_Batteries extends StatefulWidget  {
  @override
  State<Profile_Shopkeeper_Batteries> createState() => _Profile_Shopkeeper_BatteriesState();
}
const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);
const Color off_white = Color(0xFFFDF7E8);

var product_nameController = TextEditingController();
var locationController = TextEditingController();
final List<String> options = ['Solar Panels', 'Batteries', 'Inverters'];

class _Profile_Shopkeeper_BatteriesState extends State<Profile_Shopkeeper_Batteries > {
  bool isBottomSheetShown = false;
  String selectedProduct = '';

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildProfileInfo()),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverPersistentHeader(
            pinned: true,
            delegate: _ButtonBarDelegate(
              minHeight: 55,
              maxHeight: 55,
              child: _buildButtonRow(context),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 20.0,
              left: 20.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Column(
                    children: [
                      buildBatteriesItem(context),
                      SizedBox(height: 12.0),
                    ],
                  );
                },
                childCount: 15,
              ),
            ),

          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage('assetss/images/Peerson in working.png'),
              ),
              SizedBox(width: 20.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Felicity',
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Besem Smith',
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 25.0),
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
                      child: Icon(Icons.phone, color: Colors.black, size: 30.0),
                    ),
                    SizedBox(width: 12.0),
                    Flexible(
                      child: Text(
                        '+987456321',
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      child: Icon(Icons.location_pin, color: Colors.black, size: 30.0),
                    ),
                    SizedBox(width: 12.0),
                    Flexible(
                      child: Text(
                        'Syria, Homs',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Container(
      height: 55,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildButton('All', off_white, Colors.black, context, 0),
            SizedBox(width: 10),
            _buildButton('Solar panels', off_white, Colors.black, context, 1),
            SizedBox(width: 10),
            _buildButton('Inverters', off_white, Colors.black, context, 2),
            SizedBox(width: 10),
            _buildButton('Batteries', yellow, Colors.white, context, 3),
          ],
        ),
      ),
    );
  }

}

class _ButtonBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const _ButtonBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4.0 : 0.0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _ButtonBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

Widget _buildButton(String text, Color bg, Color txtColor, BuildContext context, int tabIndex) {
  return Container(
    height: 25.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: bg,
    ),
    child: MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 14),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Layout_Shopkeeper(startIndex: tabIndex)),
        );
      },
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: txtColor, fontSize: 14),
          maxLines: 1,
        ),
      ),
    ),
  );
}

Widget buildBatteriesItem(BuildContext context) =>
    Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: yellow),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundImage: AssetImage('assetss/images/Peerson in working.png'),
                      ),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          'Felicity',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context , MaterialPageRoute(builder: (context)=> Add_Battery()));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20.0,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assetss/images/Batteries1.webp'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Battery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '1000\$',
                    style: TextStyle(
                      color: yellow,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Battery Type: lithium',
                    maxLines: 1,
                  ),
                  Text(
                    'Battery Size: 200',
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        'Review',
                        style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: yellow),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundImage: AssetImage('assetss/images/Peerson in working.png'),
                      ),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          'Felicity',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context , MaterialPageRoute(builder: (context)=> Add_Battery()));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20.0,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assetss/images/Batteries1.webp'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Battery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '1000\$',
                    style: TextStyle(
                      color: yellow,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Battery Type: lithium',
                    maxLines: 1,
                  ),
                  Text(
                    'Battery Size: 200',
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        'Review',
                        style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
