// ignore_for_file: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'controllers/cubits/auth_cubit/auth_cubit.dart';
import 'controllers/cubits/chat_cubit/chat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> AuthCubit()),
        BlocProvider(create: (context)=> ChatCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          animationDuration: const Duration(seconds: 3),
          duration: 3000,
          splash: Column(
            children: [
              Image.asset(kImage),
              const SizedBox(
                height: 12,
              ),
              textWidget(
                  txt: "Chat App", fontsize: 20, fontWeight: FontWeight.bold)
            ],
          ),
          nextScreen: LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: kBackgroundColor,
          splashIconSize: 250,
        ),
      ),
    );
  }
}
