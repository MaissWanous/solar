import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/home/home_all_customer.dart';
import 'package:udemy_flutter/modules/home/home_batteries_customer.dart';
import 'package:udemy_flutter/modules/home/home_inverters_customer.dart';
import 'package:udemy_flutter/modules/home/home_solar_panels_customer.dart';
import 'package:udemy_flutter/modules/home/result_search.dart';
import 'package:udemy_flutter/modules/settings/settings_menu.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/technical/list_technical.dart';
import 'package:udemy_flutter/modules/technical/result_search_technical.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/style/colors.dart';
import 'package:udemy_flutter/token.dart';

class Home_Layout extends StatefulWidget {
  final int startIndex;

  const Home_Layout({this.startIndex = 1});
  @override
  State<Home_Layout> createState() => _Home_LayoutState();
}

const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);

var shop_nameController = TextEditingController();
var locationController = TextEditingController();

class _Home_LayoutState extends State<Home_Layout> {
  late int currentIndex;
  String customerName = 'Loading...';

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
    fetchCustomerName();
  }

  Future<void> fetchCustomerName() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.109:4000/profile'),
        headers: {
          'Authorization': 'Bearer ${Token.apiToken}',
           'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final fname = data['fname'] ?? '';
        final lname = data['lname'] != null ? ' ${data['lname']}' : '';
        setState(() {
          customerName = '$fname';
        });
      } else {
        setState(() {
          customerName = 'Unknown User';
        });
      }
    } catch (e) {
      setState(() {
        customerName = 'Error fetching name';
      });
    }
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;

  final List<String> options = ['Solar_Panel', 'Battery', 'Inverter'];
  String selectedProduct = '';

  List<Widget> screens = [
    Profile_Customer(), // index 0
    Home_All_Customer(), // index 1 (Home default)
    Home_Solar_Panels_Customer(),
    Home_Inverters_Customer(),
    Home_Batteries_Customer(),
    List_Technical(), // index 5
  ];

  PreferredSizeWidget getAppBar() {
    if (currentIndex == 0) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Text(
            customerName,
            style: const TextStyle(
              color: yellow,
              fontFamily: 'Aclonica',
              fontSize: 20.0,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 35.0, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings_Menu()),
              );
            },
          ),
        ],
      );
    } else if (currentIndex == 5) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: const Text(
            'Technical',
            style: TextStyle(
              color: yellow,
              fontFamily: 'Aclonica',
              fontSize: 20.0,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return TechnicianSearchBottomSheet();
                },
              );
            },
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0),
          child: Text(
            'Home',
            style: TextStyle(
              color: yellow,
              fontFamily: 'Aclonica',
              fontWeight: FontWeight.w800,
              fontSize: 22.0,
            ),
            maxLines: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
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
                  shape: const RoundedRectangleBorder(
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
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.person, size: 30),
                color: currentIndex == 0 ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 0),
              ),
              IconButton(
                icon: const Icon(Icons.home, size: 30),
                color: isHomeIndex(currentIndex) ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 1),
              ),
              IconButton(
                icon: const Icon(Icons.group, size: 30),
                color: isHomeIndex(currentIndex) ? Colors.white : Colors.black,
                onPressed: () => setState(() => currentIndex = 5),
              ),
              IconButton(
                icon: const Icon(Icons.chat, size: 30),
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
                        'Please enter Shop name or Product name',
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
                child: Container(
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
                      Icon(isDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
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
               SizedBox(height: 20.0),
              defaultFormField(
                controller: product_nameController,
                type: TextInputType.text,
                validate: (_) => null,
                hint: 'Product name',
              ),
              if (areTextFieldsEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    'Please enter Shop name or Product name',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
               SizedBox(height: 40.0),
              defultButton(
                width: 185.0,
                text: 'Show result',
                function: () {
                  bool isAnyTextFilled = shop_nameController.text.trim().isNotEmpty ||
                      product_nameController.text.trim().isNotEmpty;

                  setState(() {
                    areTextFieldsEmpty = !isAnyTextFilled;
                    isProductTypeValid = selected.isNotEmpty;
                  });

                  if (isAnyTextFilled && isProductTypeValid) {
                    Navigator.pop(context); // إغلاق الـBottomSheet أولًا
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result_Search(
                            category: selected.toLowerCase().replaceAll(' ', '_'),
                            shopNameQuery: shop_nameController.text.trim(),
                            productNameQuery: product_nameController.text.trim(),
                          ),
                        ),
                      );
                    });
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

class TechnicianSearchBottomSheet extends StatefulWidget {
  @override
  State<TechnicianSearchBottomSheet> createState() => _TechnicianSearchBottomSheetState();
}

class _TechnicianSearchBottomSheetState extends State<TechnicianSearchBottomSheet> {
  final TextEditingController technicianNameController = TextEditingController();
  bool isEmptyField = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(minHeight: 180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              defaultFormField(
                controller: technicianNameController,
                type: TextInputType.text,
                validate: (_) => null,
                hint: "Technician's name",
              ),
              if (isEmptyField)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    'Technician\'s name is required',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 40),
              defultButton(
                width: 185.0,
                text: 'Show result',
                function: () {
                  setState(() {
                    isEmptyField = technicianNameController.text.trim().isEmpty;
                  });

                  if (!isEmptyField) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultSearchTechnical(
                          searchQuery: technicianNameController.text.trim(),
                        ),
                      ),
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
