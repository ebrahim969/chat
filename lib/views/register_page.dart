// ignore_for_file: use_key_in_widget_constructors

import 'package:chat_app/constants.dart';
import 'package:chat_app/views/widgets/my_buttom.dart';
import 'package:chat_app/views/widgets/my_text_field.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/cubits/auth_cubit/auth_cubit.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Get.back();
          emailController.clear();
          passController.clear();
          passConfirmController.clear();
          isLoading = false;
        } else if (state is RegisterFailure) {
          Get.snackbar("Opss!", state.errorMessage);
          emailController.clear();
          passController.clear();
          passConfirmController.clear();
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          height: Get.height * 0.06,
                        ),
                        //text field password
                        MyTextField(
                          obscureText: true,
                          hintText: "Confirm password",
                          icon: Icons.key_rounded,
                          validator: (String? value) {
                            if (passConfirmController.text !=
                                passController.text) {
                              return "Not match password";
                            }
                            if (value!.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                          controller: passConfirmController,
                        ),
                        SizedBox(
                          height: Get.height * 0.07,
                        ),
                        //buttom
                        MyButtom(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerUser(
                                      email: emailController.text,
                                      password: passController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        // text dont have account? register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textWidget(txt: "Are you already member? "),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: textWidget(
                                    txt: "Login", color: kButtonColor))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
