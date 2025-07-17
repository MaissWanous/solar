import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper/profile_shopkeeper_all.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Add_Inverter extends StatefulWidget {
  @override
  State<Add_Inverter> createState() => _Add_InverterState();
}

Color yellow = Color(0xFFFFBF00);
Color moregrey = Color(0xFFB3B3B3);
Color more2grey = Color(0xFF707070);
var RatedpowerController = TextEditingController();
var MaxController = TextEditingController();
var DefaultController = TextEditingController();
var Rated_PowerController = TextEditingController();
var Max_Solar_VoltageController = TextEditingController();
var oMPPT_Voltage_RangeController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _Add_InverterState extends State<Add_Inverter> {
  File? _selectedImage;
  final List<int> options = [585, 600, 615, 700, 710];
  int selected = 0;
  bool isDropdownOpen = false;
  bool isProductTypeValid = true;

  final dropdownKey = GlobalKey();
  Offset dropdownOffset = Offset.zero;
  double dropdownWidth = 170;

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
        leadingWidth: screenWidth * 0.6,
        leading: Row(
          children: [
            SizedBox(width: 3.0),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 35.0),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            SizedBox(width: 10.0),
            Text(
              'Add product',
              style: TextStyle(
                color: yellow,
                fontSize: 20.0,
                fontFamily: 'Aclonica',
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please specify the characteristics of the Inverter',
                      style: TextStyle(color: more2grey),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Inverter Mode:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Rated Power',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.0),
                    defaultFormField(
                      controller: RatedpowerController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Ac Charger Mode:',
                      style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Max', style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(height: 10),
                              defaultFormField(
                                controller: MaxController,
                                type: TextInputType.number,
                                validate: (value) {
                                  if (value == null || value.isEmpty) return 'Write';
                                  return null;
                                },
                                hint: 'Select',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Default', style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(height: 10),
                              defaultFormField(
                                controller: DefaultController,
                                type: TextInputType.number,
                                validate: (value) {
                                  if (value == null || value.isEmpty) return 'Write';
                                  return null;
                                },
                                hint: 'Select',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Solar Charger Mode:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Rated Power',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.0),
                    defaultFormField(
                      controller: Rated_PowerController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Max Solar Voltage',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.0),
                    defaultFormField(
                      controller: Max_Solar_VoltageController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: 15),
                    Text('MPPT Voltage Range', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    defaultFormField(
                      controller: oMPPT_Voltage_RangeController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write';
                        }
                        return null;
                      },
                      hint: 'Write',
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: defultButton(
                        width: screenWidth * 0.4,
                        text: 'Next',
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home_Layout_Shopkeeper(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}