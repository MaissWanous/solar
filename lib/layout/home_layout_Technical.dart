import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/home/home_all_customer.dart';
import 'package:udemy_flutter/modules/home/home_batteries_customer.dart';
import 'package:udemy_flutter/modules/home/home_inverters_customer.dart';
import 'package:udemy_flutter/modules/home/home_solar_panels_customer.dart';
import 'package:udemy_flutter/modules/settings/settings_menu.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/style/colors.dart';

class Home_Layout_Technical extends StatefulWidget {
  final int startIndex;

  const Home_Layout_Technical({this.startIndex = 1});
  @override
  State<Home_Layout_Technical> createState() => _Home_Layout_TechnicalState();
}

const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);

var shop_nameController = TextEditingController();
var locationController = TextEditingController();

class _Home_Layout_TechnicalState extends State<Home_Layout_Technical> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;

  final List<String> options = ['Solar Panels', 'Batteries', 'Inverters'];
  String selectedProduct = '';

  List<Widget> screens = [
    Profile_Customer(), // index 0
    Home_All_Customer(), // index 1 (Home default)
    Home_Solar_Panels_Customer(),
    Home_Inverters_Customer(),
    Home_Batteries_Customer(),
    Profile_Customer(), // index 5
  ];

  PreferredSizeWidget getAppBar() {
    if (currentIndex == 0 || currentIndex == 5) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 20.0),
          child: Text('Ibrahem Smith',
              style: TextStyle(
                  color: yellow,
                  fontFamily: 'Aclonica',
                  fontSize: 20.0
              )
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, size: 35.0, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings_Menu()),
              );
            },
          ),
        ],
      );
    }
    else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20.0),
          child: Text(
            'Home',
            style: TextStyle(
                color: yellow,
                fontFamily: 'Aclonica',
                fontWeight: FontWeight.w800,
                fontSize: 22.0
            ),
            maxLines: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              if (isBottomSheetShown) {
                Navigator.pop(context);
                setState(() {
                  isBottomSheetShown = false;
                });
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
                setState(() {
                  isBottomSheetShown = true;
                });
              }
            },
          ),
        ],
      );
    }
  }

  bool isHomeIndex(int index) {
    return index == 1 || index == 2 || index == 3 || index == 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: getAppBar(),
      body: screens[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.yellow,
        elevation: 8,
        child: SizedBox(
          height: 48, // ← التحكم الكامل بالارتفاع
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.person, size: 30),
                color: currentIndex == 0 ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.home, size: 30),
                color: isHomeIndex(currentIndex) ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 1),
              ),
              IconButton(
                icon: Icon(Icons.chat, size: 30),
                color: currentIndex == 5 ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 5),
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
  bool areTextFieldsEmpty = false;
  bool isProductTypeValid = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(minHeight: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultFormField(
                    controller: shop_nameController,
                    type: TextInputType.text,
                    validate: (_) => null,
                    hint: 'Shop name',
                  ),
                  if (areTextFieldsEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 8),
                      child: Text(
                        'Both Shop name or Location are required',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
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
                            isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
              SizedBox(height: 20),
              defaultFormField(
                controller: locationController,
                type: TextInputType.text,
                validate: (_) => null,
                hint: 'Location',
              ),
              SizedBox(height: 40.0),
              defultButton(
                width: 185.0,
                text: 'Show result',
                function: () {
                  bool bothEmpty = shop_nameController.text.trim().isEmpty &&
                      locationController.text.trim().isEmpty;

                  setState(() {
                    areTextFieldsEmpty = bothEmpty;
                    isProductTypeValid = selected.isNotEmpty;
                  });

                  if (!bothEmpty && isProductTypeValid) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All inputs are valid!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}