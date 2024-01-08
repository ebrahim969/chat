// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:chat_app/constants.dart';
import 'package:chat_app/views/widgets/chat_bubble.dart';
import 'package:chat_app/views/widgets/chat_text_field.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/cubits/chat_cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  final listController = ScrollController();
  TextEditingController messegeController = TextEditingController();
  String email;
  ChatPage(this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kImage,
              height: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            textWidget(txt: "Chat", fontsize: 15, fontWeight: FontWeight.bold)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messageList =
                    BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                  reverse: true,
                  controller: listController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? ChatBubble(
                            messege: messageList[index],
                          )
                        : ChatBubble2(
                            messege: messageList[index],
                          );
                  },
                );
              },
            ),
          ),
          ChatTextField(
              messegeController: messegeController,
              email: email,
              listController: listController)
        ],
      ),
    );
  }
}
