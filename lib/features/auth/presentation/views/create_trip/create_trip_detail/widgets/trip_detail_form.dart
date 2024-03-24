import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/util/constants/sizes.dart';

class TripDetailForm extends StatelessWidget {
  const TripDetailForm({
    super.key,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController fullName,
    required TextEditingController phone,
  }) : _email = email, _password = password, _fullName = fullName, _phone = phone;

  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _fullName;
  final TextEditingController _phone;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Email
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
              labelText: "Location Name",
            ),
            controller: _email,
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Password
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.lock),
              labelText: "Address",
            ),
            controller: _password,
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
        ],
      ),
    );
  }
}