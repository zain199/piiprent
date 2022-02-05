import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';

class Step2Controller extends GetxController {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  // var adres = "".obs;
  // var nationality = "".obs;
  // var residency = "".obs;
  // var tranport = "".obs;
  var adrescontroller = TextEditingController();

  // var natnlitycontroller = TextEditingController();
  // var resdncycontroller = TextEditingController();
  var isEnable = false.obs;

  transpotSelct(slct) {
    registrationController.tranport.value = slct;
  }

  onBack2() {
    registrationController.stepIndex.value = 0;
  }

  onNxtpg2() {
    if (registrationController.adres.isEmpty) {
      // Get.snackbar("Address is not empty", "Enter your Address");
      return isEnable.value = false;
    } else if (registrationController.nationality.isEmpty) {
      // Get.snackbar("Nationality is not empty", "Choose your Nationality");
      return isEnable.value = false;
    } else if (registrationController.tranport.isEmpty) {
      return isEnable.value = false;
    } else if (registrationController.residency.isEmpty) {
      // Get.snackbar("Residency is not empty", "Select your Residency");
      return isEnable.value = false;
    } else {
      return isEnable.value = true;
    }
    // registrationController.stepIndex.value = 2;
  }

  onNextpage() {
    if (isEnable == true) registrationController.stepIndex.value = 2;
  }
}
