// import 'package:enhance_stepper/enhance_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_assistant/core/util/constants/colors.dart';
// import 'package:tuple/tuple.dart';
//
// import '../../../../../controllers/trips/trip_stepper_controller.dart';
// import 'location_card.dart';
//
// class TripStepper extends StatelessWidget {
//   const TripStepper({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TripStepperController());
//
//     List<Tuple2> tuples = [
//       Tuple2(Icons.delete, StepState.indexed, ),
//       Tuple2(Icons.directions_bus, StepState.editing, ),
//       Tuple2(Icons.directions_railway, StepState.complete, ),
//     ];
//
//     return EnhanceStepper(
//         stepIconSize: 30,
//         type: controller.type,
//         horizontalTitlePosition: HorizontalTitlePosition.bottom,
//         horizontalLinePosition: HorizontalLinePosition.top,
//         currentStep: controller.index,
//         physics: ClampingScrollPhysics(),
//         steps: tuples.map((e) => EnhanceStep(
//           icon: Icon(Icons.delete, color: CustomColors.secondary, size: 30,),
//           state: StepState.values[tuples.indexOf(e)],
//           isActive: controller.index == tuples.indexOf(e),
//           title: LocationCard(),
//           content: LocationCard(),
//         )).toList(),
//         onStepCancel: () {
//         },
//         onStepContinue: () {
//         },
//         onStepTapped: (index) {
//           controller.index = index;
//         },
//         controlsBuilder: (BuildContext context, ControlsDetails details){
//           return Row(
//             children: [
//               // SizedBox(height: 30,),
//               // ElevatedButton(
//               //   onPressed: onStepContinue,
//               //   child: Text("Next"),
//               // ),
//               // SizedBox(width: 8,),
//               // TextButton(onPressed: onStepCancel, child: Text("Back"), ),
//             ],
//           );
//         }
//     );
//   }
// }