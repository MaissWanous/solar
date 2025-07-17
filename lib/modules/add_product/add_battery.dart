import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/add_product/add_inverter.dart';
import 'package:udemy_flutter/modules/add_product/add_solarpanel.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import '../settings/settings_ shopkeeper.dart';

class Add_Battery extends StatefulWidget {
  @override
  State<Add_Battery> createState() => _Add_BatteryState();
}

Color yellow = Color(0xFFFFBF00);
Color moregrey = Color(0xFFB3B3B3);
var Battery_sizeController = TextEditingController();
var AnythingCurrentController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _Add_BatteryState extends State<Add_Battery> {
  final List<String> options = ['Lithium', 'Gel', 'Tubular'];
  String selected = '';
  bool isDropdownOpen = false;
  bool isProductTypeValid = true;

  final dropdownKey = GlobalKey();

  Offset dropdownOffset = Offset.zero;
  double dropdownWidth = 80;

  void _toggleDropdown() {
    final renderBox = dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        dropdownOffset = position;
        isDropdownOpen = !isDropdownOpen;
        isProductTypeValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: screenWidth * 0.5,
        leading: Row(
          children: [
            SizedBox(width: screenWidth * 0.01),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: screenWidth * 0.08),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              'Add product',
              style: TextStyle(
                color: yellow,
                fontSize: screenWidth * 0.05,
                fontFamily: 'Aclonica',
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Battery Type', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: _toggleDropdown,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                key: dropdownKey,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isProductTypeValid ? yellow : Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selected.isEmpty ? 'Select' : selected,
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
                        SizedBox(height: 20),
                        Text('Battery size', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: Battery_sizeController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Write';
                            }
                            return null;
                          },
                          hint: 'Write',
                        ),
                        SizedBox(height: 20),
                        Text('Any other qualities you want to add', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: AnythingCurrentController,
                          type: TextInputType.text,
                          validate: (value) {
                            return null;
                          },
                          hint: 'Write',
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: defultButton(
                            width: 100.0,
                            text: 'Next',
                            function: () {
                              if (_formKey.currentState!.validate() && selected.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home_Layout_Shopkeeper(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isProductTypeValid = selected.isNotEmpty;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isDropdownOpen)
                Positioned(
                  top: dropdownOffset.dy,
                  left: dropdownOffset.dx + screenWidth - dropdownWidth - 20,
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: dropdownWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: yellow, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: options.map((option) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected = option;
                                isProductTypeValid = true;
                                isDropdownOpen = false;
                              });
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
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}