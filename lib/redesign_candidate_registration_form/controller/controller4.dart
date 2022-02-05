import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:provider/provider.dart';

class Step4Controller extends GetxController {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  // var industry = "".obs;
  // var skil = [].obs;
  var isEnable = false.obs;

  var industrycontroller = TextEditingController();
  var skillcontroller = TextEditingController();

  ContactService contactService =
      Provider.of<ContactService>(Get.context, listen: false);

  onNxtpg4() {
    if (registrationController.industry.value.isEmpty) {
      // Get.snackbar("Industry is not empty", "Select Industry name");
      return isEnable.value = false;
    } else if (registrationController.skil.value.isEmpty) {
      //
      //   // Get.snackbar("Skill is not empty", "Choose your Skill");
      return isEnable.value = false;
    } else
      isEnable.value = true;
  }

  onLastpage() {
    if (isEnable.value == true) print("hiii");
    registrationController.register(contactService);
  }

  onBack() {
    registrationController.stepIndex.value = 2;
  }
}
