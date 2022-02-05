import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../langugesmodel.dart';

class QuestionController extends GetxController {
  var index = 0.obs;
  var question1 = "".obs;
  var question2 = "".obs;
  var question3 = "".obs;
  var question4 = "".obs;
  var question5 = "".obs;
  var question6 = "".obs;
  var question8 = "".obs;
  var selectedDate = "".obs;
  var firstname = "".obs;
  var email = "".obs;
  var phonenumber = "".obs;
  var progressvalue = 0.11.obs;
  var datecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var firstnamecontroller = TextEditingController();
  var phonenumbercontroller = TextEditingController();
  var isEnable = false.obs;

  onSubmit() {
    if (firstname.value.isEmpty) {
      return isEnable.value = false;
    } else if (email.value.isEmpty) {
      return isEnable.value = false;
    } else if (!email.value.isEmail) {
      return isEnable.value = false;
    } else if (phonenumber.value.isEmpty) {
      return isEnable.value = false;
    } else
      return isEnable.value = true;
  }

  var isLan = false.obs;

  var langauges = <LangugesModel>[];
  List Questionlist = [
    "Do you have an European passport or ID card?",
    "Do you have a driving licence?",
    "Do you have a COVID certificate?",
    "Do you have the opportunity to use a private car to drive to work?",
    "How far are you ready to go to work?",
    "Do you use public transport if you have to drive to work for up to 30 minutes?",
    "What languages do you speak?",
    "When can you start work?",
    "In case you have a workmates, friends, acquaintances who could work for us with you, please write their names, phone numbers and e-mail addresses here.",
  ];

  @override
  void onInit() {
    langauges.add(LangugesModel("Finnish", isChecked: false.obs));
    langauges.add(LangugesModel("Russian", isChecked: false.obs));
    langauges.add(LangugesModel("English", isChecked: false.obs));
    langauges.add(LangugesModel("Estonian", isChecked: false.obs));
    langauges.add(LangugesModel("Other", isChecked: false.obs));
    print("lentgh : ${langauges.length}");
    super.onInit();
  }

  onpressed() {
    if (index.value < 8) {
      index.value = index.value + 1;
      updateProgress();
    } else {
      Get.snackbar("All Answer Submitted", "Successfully Completed");
    }
  }

  updateProgress() {
    progressvalue.value = progressvalue.value + 0.11;
  }

  progressUpdate() {
    progressvalue.value = progressvalue.value - 0.11;
  }

  onLang() {
    langauges.firstWhere((element) {
      if (element.isChecked.value == true)
        return isLan.value = true;
      else
        return isLan.value = false;
    });
  }

  selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: (new DateTime.now()).add(new Duration(days: 2)),
            firstDate: (new DateTime.now()).add(new Duration(days: 2)),
            // lastDate: DateTime(DateTime.now().month + 6))
            lastDate: (new DateTime.now()).add(new Duration(days: 60)))
        .then((dob) {
      if (dob != null && dob != DateTime.now()) {
        selectedDate.value = ("${dob.day}/${dob.month}/${dob.year}");
      }
    });
  }
}
