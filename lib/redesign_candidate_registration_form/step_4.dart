import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/models/industry_model.dart';
import 'package:piiprent/models/settings_model.dart';
import 'package:piiprent/models/skill_model.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller4.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/dropdown.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/field.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/hint_name.dart';
import 'package:piiprent/services/industry_service.dart';
import 'package:provider/provider.dart';

import 'controller/registration_controller.dart';

class Step4 extends StatelessWidget {
  Step4Controller step4controller = Get.put(Step4Controller());
  IndustryService industryService =
      Provider.of<IndustryService>(Get.context, listen: false);
  final StreamController industryStream = StreamController();
  Settings settings = Get.put(Settings());
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.industry').toUpperCase(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0XFFD3DEEA))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Dropdown<Industry>(
                  hint: translate('select.industry'),
                  future: industryService.getIndustries,
                  onSaved: (Industry item) {
                    registrationController.industry.value = item?.id;
                    return item.name;
                  },
                  renderFn: (Industry item) => item.name,
                  compareFn: (Industry item, Industry selectedItem) {
                    if (item.id == selectedItem.id) {
                      registrationController.industry.value = selectedItem.id;
                    }
                    return item.id == selectedItem.id;
                  },
                  onChanged: (Industry instance) {
                    registrationController.industry.value = instance?.id;
                    industryStream.add(instance?.id);
                    step4controller.onNxtpg4();
                    print(
                        "industry : ${registrationController.industry.value}");
                  },
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.skills').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Container(
            height: 49,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0XFFD3DEEA))),
            child: StreamBuilder(
              stream: industryStream.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return TxtFeild(
                    readonly: true,
                    hinttxt: translate('select.skills'),
                    pwdstr: false,
                    sfxicn: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0XFF2196F3),
                    ),
                  );
                }

                String industry = snapshot.data;
                return FutureBuilder(
                  future: Future.value(industry),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Dropdown<Skill>(
                        future: (Map<String, dynamic> query) => this
                            .industryService
                            .getSkills(
                                snapshot.data, settings.company, query),
                        label: "",
                        hint: translate('select.skills'),
                        renderFn: (Skill item) {
                          return item.name;
                        },
                        compareFn: (Skill item, Skill selectedItem) {
                          return item.id == selectedItem.id;
                        },
                        multiple: true,
                        onSaved: (List<Skill> skills) {
                          if (skills != null) {
                            registrationController.skil.value =
                                skills.map((e) => e.id).toList();
                            print(registrationController.skil.value);
                          } else {
                            skills = [];
                          }
                        },
                        onChanged: (List<Skill> skill) {
                          if (skill != null) {
                            registrationController.skil.value =
                                skill.map((e) => e.id).toList();
                            print(registrationController.skil.value);
                          } else {
                            skill = [];
                          }
                          step4controller.onNxtpg4();
                          print("skill:${registrationController.skil.value}");
                        },
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
        ),
        Spacer(),
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
                padding: const EdgeInsets.only(top: 15, left: 16,right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0XFF2196F3))),
                        width: 164,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            step4controller.onBack();
                          },
                          child: Text(
                            translate("Back"),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: Color(0XFF2196F3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Obx(() => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: step4controller.isEnable.isTrue
                              ? Color(0XFF2196F3)
                              : Color(0XFFB8DFFF),
                        ),
                        width: 164,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            step4controller.onLastpage();
                          },
                          child: Text(
                            translate("Done!"),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white),
                              ),
                        ),
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
