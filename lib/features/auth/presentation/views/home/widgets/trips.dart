// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';
//
// import '../../../../../../common/widgets/trip/trip_cards/trip_card_vertical.dart';
// import '../../../../../../core/util/constants/image_strings.dart';
//
// class Trips extends StatelessWidget {
//   const Trips({
//     super.key,
//     this.isTripExist = true,
//   });
//   final bool isTripExist;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 210,
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: 4,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (_, index) {
//           return TripCard(
//             title: "Japan Trip",
//             location: "Tokyo, Japan",
//             onTap: (){
//               //Get.to(LoginView());
//             },
//           );
//         },
//       ),
//     );
//   }
// }