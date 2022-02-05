import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';

class StepBarForm extends StatelessWidget {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    // var i = registrationController.stepIndex.value.obs;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: registrationController.stepIndex.value != 0
                          ? Color(0XFF66BA6C)
                          : Color(0XFF2196F3),

                      // Color(0XFF2196F3),
                    ),
                    height: 30,
                    width: 30,
                    child: TextButton(
                        onPressed: () {
                          registrationController.stepIndex.value = 0;
                        },
                        child: registrationController.stepIndex.value == 0
                            ? Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              )
                            : Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              )))),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Obx(
                    () => Container(
                      width: 70,
                      height: 2,
                      color: registrationController.stepIndex.value == 0
                          ? Color(0XFFBCC8D6)
                          : Color(0XFF66BA6C),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: registrationController.stepIndex.value == 0
                          ? Color(0XFFBCC8D6)
                          : registrationController.stepIndex.value == 1
                              ? Color(0XFF2196F3)
                              : Color(0XFF66BA6C),
                    ),
                    height: 30,
                    width: 30,
                    child: TextButton(
                        onPressed: () {
                          registrationController.stepIndex.value = 1;
                        },
                        child: registrationController.stepIndex.value > 1
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              )
                            : Text(
                                '2',
                                style: TextStyle(
                                    color:
                                        registrationController.stepIndex.value <
                                                1
                                            ? Color(0XFF919CA7)
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              )))),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Obx(
                    () => Container(
                      width: 70,
                      height: 2,
                      color: registrationController.stepIndex.value < 2
                          ? Color(0XFFBCC8D6)
                          : Color(0XFF66BA6C),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: registrationController.stepIndex.value < 2
                          ? Color(0XFFBCC8D6)
                          : registrationController.stepIndex.value == 2
                              ? Color(0XFF2196F3)
                              : Color(0XFF66BA6C),
                    ),
                    height: 30,
                    width: 30,
                    child: TextButton(
                        onPressed: () {
                          registrationController.stepIndex.value = 2;
                        },
                        child: registrationController.stepIndex.value > 2
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              )
                            : Text(
                                '3',
                                style: TextStyle(
                                    color:
                                        registrationController.stepIndex.value <
                                                2
                                            ? Color(0XFF919CA7)
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              )))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Obx(() => Container(
                  width: 70,
                      height: 2,
                      color: registrationController.stepIndex.value < 3
                          ? Color(0XFFBCC8D6)
                          : Color(0XFF66BA6C),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: registrationController.stepIndex.value < 3
                          ? Color(0XFFBCC8D6)
                          : Color(0XFF2196F3),
                    ),
                    height: 30,
                    width: 30,
                    child: TextButton(
                        onPressed: () {
                          registrationController.stepIndex.value = 3;
                        },
                        child: Text(
                          '4',
                          style: TextStyle(
                              color: registrationController.stepIndex.value < 3
                                  ? Color(0XFF919CA7)
                                  : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        )))),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            translate('title.generalinfo'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    registrationController.stepIndex.value == 0
                                        ? Color(0XFF2196F3)
                                        : Color(0XFF66BA6C),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto"),
                          )),
                    ),
                  )),
              Obx(
                () => Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          translate('title.additional'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: registrationController.stepIndex.value < 1
                                  ? Color(0XFFBCC8D6)
                                  : registrationController.stepIndex.value == 1
                                      ? Color(0XFF2196F3)
                                      : Color(0XFF66BA6C),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto"),
                        )),
                  ),
                ),
              ),
              Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            translate('title.financial'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: registrationController.stepIndex.value <
                                        2
                                    ? Color(0XFFBCC8D6)
                                    : registrationController.stepIndex.value ==
                                            2
                                        ? Color(0XFF2196F3)
                                        : Color(0XFF66BA6C),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto"),
                          )),
                    ),
                  )),
              Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            translate('title.industryskills'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    registrationController.stepIndex.value < 3
                                        ? Color(0XFFBCC8D6)
                                        : Color(0XFF2196F3),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto"),
                          )),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
//
