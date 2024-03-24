import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/util/constants/sizes.dart';
import '../../../widgets/section_heading.dart';

class CreateTripForm extends StatelessWidget {
  final TextEditingController tripNameController;
  final TextEditingController locationController;

  const CreateTripForm({
    required this.tripNameController,
    required this.locationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Trip Title
        const SectionHeading(title: "Trip Name", showActionButton: false,),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        // Trip Form Field
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.location),
            labelText: "Trip Name",
          ),
          controller: tripNameController,
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        // Location Title
        const SectionHeading(title: "Location", showActionButton: false,),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        // Location Form Field
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.location),
            labelText: "Location",
          ),
          controller: locationController,
        ),
      ],
    );
  }
}