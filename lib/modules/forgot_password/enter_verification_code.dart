
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Enter_Verification_Code extends StatefulWidget {

  @override
  State<Enter_Verification_Code> createState() => _Enter_Verification_CodeState();
}

class _Enter_Verification_CodeState extends State<Enter_Verification_Code> {
  final Color yellow = Color(0xFFFFBF00);

  final Color more2grey = Color(0xFFA39F9F);

  final Color moregrey = Color(0xFFB3B3B3);

  var formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers =
  List.generate(5, (index) => TextEditingController());

   final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {

    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {

       if (index + 1 < _focusNodes.length) {
        FocusScope.of(context as BuildContext).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context as BuildContext).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child:Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Container(
                      width: 258,
                      child: Text(
                        'We have sent the code verification to your registered email address',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: more2grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Row(
                      children: List.generate(5 * 2 - 1, (index) {
                        if (index.isEven) {
                          int boxIndex = index ~/ 2;
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: yellow),
                              ),
                              height: 60,
                              child: TextField(
                                controller: _controllers[boxIndex],
                                focusNode: _focusNodes[boxIndex],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                maxLength: 1,
                                style: TextStyle(fontSize: 24, height: 1),
                                cursorColor: yellow,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12), // اضبط القيمة حسب الحاجة
                                ),
                                onChanged: (value) => _onChanged(value, boxIndex),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(width: 10);
                        }
                      }),
                    ),
                  ],
                ),
              ),
              defultButton(
                text: 'Continue',
                function: () {
                  bool allFilled = _controllers.every((controller) => controller.text.trim().isNotEmpty);

                  if (!allFilled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter all 5 digits of the verification code.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    String code = _controllers.map((c) => c.text).join();

                  }
                },
                backgroundColor: yellow,
                borderColor: yellow,
                textColor: Colors.white,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
