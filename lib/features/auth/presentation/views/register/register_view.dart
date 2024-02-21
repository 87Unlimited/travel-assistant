import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../../data/repository/user_repository.dart';
import '../../../domain/entities/user_model.dart';
import '../../widgets/social_button.dart';
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
              Form(
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
                        labelText: "Email",
                      ),
                      controller: _email,
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    // Password
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(FontAwesomeIcons.lock),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: const Icon(FontAwesomeIcons.solidEyeSlash),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                      ),
                      obscureText: obscure,
                      controller: _password,
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    // Re-Enter Password
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(FontAwesomeIcons.lock),
                        labelText: "Re-enter Password",
                        suffixIcon: IconButton(
                          icon: const Icon(FontAwesomeIcons.solidEyeSlash),
                          onPressed: () {
                            setState(() {
                              reObscure = !reObscure;
                            });
                          },
                        ),
                      ),
                      obscureText: obscure,
                      controller: _rePassword,
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    // Full Name
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.solidUser),
                        labelText: "Full Name",
                      ),
                      controller: _fullName,
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    // Phone Number
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.phone),
                        labelText: "Phone Number",
                      ),
                      controller: _phone,
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    // Privacy Policy Checkbox
                    Row(
                      children: [
                        SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value) {})),
                        const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: "Privacy Policy ",
                                style: Theme.of(context).textTheme.bodyMedium!.apply(
                                  color: dark ? Colors.white : CustomColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: dark ? Colors.white : CustomColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Go to Privacy Policy page.
                                  // Get.to();
                                },
                              ),
                              TextSpan(
                                  text: "and ",
                                  style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: "Terms of use ",
                                style: Theme.of(context).textTheme.bodyMedium!.apply(
                                  color: dark ? Colors.white : CustomColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: dark ? Colors.white : CustomColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Go to Terms of use page.
                                  // Get.to();
                                },
                              ),
                            ]
                          )
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Sign Up Button
              Center(
                child: SizedBox(
                  width: CustomSizes.buttonWidth,
                  height: CustomSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: const Center(
                      child: Text('Sign Up'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Login page
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Already registered? ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: "Login here! ",
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: CustomColors.secondary,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                            Get.to(const LoginView());
                          },
                      ),
                    ],
                  ),
                ),
              ),
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
