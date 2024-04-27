import 'package:flutter/material.dart';

import '../../../../../../common/widgets/image_text_widgets/vertical_image.dart';
import '../../../../../../core/util/constants/image_strings.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return const VerticalImageText(image: CustomImages.appLogo, title: "Test",);
        },
      ),
    );
  }
}