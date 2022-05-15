import 'package:get/get.dart';
import 'package:htttp/controllers/session_controller.dart';
import 'package:htttp/controllers/universal_controller.dart';

import '../controllers/textfield_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TextFieldController());
    Get.put(UniversalSessionsController());
  }
}
