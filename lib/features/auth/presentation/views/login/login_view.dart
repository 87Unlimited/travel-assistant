import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/constants/spacing_styles.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/login_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/widgets/login_form.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/widgets/login_header.dart';
import 'package:travel_assistant/navigation_menu.dart';

import '../../../../../common/widgets/social_button.dart';
import '../../../../../common/widgets/text/signup_signin_text_switch.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool circular = false;

  late final LocalAuthentication auth;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = HelperFunctions.isDarkMode(context);
    bool obscure = true;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: SpacingStyle.loginPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const LoginHeader(title: "Sign In To Continue",),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // Login form
                LoginForm(),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // Register Button
                SignupSignInTextSwitch(registered: false,),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // Sign in with google of facebook
                SocialButton(dark: dark),
              ],
            )),
      ),
    );
  }

  Widget colorButton(labelText) {
    return InkWell(
        onTap: () async {
          setState(() {
            circular = true;
          });
          final email = _email.text;
          final password = _password.text;

          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            );

            setState(() {
              circular = false;
            });
            if (!context.mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home/',
              (route) => false,
            );
          } on FirebaseAuthException catch (e) {
            late SnackBar snackBar;
            late final String errorCode;
            print(e.code);
            switch (e.code) {
              case 'user-not-found':
                errorCode = 'User not found';
                break;
              case 'wrong-password':
                errorCode = 'Wrong password';
                break;
              default:
                errorCode = 'Unknown error';
            }
            if (!context.mounted) return;
            snackBar = SnackBar(content: Text(errorCode));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            setState(() {
              circular = false;
            });
          }
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 90,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Center(
              child: circular
                  ? const CircularProgressIndicator()
                  : Text(
                      labelText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
            )));
  }
}