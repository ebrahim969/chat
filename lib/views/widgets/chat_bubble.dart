// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messege_model.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({super.key , required this.messege});
  
   Messege messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:const EdgeInsets.only(top: 20 , right: 36, left: 10),
        padding:const EdgeInsets.only(top: 16 , right: 16 ,left: 8, bottom: 16),
        decoration:const BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)
          )
        ),
        child: textWidget(txt: messege.messege),
      ),
    );
  }
}
class ChatBubble2 extends StatelessWidget {
   ChatBubble2({super.key , required this.messege});
  
   Messege messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.only(top: 20 , right: 36, left: 10),
        padding:const EdgeInsets.only(top: 16 , right: 16 ,left: 8, bottom: 16),
        decoration:const BoxDecoration(
          color: kButtonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30)
          )
        ),
        child: textWidget(txt: messege.messege),
      ),
    );
  }
}