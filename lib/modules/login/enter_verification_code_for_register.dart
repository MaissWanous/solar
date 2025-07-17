import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/forgot_password/enter_new_password.dart';
import 'package:udemy_flutter/modules/login/register_customer.dart';
import 'package:udemy_flutter/modules/login/register_for_shopkeeper_1.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Enter_Verification_Code_For_Register extends StatefulWidget {
  final String selectedAccount;

  const Enter_Verification_Code_For_Register({Key? key, required this.selectedAccount}) : super(key: key);

  @override
  State<Enter_Verification_Code_For_Register> createState() => _Enter_Verification_Code_For_RegisterState();
}

class _Enter_Verification_Code_For_RegisterState extends State<Enter_Verification_Code_For_Register> {
  final Color yellow = const Color(0xFFFFBF00);
  final Color more2grey = const Color(0xFFA39F9F);

  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index + 1 < _focusNodes.length) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.length == 1 && index == _focusNodes.length - 1) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left, size: 35, color: Colors.black),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight - 80),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Enter Verification Code',
                                style: TextStyle(
                                  fontFamily: 'Aclonica',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 25.0),
                              SizedBox(
                                width: width * 0.8,
                                child: Text(
                                  'We have sent the code verification to your registered email address.',
                                  style: TextStyle(fontSize: 14.0, color: more2grey),
                                ),
                              ),
                              const SizedBox(height: 35.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(5, (index) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(color: yellow),
                                        ),
                                        child: TextField(
                                          controller: _controllers[index],
                                          focusNode: _focusNodes[index],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          style: const TextStyle(fontSize: 24, height: 1),
                                          cursorColor: yellow,
                                          decoration: const InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                                          ),
                                          onChanged: (value) => _onChanged(value, index),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  defultButton(
                    text: 'Continue',
                    function: () {
                      bool allFilled = _controllers.every((controller) => controller.text.trim().isNotEmpty);
                      if (!allFilled) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter all 5 digits of the verification code.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        if (widget.selectedAccount == 'Customer') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register_customer()),
                          );
                        }
                        else if (widget.selectedAccount == 'Shopkeeper') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register_for_shopkeeper1()),
                          );
                        }
                      }
                    },
                    backgroundColor: yellow,
                    borderColor: yellow,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
