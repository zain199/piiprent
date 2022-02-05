import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/radio_container.dart';

class Question1 extends StatelessWidget {
  QuestionController qcontroller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
          child: Obx(() => RadioContainer(
                colorcondition: (qcontroller.question1.value == "Yes"),
                value: "Yes",
                text: "Yes",
                groupvalue: qcontroller.question1.value,
                onchanged: (val) {
                  qcontroller.question1.value = val;
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
          child: Obx(() => RadioContainer(
                colorcondition: qcontroller.question1.value == "No",
                value: "No",
                text: "No",
                groupvalue: qcontroller.question1.value,
                onchanged: (val) {
                  qcontroller.question1.value = val;
                },
              )),
        )
      ],
    );
  }
}
