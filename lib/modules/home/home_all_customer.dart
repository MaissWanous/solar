import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/modules/home/home_batteries_customer.dart';
import 'package:udemy_flutter/modules/home/home_inverters_customer.dart';
import 'package:udemy_flutter/modules/home/home_solar_panels_customer.dart';

class Home_All_Customer extends StatefulWidget {
  @override
  State<Home_All_Customer> createState() => _Home_All_CustomerState();
}

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);

class _Home_All_CustomerState extends State<Home_All_Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        top: true,
        bottom: false,
        child: CustomScrollView(
        slivers: [
        SliverPersistentHeader(
        pinned: true,
        delegate: _ButtonBarDelegate(
        minHeight: 55,
        maxHeight: 55,
        child: Container(
        height: 55,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: LayoutBuilder(
    builder: (context, constraints) {
    return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    children: [
    _buildButton('All', yellow, Colors.white, context, 1),
    const SizedBox(width: 10),
    _buildButton('Solar panels', off_white, Colors.black, context, 2),
    const SizedBox(width: 10),
    _buildButton('Inverters', off_white, Colors.black, context, 3),
    const SizedBox(width: 10),
    _buildButton('Batteries', off_white, Colors.black, context, 4),
    ],
    ),
    );
    },
    ),
    ),
    ),
    ),
    SliverToBoxAdapter(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: 10),
    Text('Solar panels', style: TextStyle(fontWeight: FontWeight.w500)),
    SizedBox(height: 10),
    SizedBox(
    height: 265.0,
    width: double.infinity,
    child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => buildSolar_panelItem(),
    separatorBuilder: (context, index) => const SizedBox(width: 10.0),
    itemCount: 10,
    ),
    ),
    SizedBox(height: 10),

    Text('Inverters', style: TextStyle(fontWeight: FontWeight.w500)),
    SizedBox(height: 10),
    SizedBox(
    height: 265.0,
    width: double.infinity,
    child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => buildInverterItem(),
    separatorBuilder: (context, index) => const SizedBox(width: 10.0),
    itemCount: 10,
    ),
    ),
    SizedBox(height: 10),


      Text('Batteries', style: TextStyle(fontWeight: FontWeight.w500)),
      SizedBox(height: 10),
      SizedBox(
        height: 265.0,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => buildSolar_panelItem(),
          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          itemCount: 10,
        ),
      ),
      SizedBox(height: 20),
    ],
    ),
    ),
    ),

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
    return child;
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
          MaterialPageRoute(
            builder: (context) => Home_Layout(startIndex: tabIndex),
          ),
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


Widget buildSolar_panelItem() => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: yellow),
  ),
  child: Padding(
    padding:  EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right: 10.0,
        bottom: 5.0
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:  [
            CircleAvatar(radius: 10.0, backgroundColor: Colors.cyan),
            SizedBox(width: 5.0),
            Text('Felicity', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
            SizedBox(width: 100.0,),
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.info_outline,
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
            height: 85.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/my_image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Text('Solar panel', style: TextStyle(fontWeight: FontWeight.w600)),
        Text('250\$', style: TextStyle(color: yellow, fontSize: 14.0)),
        Text('Maximum power: 585 W'),
        Text('Open circuit voltage: 50.2 V'),
        Text('Short circuit current: 10.61 A'),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
);


Widget buildInverterItem() => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: yellow),
  ),
  child: Padding(
    padding:   EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right: 10.0,
        bottom: 5.0
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:   [
            CircleAvatar(radius: 10.0, backgroundColor: Colors.cyan),
            SizedBox(width: 5.0),
            Text('Felicity', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
            SizedBox(width: 100.0,),
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.info_outline,
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
            height: 55.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/my_image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          'Solr inverters',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '850\$',
          style: TextStyle(
            color: yellow,
            fontSize: 14.0,
          ),
        ),
        Text(
          'Rated power: 11000 Watt',
          maxLines: 1,
        ),
        Text(
          'Max:150A , Default:30A',
          maxLines: 1,
        ),
        Text(
          'Rated power:5500W*2',
          maxLines: 1,
        ),
        Text(
          'Max solar voltage:500V',
          maxLines: 1,
        ),
        Text(
          'MPPT voltage range:90-450V',
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
);


Widget buildBatteriesItem() => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: yellow),
  ),
  child: Padding(
    padding: const EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right: 10.0,
        bottom: 5.0
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:  [
            CircleAvatar(radius: 10.0, backgroundColor: Colors.cyan),
            SizedBox(width: 5.0),
            Text('Felicity', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
            SizedBox(width: 100.0,),
            IconButton(
              onPressed: (){},
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
            height: 85.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/my_image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0),
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
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
);
