import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller3.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/field.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/hint_name.dart';

import 'controller/registration_controller.dart';

class Step3 extends StatelessWidget {
  Step3Controller step3controller = Get.put(Step3Controller());
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 1000,
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.account_holders_name').toUpperCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: TxtFeild(
              readonly: false,
              cntrlr: step3controller.anamecontroller,
              changeValdt: (name) {
                registrationController.acounhldrname.value = name;
                step3controller.onNxtpg3();
              },
              pwdstr: false,
              hinttxt: translate('field.account_holders_name'),
              wdt: 343,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.bank_name').toUpperCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: TxtFeild(
              readonly: false,
              cntrlr: step3controller.banknamcontroller,
              changeValdt: (bank) {
                registrationController.bankname.value = bank;
                step3controller.onNxtpg3();
              },
              pwdstr: false,
              hinttxt: translate('field.bank_name'),
              wdt: 343,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.iban'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: TxtFeild(
              readonly: false,
              cntrlr: step3controller.ibancontroller,
              changeValdt: (iban) {
                registrationController.iban.value = iban;
                step3controller.onNxtpg3();
              },
              pwdstr: false,
              hinttxt: translate('field.iban').toLowerCase(),
              wdt: 343,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: "PERSONAL IDENTIFICATION CODE",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: TxtFeild(
              readonly: false,
              cntrlr: step3controller.picodecontroller,
              changeValdt: (code) {
                registrationController.pincode.value = code;
                step3controller.onNxtpg3();
              },
              pwdstr: false,
              hinttxt: translate('field.personal_id'),
              wdt: 343,
            ),
          ),
          SizedBox(
            height: 155,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 1,
                  color: Color(0XFFD3DEEA),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0XFF2196F3))),
                        width: 164,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            step3controller.onBack3();
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: Color(0XFF2196F3)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: step3controller.isEnable.isTrue
                                  ? Color(0XFF2196F3)
                                  : Color(0XFFB8DFFF),
                            ),
                            width: 164,
                            height: 43,
                            child: TextButton(
                              onPressed: () {
                                step3controller.onthirdPage();
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
