import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/modules/add_product/add_anything.dart';
import 'package:udemy_flutter/modules/add_product/add_battery.dart';
import 'package:udemy_flutter/modules/add_product/add_inverter.dart';
import 'package:udemy_flutter/modules/add_product/add_solarpanel.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Add_Product extends StatefulWidget {
  @override
  State<Add_Product> createState() => _Add_ProductState();
}

Color yellow = Color(0xFFFFBF00);
Color moregrey = Color(0xFFB3B3B3);
var ProductnameController = TextEditingController();
var ProductpriceController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _Add_ProductState extends State<Add_Product> {
  File? _selectedImage;
  final List<String> options = ['Solar panel', 'Battery', 'Inverter', 'Another thing'];
  String selected = '';
  bool isDropdownOpen = false;
  bool isProductTypeValid = true;

  final dropdownKey = GlobalKey();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Offset dropdownOffset = Offset.zero;
  double dropdownWidth = 120;

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
    final isSmallScreen = screenWidth < 360;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Picture of the product', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                      image: _selectedImage != null
                          ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? Center(
                      child: Icon(Icons.camera_alt, color: Colors.grey[700], size: 40),
                    )
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                Text('Product type', style: TextStyle(fontWeight: FontWeight.w600)),
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
                              color: isProductTypeValid ? yellow : Colors.red, width: 1.0),
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
                            )
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
                Text('Product name', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                defaultFormField(
                  controller: ProductnameController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Write';
                    }
                    return null;
                  },
                  hint: 'Write',
                ),
                SizedBox(height: 20),
                Text('Product price', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                defaultFormField(
                  controller: ProductpriceController,
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
                    width: 100.0,
                    text: 'Next',
                    function: () {
                      if (_formKey.currentState!.validate() && selected.isNotEmpty) {
                        if (selected == 'Solar panel') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Solar_Panel()));
                        } else if (selected == 'Inverter') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Inverter()));
                        } else if (selected == 'Battery') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Battery()));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Any_Thing()));
                        }
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
        if (isDropdownOpen)
          Positioned(
            top: dropdownOffset.dy,
            left: dropdownOffset.dx + MediaQuery.of(context).size.width - dropdownWidth - 20,
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
  }
}