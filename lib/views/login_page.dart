// ignore_for_file: use_key_in_widget_constructors

import 'package:chat_app/constants.dart';
import 'package:chat_app/controllers/blocs/login_bloc.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/views/widgets/my_buttom.dart';
import 'package:chat_app/views/widgets/my_text_field.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/cubits/chat_cubit/chat_cubit.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessege();
          String email = emailController.text;
          Get.to(() => ChatPage(email));
          emailController.clear();
          passController.clear();
          isLoading = false;
        } else if (state is LoginFailure) {
          Get.snackbar("Opps", state.errorMessage);
          isLoading = false;
          emailController.clear();
          passController.clear();
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      // image
                      Image.asset(
                        kImage,
                        height: 150,
                      ),
                      //text
                      textWidget(
                          txt: "Chat App",
                          fontsize: 17,
                          fontWeight: FontWeight.bold,
                          color: kButtonColor),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      //text field user name
                      MyTextField(
                        hintText: "Username",
                        icon: Icons.person_outlined,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter username";
                          }
                          if (!value.contains("@")) {
                            return "Username must contains @";
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      //text field password
                      MyTextField(
                        obscureText: true,
                        hintText: "Password",
                        icon: Icons.key_rounded,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length < 6) {
                            return "Password must contain mor than 6 characters";
                          }
                        },
                        controller: passController,
                      ),
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                      //buttom

                      MyButtom(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonEvent(
                                    emailController.text, passController.text));
                          }
                          null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      // text dont have account? register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(txt: "Are you a new member? "),
                          InkWell(
                              onTap: () {
                                Get.to(() => RegisterPage());
                              },
                              child: textWidget(
                                  txt: "Register", color: kButtonColor))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
