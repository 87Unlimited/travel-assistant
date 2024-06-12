import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/home_controller.dart';

import '../../../../../../common/widgets/custom_shapes/circular_container.dart';
import '../../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../data/models/activity_model.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.banners,
    this.activities,
  });

  final List<String> banners;
  final List<ActivityModel>? activities;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Obx(() => Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) => controller.updatePageIndicator(index),
            ),
            items: banners.map((url) => RoundedImage(
                imageUrl: url,
                isNetworkImage: true,
            )).toList(),
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems,),
          Obx(() => Center(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int i = 0; i < banners.length; i++)
                      CircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor: controller.carousalCurrentIndex.value == i ? CustomColors.secondary : CustomColors.grey,
                      ),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}