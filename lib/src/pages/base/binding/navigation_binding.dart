import 'package:get/get.dart';
import 'package:app/src/pages/base/controller/navigation_controller.dart';

class NavigationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}