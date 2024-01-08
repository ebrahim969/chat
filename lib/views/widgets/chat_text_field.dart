import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/cubits/chat_cubit/chat_cubit.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.messegeController,
    required this.email,
    required this.listController,
  });

  final TextEditingController messegeController;
  final String email;
  final ScrollController listController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: Get.width * 3 / 4,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kBackgroundColor),
          child: TextField(
            controller: messegeController,
            style: GoogleFonts.poppins(color: kPrimaryColor),
            decoration: InputDecoration(
                hintText: 'Messege',
                hintStyle: GoogleFonts.poppins(color: kButtonColor),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          margin: const EdgeInsets.all(4),
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: kBackgroundColor),
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ChatCubit>(context)
                  .sendMessege(messege: messegeController.text, email: email);
              messegeController.clear();
              listController.animateTo(0,
                  duration: const Duration(microseconds: 500),
                  curve: Curves.decelerate);
            },
            icon: const Icon(
              Icons.send,
              color: kButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
