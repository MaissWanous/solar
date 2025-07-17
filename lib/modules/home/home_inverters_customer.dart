import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/modules/home/home_all_customer.dart';
import 'package:udemy_flutter/modules/home/home_batteries_customer.dart';
import 'package:udemy_flutter/modules/home/home_inverters_customer.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper_for_customer/Profile_Shopkeeper_All_For_Customer.dart';

class Home_Inverters_Customer extends StatefulWidget {

  @override
  State<Home_Inverters_Customer> createState() => _Home_Inverters_CustomerState();
}

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);

class _Home_Inverters_CustomerState extends State<Home_Inverters_Customer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [

          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _ButtonBarDelegate(
              minHeight: 55,
              maxHeight: 55,
              child: Container(
                height: 55,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 500) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildButton('All', off_white, Colors.black,context,1),
                            const SizedBox(width: 10),
                            _buildButton('Solar panels', off_white, Colors.black,context,2),
                            const SizedBox(width: 10),
                            _buildButton('Inverters', yellow, Colors.white,context,3),
                            const SizedBox(width: 10),
                            _buildButton('Batteries', off_white, Colors.black,context,4),
                          ],
                        ),
                      );
                    }
                    else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('All', off_white, Colors.black,context,1),
                          _buildButton('Solar panels', yellow, Colors.white,context,2),
                          _buildButton('Inverters', off_white, Colors.black,context,3),
                          _buildButton('Batteries', off_white, Colors.black,context,4),
                        ],
                      );
                    }
                  },
                ),
              ),
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

                      buildInvertersItem(
                        context: context,
                        sellerName: 'Felicity',
                        imagePath: 'assetss/images/Peerson in working.png',
                      ),
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
Widget buildInvertersItem({
  required BuildContext context,
  required String sellerName,
  required String imagePath,
}) => Row(
  children: [
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: yellow),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      sellerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.info_outline, size: 20.0),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 10.0, ),
              Center(
                child: Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage('assetss/images/Inverter.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
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
                'Inverter Mode:',
                maxLines: 1,
              ),
              Text(
                'Rated power: 11000 Watt',
                maxLines: 1,
              ),
              Text(
                'AC Charger Mode:',
                maxLines: 1,),
              Text(
                'Max:150A , Default:30A',
                 maxLines: 1,
              ),
              Text(
                'Solar Charger Mode:',
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
    SizedBox(width: 10.0,),
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: yellow),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      sellerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.info_outline, size: 20.0),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 10.0, ),
              Center(
                child: Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage('assetss/images/Inverter.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
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
                'Inverter Mode:',
                maxLines: 1,
              ),
              Text(
                'Rated power: 11000 Watt',
                maxLines: 1,
              ),
              Text(
                'AC Charger Mode:',
                maxLines: 1,),
              Text(
                'Max:150A , Default:30A',
                maxLines: 1,
              ),
              Text(
                'Solar Charger Mode:',
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
