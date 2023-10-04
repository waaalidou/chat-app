import 'package:chat_app_firebase/constants.dart';
import 'package:chat_app_firebase/helpers/snack_bar.dart';
import 'package:chat_app_firebase/pages/chat_page.dart';
import 'package:chat_app_firebase/pages/login_screen.dart';
import 'package:chat_app_firebase/widgets/custom_btn.dart';
import 'package:chat_app_firebase/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  static const String registerPageRouteName = 'Register-Page';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  late String? email;

  late String? password;

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryaColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    kLogoPath,
                    height: 170,
                    width: 170,
                  ),
                ),
                const Center(
                  child: Text(
                    "Schoolar Text",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: "Email",
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  hintText: "Password",
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonName: "Register",
                  onTapHandeler: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await registerNewUser();
                        if (context.mounted) {
                          Navigator.pushNamed(
                            context,
                            ChatPage.chatPageRouteName,
                            arguments: email,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          userRegistrationExceptionHandling(e, context);
                        }
                      } catch (ex) {
                        if (context.mounted) {
                          showSnackBar(context, 'There was an error');
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          LoginPage.loginPageRouteName,
                        );
                      },
                      child: const Text(
                        "LogIn",
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void userRegistrationExceptionHandling(
      FirebaseAuthException e, BuildContext context) {
    if (e.code == 'weak-password') {
      showSnackBar(context, 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      showSnackBar(context, 'The account already exists for that email.');
    }
  }

  Future<void> registerNewUser() async {
    // ignore: unused_local_variable
    var authObj = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
