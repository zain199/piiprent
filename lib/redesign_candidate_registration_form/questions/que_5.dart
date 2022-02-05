import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/radio_container.dart';

class Question5 extends StatelessWidget {
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
                colorcondition: qcontroller.question5.value == "0 - 1 km",
                value: "0 - 1 km",
                text: "0 - 1 km",
                groupvalue: qcontroller.question5.value,
                onchanged: (val) {
                  qcontroller.question5.value = val;
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
          child: Obx(() => RadioContainer(
                colorcondition: qcontroller.question5.value == "2 - 5 km",
                value: "2 - 5 km",
                text: "2 - 5 km",
                groupvalue: qcontroller.question5.value,
                onchanged: (val) {
                  qcontroller.question5.value = val;
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
          child: Obx(() => RadioContainer(
                colorcondition: qcontroller.question5.value == "5 - 10 km",
                value: "5 - 10 km",
                text: "5 - 10 km",
                groupvalue: qcontroller.question5.value,
                onchanged: (val) {
                  qcontroller.question5.value = val;
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
          child: Obx(() => RadioContainer(
                colorcondition: qcontroller.question5.value == "> 10 km",
                value: "> 10 km",
                text: "> 10 km",
                groupvalue: qcontroller.question5.value,
                onchanged: (val) {
                  qcontroller.question5.value = val;
                },
              )),
        )
      ],
    );
  }
}
