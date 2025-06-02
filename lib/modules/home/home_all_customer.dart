
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/home/home_batteries_customer.dart';
import 'package:udemy_flutter/modules/home/home_inverters_customer.dart';
import 'package:udemy_flutter/modules/home/home_solar_panels_customer.dart';


///To Doooo
///Location for post
///Button See more
///Image in post
///Search
///Move to profile
///Information
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              floating: true,
              snap: true,
              title:  Text(
                'Home',
                style: TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.w800,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon:  Icon(
                      Icons.search,
                      color: Colors.black
                  ),
                ),
              ],
            ),
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
                              _buildButton('All', yellow, Colors.white,context,Home_All_Customer()),
                              const SizedBox(width: 10),
                              _buildButton('Solar panels', off_white, Colors.black,context,Home_Solar_Panels_Customer()),
                              const SizedBox(width: 10),
                              _buildButton('Inverters', off_white, Colors.black,context,Home_Inverters_Customer()),
                              const SizedBox(width: 10),
                              _buildButton('Batteries', off_white, Colors.black,context,Home_Batteries_Customer()),
                            ],
                          ),
                        );
                      }
                      else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('All', yellow, Colors.white,context,Home_Inverters_Customer()),
                            _buildButton('Solar panels', off_white, Colors.black,context,Home_Solar_Panels_Customer()),
                            _buildButton('Inverters', off_white, Colors.black,context,Home_Inverters_Customer()),
                            _buildButton('Batteries', off_white, Colors.black,context,Home_Batteries_Customer()),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                     SizedBox(height: 10),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                        'Solar panels',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                         SizedBox(height: 10),
                         SizedBox(
                        height: 265.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildSolar_panelItem(),
                          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                          itemCount: 10,
                        ),
                      ),

                         SizedBox(height: 10),

                         Text(
                           'Solar panels',
                           style: TextStyle(fontWeight: FontWeight.w500),
                         ),
                         SizedBox(height: 10),
                         SizedBox(
                           height: 265.0,
                           child: ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) => buildSolar_panelItem(),
                             separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                             itemCount: 10,
                           ),
                         ),

                         SizedBox(height: 10),

                         Text(
                           'Solar panels',
                           style: TextStyle(fontWeight: FontWeight.w500),
                         ),
                         SizedBox(height: 10),
                         SizedBox(
                           height: 265.0,
                           child: ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) => buildSolar_panelItem(),
                             separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                             itemCount: 10,
                           ),
                         ),

                         SizedBox(height: 10),

                         Text(
                           'Solar panels',
                           style: TextStyle(fontWeight: FontWeight.w500),
                         ),
                         SizedBox(height: 10),
                         SizedBox(
                           height: 265.0,
                           child: ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) => buildSolar_panelItem(),
                             separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                             itemCount: 10,
                           ),
                         ),
                    ],
                  ),
                ]),
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

Widget _buildButton(String text, Color bg, Color txtColor, BuildContext context, Widget page) {
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>page),
              (Route<dynamic> route) => false,
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
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.cyan,
            ),
            SizedBox(width: 5.0,),
            Text(
              'Felicity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0, ),
        Center(
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.cyan,
            ),
          ),
        ),
        const SizedBox(height: 30.0,),
        const Text(
          'Solar panel',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          '250\$',
          style: TextStyle(
            color: yellow,
            fontSize: 14.0,
          ),
        ),
        const Text(
          'Maximum power: 585 W',
        ),
        const Text(
          'Open circuit voltage: 50.2 V',
        ),
        const Text(
          'Short circuit current: 10.61 A',
        ),
      ],
    ),
  ),
);
