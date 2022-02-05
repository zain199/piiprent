import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/field.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/hint_name.dart';

class Question9 extends StatelessWidget {
  QuestionController qcontroller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x215d7cac),
                      offset: Offset(0, 4),
                      blurRadius: 38,
                      spreadRadius: 0)
                ],
                // border: colorcondition
                //     ? Border.all(width: 1, color: Color(0XFF2196F3))
                //     : null
              ),
              width: 343,
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: HintName(
                      hedrtxt: "FIRST NAME",
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TxtFeild(
                      readonly: false,
                      pwdstr: false,
                      cntrlr: qcontroller.firstnamecontroller,
                      changeValdt: (value) {
                        qcontroller.firstname.value = value;
                        qcontroller.onSubmit();
                      },
                      hinttxt: "First Name",
                      wdt: 303,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: HintName(
                      hedrtxt: "EMAIL",
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TxtFeild(
                      readonly: false,
                      pwdstr: false,
                      cntrlr: qcontroller.emailcontroller,
                      changeValdt: (value) {
                        qcontroller.email.value = value;
                        qcontroller.onSubmit();
                      },
                      hinttxt: "Email",
                      wdt: 303,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: HintName(
                      hedrtxt: "PHONE NUMBER",
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      height: 49,
                      width: 343,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFD3DEEA))),
                      child: Row(
                        children: [
                          Container(
                            width: 115,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Color(0XFFD3DEEA),
                            )),
                            child: CountryCodePicker(
                              hideMainText: true,
                              showFlag: true,
                              padding: EdgeInsets.zero,
                              showDropDownButton: true,
                              initialSelection: "IN",
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: qcontroller.phonenumbercontroller,
                                onChanged: (num) {
                                  qcontroller.phonenumber.value = num;
                                  qcontroller.onSubmit();
                                },
                                decoration: InputDecoration(
                                    hintText: "00000 00000",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        color: Color(0XFFD3DEEA)),
                                    border: InputBorder.none),
                                cursorColor: Color(0XFF2F363D),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF2F363D)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 106, right: 106, top: 25, bottom: 20),
                    child: Obx(() => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: qcontroller.isEnable.isTrue
                                ? Color(0XFF2196F3)
                                : Color(0XFFB8DFFF),
                            // color: Color(0XFF2196F3)
                          ),
                          width: 131,
                          height: 36,
                          child: TextButton(
                            onPressed: () {
                              qcontroller.onSubmit();
                              // step1controller.onindexChang();
                            },
                            child: Text(
                              "Save",
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
              )),
        )
      ],
    );
  }
}
