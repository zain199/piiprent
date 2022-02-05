import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller1.dart';
import 'package:piiprent/redesign_candidate_registration_form/login_new_page.dart';
import 'package:piiprent/services/contact_service.dart';

class RegistrationController extends GetxController {
  var stepIndex = 0.obs;
  var todadate = DateTime.now();
  var selectedDate = "".obs;
  var selectGender = "".obs;
  var title = "".obs;
  var fname = "".obs;
  var lname = "".obs;
  var email = "".obs;
  var wight = "".obs;
  var het = "".obs;
  var phnmer = "".obs;
  var newimage = "".obs;
  var addessforapi;
  var adres = "".obs;
  var nationality = "".obs;
  var residency = "".obs;
  var tranport = "".obs;

  var acounhldrname = "".obs;
  var bankname = "".obs;
  var iban = "".obs;
  var pincode = "".obs;

  var industry = "".obs;
  var skil = [].obs;
  var skills = "".obs;
  final homeController = ScrollController();
  final StreamController fetchingStream = StreamController();
  final StreamController errorStream = StreamController();

  bool registered = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

// final bytes = await image.readAsBytes();
  // value = 'data:image/jpeg;base64,${base64.encode(bytes)}';

  void scrollDown() {
    if (homeController.hasClients) {
      homeController.animateTo(homeController.position.minScrollExtent,
          duration: Duration(microseconds: 10), curve: Curves.fastOutSlowIn);
    }
  }

  register(ContactService contactService) async {
    // formKey.currentState.save();
    // if (!formKey.currentState.validate()) {
    //   return;
    // }
    // fetchingStream.add(true);
    // errorStream.add(null);

    try {
      var result = await contactService.register(
        birthday: selectedDate.value,
        email: email.value,
        firstName: fname.value,
        lastName: lname.value,
        industry: industry.value,
        phone: phnmer.value,
        skills: skil.value,
        title: title.value,
        gender: selectGender.value,
        residency: residency.value,
        nationality: nationality.value,
        transport: tranport.value,
        height: het.value,
        weight: wight.value,
        bankAccountName: acounhldrname.value,
        bankName: bankname.value,
        iban: iban.value,
        address: addessforapi,
        personalId: pincode.value,
        picture: Get.find<Step1Controller>().imagebyte,
      );

      print(result);
      if (result == true) {
        registered = true;

        Get.snackbar("Registration Details", "You are registered!",
            colorText: Colors.green[400], backgroundColor: Colors.white);
        Get.to(LoginNewPage());
        // ScaffoldMessenger.of(Get.context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Colors.green[400],
        //     content: const Text(
        //       'You are registered!',
        //       style: TextStyle(color: Color(0XFF2196F3)),
        //     ),
        //   ),
        // );
      }
    } catch (e) {
      errorStream.add(e.toString());
      Get.snackbar("Registration Details", "${e.toString()}",
          colorText: Colors.red[800], backgroundColor: Colors.black);
      print("error : ${e.toString()}");
    } finally {
      fetchingStream.add(false);
    }
  }
}
