import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/login_new_page.dart';

class Step1Controller extends GetxController {
  // var todadate = DateTime.now();
  // var selectedDate = "".obs;
  // var selectGender = "".obs;
  // var title = "".obs;
  // var fname = "".obs;
  // var lname = "".obs;
  // var email = "".obs;
  // var wight = "".obs;
  // var het = "".obs;
  // var phnmer = "".obs;
  String value;
  var isImageupload = false.obs;

  RegistrationController registrationController =
      Get.put(RegistrationController());
  var emailcontroller = TextEditingController();
  var fnamecontroller = TextEditingController();
  var lnamecontroller = TextEditingController();
  var wightcontroller = TextEditingController();
  var hetcontroller = TextEditingController();
  var numcontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var isEnable = false.obs;
  var imagebyte;

  // var newimage = "".obs;

  onTapImage(bool camera) async {
    final image = await ImagePicker().pickImage(source: camera ? ImageSource.camera:ImageSource.gallery);

    isImageupload.value = true;

    registrationController.newimage.value = image.path;
    isImageupload.value = false;
    final bytes = await image.readAsBytes();
    value = 'data:image/jpeg;base64,${base64.encode(bytes)}';
    imagebyte = value;
  }

  titleSelected(ttl) {
    registrationController.title.value = ttl;
  }

  onNxtpg() {
    if (registrationController.fname.value.isEmpty) {
      // Get.snackbar("First name not empty", "Enter your Name");
      return isEnable.value = false;
    } else if (registrationController.lname.isEmpty) {
      // Get.snackbar("Last name not empty", "Enter your Last Name");
      return isEnable.value = false;
    } else if (registrationController.title.isEmpty) {
      // Get.snackbar("Title not empty", "Selecrt title");
      return isEnable.value = false;
    } else if (registrationController.selectGender.isEmpty) {
      // Get.snackbar("Gender is not empty", "Select Gender");
      return isEnable.value = false;
    } else if (registrationController.selectedDate.isEmpty) {
      // Get.snackbar("Birthdate is not empty", "Enter your Birthdate");
      return isEnable.value = false;
    } else if (registrationController.wight.isEmpty) {
      // Get.snackbar("Weight is not empty", "Enter your Weight");
      return isEnable.value = false;
    } else if (registrationController.het.isEmpty) {
      // Get.snackbar("Height is not empty", "Enter your Height");
      return isEnable.value = false;
    } else if (registrationController.email.isEmpty) {
      // Get.snackbar("Email is not empty", "Enter your Email");
      return isEnable.value = false;
    } else if (!registrationController.email.value.isEmail) {
      // Get.snackbar("Email Validation", "Enter Valid Email");
      return isEnable.value = false;
    } else if (registrationController.phnmer.isEmpty) {
      // Get.snackbar("Phone number is not empty", "Enter your number");
      return isEnable.value = false;
    } else {
      isEnable.value = true;
      // registrationController.stepIndex.value = 1;
    }
  }

  onindexChang() {
    if (isEnable == true) registrationController.stepIndex.value = 1;
  }

  onBack() {
    Get.to(LoginNewPage());
  }

  selctGender(value) {
    registrationController.selectGender.value = value;
    if (registrationController.selectGender.isEmpty) {
      Get.snackbar("Gender is not empty", "Select Gender");
      return;
    }
  }

  selectDate(BuildContext context) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now())
        .then((dob) {
      if (dob != null && dob != DateTime.now()) {
        registrationController.selectedDate.value =
        ("${dob.day}/${dob.month}/${dob.year}");
      }
    });
  }
}
