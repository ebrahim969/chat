// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
   MyTextField({super.key , required this.hintText, required this.icon, required this.validator, required this.controller, this.obscureText = false});
   
   String hintText;
   IconData icon;
   Function validator;
   TextEditingController controller;
   bool obscureText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: Get.width,
      child: TextFormField(
        obscureText: obscureText ,
                    style: GoogleFonts.poppins(color:kPrimaryColor),
                    controller: controller,
                    validator:(value){
                    return  validator(value);
                    },
    
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: GoogleFonts.poppins(color:kPrimaryColor, fontSize: 15),
                      enabledBorder:const  UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder:const  UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 3.0)),
                      contentPadding:const  EdgeInsets.symmetric(horizontal: 10),
                      suffixIcon:   Icon(
                              icon,
                              size: 20,
                              color: kPrimaryColor,
                            )
                    )),
    );
                       
  }
}