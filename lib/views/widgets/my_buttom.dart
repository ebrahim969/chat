// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButtom extends StatelessWidget {
   MyButtom({super.key ,required this.onTap});
  
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          color: kButtonColor,
          boxShadow: [
           BoxShadow(
                    color: kButtonColor.withOpacity(0.1),
                    spreadRadius:5,
                    blurRadius: 2,
                    offset:const Offset(1, 2)
                  )
          ]
        ),
        child: Center(child: textWidget(txt: "Go!", fontsize: 17 , fontWeight: FontWeight.bold)),
      ),
    );
  }
}