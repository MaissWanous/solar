import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/add_product/add_solarpanel.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Profile_Shopkeeper_SolarPanel extends StatefulWidget {
  @override
  State<Profile_Shopkeeper_SolarPanel> createState() =>
      _Profile_Shopkeeper_SolarPanelState();
}

const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);
const Color off_white = Color(0xFFFDF7E8);

var product_nameController = TextEditingController();
var locationController = TextEditingController();
final List<String> options = ['Solar Panels', 'Batteries', 'Inverters'];

class _Profile_Shopkeeper_SolarPanelState
    extends State<Profile_Shopkeeper_SolarPanel> {
  bool isBottomSheetShown = false;
  String selectedProduct = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: true,
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildProfileInfo(screenWidth)),
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
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      buildSolar_panelItem(context, screenWidth),
                      SizedBox(height: screenHeight * 0.015),
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

  Widget _buildProfileInfo(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.1,
                backgroundImage:
                    AssetImage('assetss/images/Peerson in working.png'),
              ),
              SizedBox(width: screenWidth * 0.05),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Felicity',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Besem Smith', style: TextStyle(color: Colors.black)),
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
                      height: screenWidth * 0.15,
                      width: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: off_white,
                      ),
                      child: Icon(Icons.phone,
                          color: Colors.black, size: screenWidth * 0.08),
                    ),
                    SizedBox(width: 12.0),
                    Flexible(child: Text('+987456321')),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: screenWidth * 0.15,
                      width: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: off_white,
                      ),
                      child: Icon(Icons.location_pin,
                          color: Colors.black, size: screenWidth * 0.08),
                    ),
                    SizedBox(width: 12.0),
                    Flexible(child: Text('Syria, Homs')),
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
            _buildButton('Solar panels', yellow, Colors.white, context, 1),
            SizedBox(width: 10),
            _buildButton('Inverters', off_white, Colors.black, context, 2),
            SizedBox(width: 10),
            _buildButton('Batteries', off_white, Colors.black, context, 3),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

Widget _buildButton(
    String text, Color bg, Color txtColor, BuildContext context, int tabIndex) {
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
              builder: (context) =>
                  Home_Layout_Shopkeeper(startIndex: tabIndex)),
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

Widget buildSolar_panelItem(BuildContext context, double screenWidth) {
  double itemWidth =
      (screenWidth - 60) / 2;

  return Row(
    children: [
      Expanded(
        child: Container(
          width: itemWidth,
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
                    CircleAvatar(
                      radius: 10.0,
                      backgroundImage:
                          AssetImage('assetss/images/Peerson in working.png'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Add_Solar_Panel()));
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
                    height: itemWidth * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assetss/images/Solar panel.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Solar panel',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('250\$', style: TextStyle(color: yellow, fontSize: 14.0)),
                Text('Maximum power: 585 W', maxLines: 1),
                Text('Open circuit voltage: 50.21 V'),
                Text('Short circuit current: 10.61 A'),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
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
          width: itemWidth,
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
                    CircleAvatar(
                      radius: 10.0,
                      backgroundImage:
                          AssetImage('assetss/images/Peerson in working.png'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Add_Solar_Panel()));
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
                    height: itemWidth * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assetss/images/Solar panel.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Solar panel',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('250\$', style: TextStyle(color: yellow, fontSize: 14.0)),
                Text('Maximum power: 585 W', maxLines: 1),
                Text('Open circuit voltage: 50.21 V'),
                Text('Short circuit current: 10.61 A'),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
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
}

class _CustomBottomSheet extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelect;

  const _CustomBottomSheet({required this.options, required this.onSelect});

  @override
  State<_CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String selected = '';
  bool isDropdownOpen = false;
  bool isProductTypeValid = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          constraints: BoxConstraints(minHeight: 250),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                defaultFormField(
                  controller: product_nameController,
                  type: TextInputType.text,
                  hint: 'Product name',
                  prefix: null,
                  isPassword: false,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDropdownOpen = !isDropdownOpen;
                      isProductTypeValid = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60.0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isProductTypeValid ? yellow : Colors.red,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selected.isEmpty
                                    ? 'Choose the product type'
                                    : selected,
                                style: TextStyle(
                                  color: selected.isEmpty
                                      ? moregrey
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Icon(
                              isDropdownOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                      if (!isProductTypeValid)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 8),
                          child: Text(
                            'Please select a product type',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                if (isDropdownOpen)
                  Container(
                    margin: EdgeInsets.only(top: 8, left: screenWidth * 0.6),
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: yellow, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: widget.options.map((option) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = option;
                              isProductTypeValid = true;
                              isDropdownOpen = false;
                            });
                            widget.onSelect(option);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 40.0),
                defultButton(
                  width: screenWidth * 0.5,
                  text: 'Show result',
                  function: () {
                    if (_formKey.currentState!.validate() &&
                        selected.isNotEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All inputs are valid!')),
                      );
                    } else {
                      setState(() {
                        isProductTypeValid = selected.isNotEmpty;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
