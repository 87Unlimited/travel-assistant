import 'package:get/get.dart';
import 'package:travel_assistant/core/network/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}