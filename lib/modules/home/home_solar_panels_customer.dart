import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/controllers/product_controller.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper_for_customer/Profile_Shopkeeper_All_For_Customer.dart';

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);

class Home_Solar_Panels_Customer extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final solarPanels = controller.allProducts.where((p) => p.category == "solar_panel").toList();

        if (solarPanels.isEmpty) {
          return const Center(child: Text('No solar panels found'));
        }

        return CustomScrollView(
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
                      if (constraints.maxWidth < 500) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildButton('All', off_white, Colors.black, context, 1),
                              const SizedBox(width: 10),
                              _buildButton('Solar panels', yellow, Colors.white, context, 2),
                              const SizedBox(width: 10),
                              _buildButton('Inverters', off_white, Colors.black, context, 3),
                              const SizedBox(width: 10),
                              _buildButton('Batteries', off_white, Colors.black, context, 4),
                            ],
                          ),
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('All', off_white, Colors.black, context, 1),
                            _buildButton('Solar panels', yellow, Colors.white, context, 2),
                            _buildButton('Inverters', off_white, Colors.black, context, 3),
                            _buildButton('Batteries', off_white, Colors.black, context, 4),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;
                    final items = solarPanels;

                    if (secondIndex >= items.length) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: buildSolarPanelItem(
                                  context: context,
                                  sellerName: (items[firstIndex].shopName.isEmpty) ? 'No name' : items[firstIndex].shopName,
                                  imagePath: 'assets/images/Solar panel.png',
                                  productName: items[firstIndex].name,
                                  price: items[firstIndex].price,
                                  maxPower: items[firstIndex].details['maximumPower']?.toString() ?? '',
                                  openVoltage: items[firstIndex].details['openVoltage']?.toString() ?? '',
                                  shortCircuitCurrent: items[firstIndex].details['shortCurrent']?.toString() ?? '',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Container()),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: buildSolarPanelItem(
                                context: context,
                                sellerName: (items[firstIndex].shopName.isEmpty) ? 'No name' : items[firstIndex].shopName,
                                imagePath: 'assets/images/Solar panel.png',
                                productName: items[firstIndex].name,
                                price: items[firstIndex].price,
                                maxPower: items[firstIndex].details['maximumPower']?.toString() ?? '',
                                openVoltage: items[firstIndex].details['openVoltage']?.toString() ?? '',
                                shortCircuitCurrent: items[firstIndex].details['shortCurrent']?.toString() ?? '',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildSolarPanelItem(
                                context: context,
                                sellerName: (items[secondIndex].shopName.isEmpty) ? 'No name' : items[secondIndex].shopName,
                                imagePath: 'assets/images/Solar panel.png',
                                productName: items[secondIndex].name,
                                price: items[secondIndex].price,
                                maxPower: items[secondIndex].details['maximumPower']?.toString() ?? '',
                                openVoltage: items[secondIndex].details['openVoltage']?.toString() ?? '',
                                shortCircuitCurrent: items[secondIndex].details['shortCurrent']?.toString() ?? '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                  childCount: (solarPanels.length / 2).ceil(),
                ),
              ),
            ),
          ],
        );
      }),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  bool shouldRebuild(covariant _ButtonBarDelegate oldDelegate) =>
      oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight || oldDelegate.child != child;
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
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

Widget buildSolarPanelItem({
  required BuildContext context,
  required String sellerName,
  required String imagePath,
  required String productName,
  required double price,
  required String maxPower,
  required String openVoltage,
  required String shortCircuitCurrent,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: yellow),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        builder: (context) => Profile_Shopkeeper_SolarPanel_For_Customer(
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
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile_Shopkeeper_SolarPanel_For_Customer(
                          sellerName: sellerName,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    sellerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 20.0),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Container(
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '\$$price',
              style: const TextStyle(
                color: yellow,
                fontSize: 14.0,
              ),
            ),
            Text(
              'Maximum power: $maxPower W',
            ),
            Text(
              'Open circuit voltage: $openVoltage V',
            ),
            Text(
              'Short circuit current: $shortCircuitCurrent A',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: const Text(
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
