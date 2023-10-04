import 'package:chat_app_firebase/pages/chat_page.dart';
import 'package:chat_app_firebase/pages/login_screen.dart';
import 'package:chat_app_firebase/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SchoolarChatApp());
}

class SchoolarChatApp extends StatelessWidget {
  const SchoolarChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        RegisterPage.registerPageRouteName: (context) => const RegisterPage(),
        ChatPage.chatPageRouteName: (context) => const ChatPage(),
        LoginPage.loginPageRouteName: (context) => const LoginPage()
      },
      //initialRoute: LoginPage.loginPageRouteName,
      initialRoute: RegisterPage.registerPageRouteName,
    );
  }
}
