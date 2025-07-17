import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_all.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Add_Solar_Panel extends StatefulWidget {
  @override
  State<Add_Solar_Panel> createState() => _Add_Solar_PanelState();
}

Color yellow = Color(0xFFFFBF00);
Color moregrey = Color(0xFFB3B3B3);
Color more2grey = Color(0xFF707070);

var openCircuitVoltageController = TextEditingController();
var shortCircuitCurrentController = TextEditingController();
var AnythingCurrentController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _Add_Solar_PanelState extends State<Add_Solar_Panel> {
  File? _selectedImage;
  final List<int> options = [585, 600, 615, 700, 710];
  int selected = 0;
  bool isDropdownOpen = false;
  bool isProductTypeValid = true;

  final dropdownKey = GlobalKey();
  Offset dropdownOffset = Offset.zero;
  double dropdownWidth = 60;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: screenWidth * 0.6,
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please specify the characteristics of the solar panel',
                      style: TextStyle(color: more2grey, fontSize: screenWidth * 0.035),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Text(
                      'Maximum power of solar panels',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: _toggleDropdown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            key: dropdownKey,
                            height: screenHeight * 0.06,
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
                                    selected == 0 ? 'Select' : selected.toString(),
                                    style: TextStyle(
                                      color: selected == 0 ? moregrey : Colors.black,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                ),
                                Icon(
                                  isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  size: screenWidth * 0.06,
                                ),
                              ],
                            ),
                          ),
                          if (!isProductTypeValid)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 8),
                              child: Text(
                                'Please select a Maximum power',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text('Open Circuit Voltage', style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04)),
                    SizedBox(height: screenHeight * 0.01),
                    defaultFormField(
                      controller: openCircuitVoltageController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text('Short Circuit Current', style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04)),
                    SizedBox(height: screenHeight * 0.01),
                    defaultFormField(
                      controller: shortCircuitCurrentController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text('Any other qualities you want to add', style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.04)),
                    SizedBox(height: screenHeight * 0.01),
                    defaultFormField(
                      controller: AnythingCurrentController,
                      type: TextInputType.text,
                      validate: (value) => null,
                      hint: 'Write',
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: defultButton(
                        width: screenWidth * 0.4,
                        text: 'Next',
                        function: () {
                          if (_formKey.currentState!.validate() && selected != 0) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home_Layout_Shopkeeper(),
                              ),
                            );
                          } else {
                            setState(() {
                              isProductTypeValid = selected != 0;
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
                              option.toString(),
                              style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}