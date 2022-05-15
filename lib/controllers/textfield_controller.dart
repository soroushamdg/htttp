import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class TextFieldController extends GetxController {
  TextEditingController cmdFieldController = TextEditingController();

  TextEditingController addDialogFieldController = TextEditingController();

  RxString DropDownValueController = 'GET'.obs;
}
