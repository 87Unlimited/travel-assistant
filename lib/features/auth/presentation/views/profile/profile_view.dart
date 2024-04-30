import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/appbar.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/profile/change_details/change_name.dart';
import 'package:travel_assistant/features/auth/presentation/views/profile/widgets/profile_text_button.dart';

import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6F6),
      appBar: CustomAppBar(
          title: Text(
            "Profile",
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CircularImage(image: 'assets/user/profile.png', width: 80, height: 80,),
                    TextButton(onPressed: (){}, child: const Text("Change Profile Picture")),
                  ],
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems / 2),

              // Divider
              const Divider(color: CustomColors.grey,),
              const SizedBox(height: CustomSizes.spaceBtwItems),
              
              const SectionHeading(title: "Profile Information", showActionButton: false,),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              ProfileTextButton(
                icon: Iconsax.arrow_right_34,
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => ChangeNameView()),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              ProfileTextButton(
                  icon: Iconsax.arrow_right_34,
                  title: 'User Name',
                  value: controller.user.value.userName,
                  onPressed: () {}),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Divider
              const Divider(color: CustomColors.grey,),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              const SectionHeading(title: "Personal Information", showActionButton: false,),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              ProfileTextButton(
                icon: Iconsax.arrow_right_34,
                title: 'Email',
                value: controller.user.value.email,
                onPressed: () => Get.to(() => ChangeNameView()),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              ProfileTextButton(
                icon: Iconsax.arrow_right_34,
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () => Get.to(() => ChangeNameView()),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Divider
              const Divider(color: CustomColors.grey,),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),
              
              Center(
                child: TextButton(
                  onPressed: () async {
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      await AuthenticationRepository.instance.logout();
                      print(FirebaseAuth.instance.currentUser);
                    } else {
                      return;
                    }
                  },
                  child: const Text("Logout", style: TextStyle(color: CustomColors.darkGrey),),
                ),
              ),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text("Delete Account", style: TextStyle(color: Colors.red),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showLogOutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: const Text("Cancel"),),
            TextButton(onPressed: () {
              Navigator.of(context).pop(true);
            }, child: const Text("Sign out"),),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
