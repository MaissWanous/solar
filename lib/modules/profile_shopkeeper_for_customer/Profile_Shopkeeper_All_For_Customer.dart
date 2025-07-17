import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Profile_Shopkeeper_SolarPanel_For_Customer extends StatefulWidget  {
  final String sellerName;

  const Profile_Shopkeeper_SolarPanel_For_Customer({Key? key, required this.sellerName}) : super(key: key);

  @override
  State<Profile_Shopkeeper_SolarPanel_For_Customer> createState() => _Profile_Shopkeeper_SolarPanel_For_CustomerState();
}
const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);
const Color off_white = Color(0xFFFDF7E8);

var product_nameController = TextEditingController();
var locationController = TextEditingController();
final List<String> options = ['Solar Panels', 'Batteries', 'Inverters'];

class _Profile_Shopkeeper_SolarPanel_For_CustomerState extends State<Profile_Shopkeeper_SolarPanel_For_Customer > {
  bool isBottomSheetShown = false;
  String selectedProduct = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 35.0, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              if (isBottomSheetShown) {
                Navigator.pop(context);
                setState(() => isBottomSheetShown = false);
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return _CustomBottomSheet(
                      options: options,
                      onSelect: (val) => selectedProduct = val,
                    );
                  },
                );
                setState(() => isBottomSheetShown = true);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
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

                        buildSolar_panelItem(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ibrahem Smith',
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text('Besem Smith', style: TextStyle(color: Colors.black)),
                ],
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
                    Text('+987456321'),
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
                    Text('Syria, Homs'),
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
            _buildButton('All', yellow, Colors.white, context, 1),
            SizedBox(width: 10),
            _buildButton('Solar panels', off_white, Colors.black, context, 2),
            SizedBox(width: 10),
            _buildButton('Inverters', off_white, Colors.black, context, 3),
            SizedBox(width: 10),
            _buildButton('Batteries', off_white, Colors.black, context, 4),
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
          MaterialPageRoute(builder: (context) => Home_Layout(startIndex: tabIndex)),
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

Widget buildSolar_panelItem({
  required BuildContext context,
  required String sellerName,
  required String imagePath,
}) =>
    Row(
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
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assetss/images/Solar panel.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Solar panel',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('250\$',
                      style: TextStyle(color: yellow, fontSize: 14.0)),
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
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assetss/images/Solar panel.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Solar panel',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('250\$',
                      style: TextStyle(color: yellow, fontSize: 14.0)),
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
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
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                                selected.isEmpty ? 'Choose the product type' : selected,
                                style: TextStyle(
                                  color: selected.isEmpty ? moregrey : Colors.black,
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
                    margin: EdgeInsets.only(top: 8, left: 220),
                    width: 115.0,
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
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                option,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 40.0),
                defultButton(
                  width: 185.0,
                  text: 'Show result',
                  function: () {
                    if (_formKey.currentState!.validate() && selected.isNotEmpty) {
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
