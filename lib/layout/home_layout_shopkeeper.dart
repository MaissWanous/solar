import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/add_product/add_product.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_all.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_batteries.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_inverter.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_solarPanel.dart';
import 'package:udemy_flutter/modules/settings/setting_menu_shopkeeper.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/style/colors.dart';

class Home_Layout_Shopkeeper extends StatefulWidget {
  final int startIndex;
  const Home_Layout_Shopkeeper({this.startIndex = 1});

  @override
  State<Home_Layout_Shopkeeper> createState() => _Home_Layout_ShopkeeperState();
}

const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);

var product_nameController = TextEditingController();

class _Home_Layout_ShopkeeperState extends State<Home_Layout_Shopkeeper> {
  late int currentIndex;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  final List<String> options = ['Solar Panel', 'Batter', 'Inverter'];
  String selectedProduct = '';

  List<Widget> screens = [
    Profile_Shopkeeper_All(),
    Profile_Shopkeeper_SolarPanel(),
    Profile_Shopkeeper_Inverters(),
    Profile_Shopkeeper_Batteries(),
    Add_Product(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
  }

  PreferredSizeWidget getAppBar() {
    bool isProfile = currentIndex == 0 || currentIndex == 1 || currentIndex == 2 || currentIndex == 3;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leadingWidth: 200,
      leading: isProfile
          ? Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0),
        child: Text(
          'Felicity',
          style: TextStyle(color: yellow, fontFamily: 'Aclonica', fontSize: 20.0),
        ),
      )
          : Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 35.0),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Add product',
            style: TextStyle(color: yellow, fontSize: 20.0, fontFamily: 'Aclonica'),
          ),
        ],
      ),
      actions: isProfile
          ? [
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {
            if (isBottomSheetShown) {
              Navigator.pop(context);
              setState(() => isBottomSheetShown = false);
            }
            else {
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
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.notification_important, color: Colors.black),
        )
      ]
          : [],
    );
  }

  bool isProfileIndex(int index) => index >= 0 && index <= 3;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: Drawer(backgroundColor: Colors.white, child: Settings_Menu_Shopkeeper()),
      appBar: getAppBar(),
      body: screens[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.yellow,
        elevation: 8,
        child: SizedBox(
          height: screenHeight * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.person, size: screenHeight * 0.035),
                color: isProfileIndex(currentIndex) ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.add, size: screenHeight * 0.035),
                color: currentIndex == 4 ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
                  onTap: () => setState(() => isDropdownOpen = !isDropdownOpen),
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
                            Icon(isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
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
                    margin: EdgeInsets.only(top: 8, left: screenWidth * 0.5),
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
                  width: screenWidth * 0.45,
                  text: 'Show result',
                  function: () {
                    if (_formKey.currentState!.validate() && selected.isNotEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All inputs are valid!')),
                      );
                    } else {
                      setState(() => isProductTypeValid = selected.isNotEmpty);
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