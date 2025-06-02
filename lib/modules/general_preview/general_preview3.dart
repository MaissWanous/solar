import 'package:flutter/material.dart';
import 'package:udemy_flutter/Modules/Login/Login.dart';

import 'general_preview.dart';

class General_preview3 extends StatelessWidget {

  final Color yellow = Color(0xFFFFBF00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
          top: 10.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Batteries',
                      style: TextStyle(
                        color: yellow,
                        fontSize: 36.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox( height: 20.0, ),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: yellow),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 529.0,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assetss/images/Batteries1.webp',
                                  width: double.infinity,
                                  height: 230.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              Text(
                                'There are four main types of batteries used to store solar energy — lead-acid, lithium-ion flow batteries,  and  nickel cadmium, Let’s deep dive into each of them. ',
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'eardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk.jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIeardsxrfeggufokhujdskowqeiru8y7ghjskaGDCSHLKQfhcn buihgaefOW;DSJXMKCJDVNDAIGFERHFANCSKVBHJEYRFWDJCLVJJDAKGJRDFKJAEWFJEwo;ghfncdk .jdifjal;sQ[PWO9048U5YT4HJWRIRHFALIUHW4IRPAIEHFIEAHDRNFVCDKXJNDKLJSHBFEIYA4EHFSDM,CX NKJNFIVSAEAHRFJKAWKDLHDHBVGIVGIEAYGHFCMNDKRHFSDCJKNDJVNRGBVveiHWD;AoisjXCNVGRWFAEDVGREDQWCFVZDwq',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assetss/images/Yellow circul.png',
                  width: 12.0,
                  height: 12.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Image.asset(
                  'assetss/images/White circul.png',
                  width: 12.0,
                  height: 12.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Image.asset(
                  'assetss/images/White circul.png',
                  width: 12.0,
                  height: 12.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Image.asset(
                  'assetss/images/White circul.png',
                  width: 12.0,
                  height: 12.0,
                ),
              ],
            ),
            SizedBox (
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //alignment: Alignment.center,
                  height: 56.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF6F6B62),

                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>Login(),
                          ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 56.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFFFFBF00),
                  ),
                  child: MaterialButton(
                    //   color: Color(0xFFFFBF00),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>Login(),
                        ),
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
