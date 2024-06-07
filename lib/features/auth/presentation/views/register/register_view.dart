import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import 'package:travel_assistant/features/auth/presentation/views/register/widgets/signup_form.dart';

import '../../../../../common/widgets/social_button.dart';
import '../../../../../common/widgets/text/signup_signin_text_switch.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../login/widgets/login_header.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _rePassword;
  late final TextEditingController _fullName;
  late final TextEditingController _phone;
  // final userRepo = Get.put(UserRepository());
  bool circular = false;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    _rePassword = TextEditingController();
    _fullName = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    _rePassword.dispose();
    _fullName.dispose();
    _phone.dispose();
    super.dispose();
  }

  // Future<void> createUser(UserModel user) async {
  //   await userRepo.createUser(user);
  // }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    bool obscure = true;
    bool reObscure = true;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginHeader(title: "Sign Up To Continue",),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Personal Details
              SignupForm(dark: dark,),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Login page
              SignupSignInTextSwitch(registered: true,),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Sign in with google of facebook
              SocialButton(dark: dark),
            ],
          ),
        ),
      ),
    );
  }

  // Widget colorButton(labelText) {
  //   final emailController = _email;
  //   final passwordController = _password;
  //   final fullNameController = _fullName;
  //   final phoneController = _phone;
  //
  //   return InkWell(
  //       onTap: () async {
  //         setState(() {
  //           circular = true;
  //         });
  //
  //         Timestamp createDateTimestamp = Timestamp.fromDate(DateTime.now());
  //         final email = emailController.text.trim();
  //         final password = passwordController.text.trim();
  //         final user = UserModel(
  //           email: email,
  //           fullName: fullNameController.text.trim(),
  //           userName: '',
  //           phoneNo: phoneController.text.trim(),
  //           profilePicture: "",
  //           preferences: "",
  //           createdDate: createDateTimestamp,
  //         );
  //
  //         try {
  //           final userCredential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //             email: email,
  //             password: password,
  //           );
  //           createUser(user);
  //           setState(() {
  //             circular = false;
  //           });
  //           Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/login/',
  //                 (route) => false,
  //           );
  //         } on FirebaseAuthException catch (e) {
  //           late SnackBar snackBar;
  //           late final String errorCode;
  //           print(e.code);
  //           switch (e.code) {
  //             case 'weak-password':
  //               errorCode = 'Password too weak';
  //               break;
  //             case 'email-already-in-use':
  //               errorCode = 'Email already in use';
  //               break;
  //             case 'invalid-email':
  //               errorCode = 'Invalid email';
  //               break;
  //             default:
  //               errorCode = 'Unknown error';
  //           }
  //           if (!context.mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text(errorCode)),
  //           );
  //
  //           setState(() {
  //             circular = false;
  //           });
  //         }
  //       },
  //       child: Container(
  //           width: MediaQuery.of(context).size.width - 90,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: Colors.black,
  //           ),
  //           child: Center(
  //             child:
  //             circular?const CircularProgressIndicator()
  //                 : Text(
  //               labelText,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 20,
  //               ),
  //             ),
  //           ))
  //   );
  // }
}




