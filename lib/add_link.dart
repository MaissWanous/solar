import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Add_Link extends StatefulWidget {
  @override
  _Add_LinkState createState() => _Add_LinkState();
}

const Color yellow = Color(0xFFFFBF00);
const Color moregrey = Color(0xFFB3B3B3);

class _Add_LinkState extends State<Add_Link> {
  final Map<String, IconData> socialIcons = {
    'Facebook': FontAwesomeIcons.facebook,
    'LinkedIn': FontAwesomeIcons.linkedin,
    'Instagram': FontAwesomeIcons.instagram,
    'Twitter': FontAwesomeIcons.twitter,
    'YouTube': FontAwesomeIcons.youtube,
  };

  String? selectedValue;

  List<String> options = ['Facebook', 'LinkedIn', 'Instagram', 'Twitter', 'YouTube'];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 35.0),
          constraints: BoxConstraints(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DropdownButtonFormField2<String>(
                decoration: InputDecoration(
                  hintText: 'Choose the website name',
                  hintStyle: TextStyle(color: moregrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: yellow),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: yellow),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: yellow, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                isExpanded: false,
                dropdownMaxHeight: 200,
                dropdownWidth: 170,
                dropdownPadding: EdgeInsets.symmetric(horizontal: 12),
                dropdownDecoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: yellow),
                ),
                value: selectedValue,
                items: options
                    .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Row(
                    children: [
                      Icon(socialIcons[option], color: Colors.black54),
                      SizedBox(width: 10),
                      Text(option),
                    ],
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down, color: yellow, size: 30),
                iconOnClick: Icon(Icons.keyboard_arrow_up, color: yellow, size: 30),
                dropdownOverButton: true,
                validator: (value) => value == null ? 'الرجاء اختيار خيار' : null,
              )

            ],
          ),
        ),
      ),
    );
  }
}
