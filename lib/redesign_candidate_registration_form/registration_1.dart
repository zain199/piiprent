import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller1.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller2.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller3.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller4.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/step_1.dart';
import 'package:piiprent/redesign_candidate_registration_form/step_2.dart';
import 'package:piiprent/redesign_candidate_registration_form/step_3.dart';
import 'package:piiprent/redesign_candidate_registration_form/step_4.dart';
import 'package:piiprent/redesign_candidate_registration_form/step_bar.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/registration_page_appbar.dart';

class RegistrasionPage1 extends StatelessWidget {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  Step1Controller step1controller = Get.put(Step1Controller());
  Step2Controller step2controller = Get.put(Step2Controller());
  Step3Controller step3controller = Get.put(Step3Controller());
  Step4Controller step4controller = Get.put(Step4Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(builder: (controller) {
      return Scaffold(
        appBar: RegiAppbar(),
        body: Container(
          height: 1500,
          child: ListView(
            controller: registrationController.homeController,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              StepBarForm(),
              Obx(() => IndexedStack(
                    index: registrationController.stepIndex.value,
                    children: [
                      Step1(),
                      Step2(),
                      Step3(),
                      Step4(),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
