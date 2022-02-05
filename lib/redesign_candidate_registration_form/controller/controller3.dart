import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';

class Step3Controller extends GetxController {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  // var acounhldrname = "".obs;
  // var bankname = "".obs;
  // var iban = "".obs;
  // var picode = "".obs;
  var isEnable = false.obs;
  var anamecontroller = TextEditingController();
  var banknamcontroller = TextEditingController();
  var ibancontroller = TextEditingController();
  var picodecontroller = TextEditingController();

  onBack3() {
    registrationController.stepIndex.value = 1;
  }

  onNxtpg3() {
    if (registrationController.acounhldrname.value.isEmpty) {
      // Get.snackbar(
      //     "Account holder name is not empty", "Enter Bank account holder name");
      return isEnable.value = false;
    } else if (registrationController.bankname.isEmpty) {
      // Get.snackbar("BankName is not empty", "Choose your Bank");
      return isEnable.value = false;
    } else if (registrationController.iban.isEmpty) {
      // Get.snackbar("IBAN is not empty", "Enter IBAN");
      return isEnable.value = false;
    } else if (registrationController.pincode.isEmpty) {
      // Get.snackbar(
      //     "Personal identification code is not empty", "Enter your code");
      return isEnable.value = false;
    } else
      return isEnable.value = true;
    // registrationController.stepIndex.value = 3;
  }

  onthirdPage() {
    if (isEnable == true) registrationController.stepIndex.value = 3;
  }
}
