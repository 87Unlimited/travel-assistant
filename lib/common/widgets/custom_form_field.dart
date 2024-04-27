import 'package:flutter/material.dart';

import '../../../../core/util/constants/colors.dart';

class CustomFormField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;

  const CustomFormField({
    Key? key,
    this.initialValue,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool obscure = labelText == "Password" ? true : false;

    controller.text = initialValue ?? '';
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          label: Text(
            labelText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          prefixIcon: Icon(prefixIcon, color: CustomColors.textHint,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: CustomColors.textHint,
            ),
          ),
        ),
      ),
    );
  }
}