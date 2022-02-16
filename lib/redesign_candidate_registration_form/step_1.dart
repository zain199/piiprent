import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller1.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/field.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/hint_name.dart';

import 'controller/registration_controller.dart';

class Step1 extends StatelessWidget {
  var dob;
  Step1Controller step1controller = Get.put(Step1Controller());
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35, right: 10),
                child: Obx(() => GestureDetector(
                    onTap: () {
                      step1controller.onTapImage(false);
                    },
                    child: registrationController.newimage.value.isEmpty
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Color(0XFFEEF6FF),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 75,
                              color: Color(0XFF51A1F5),
                            ),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: Color(0XFFEEF6FF),
                                image: step1controller.isImageupload.value
                                    ? CircularProgressIndicator()
                                    : DecorationImage(
                                        image: FileImage(File(
                                            registrationController
                                                .newimage.value)),
                                        fit: BoxFit.cover,
                                      )),
                          ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0XFF2196F3))),
                          width: 164,
                          height: 43,
                          child: TextButton(
                            onPressed: () {
                              step1controller.onTapImage(false);
                              print("image : ${registrationController.newimage.value}");
                            },
                            child: Text(
                              translate('button.take_photo'),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  color: Color(0XFF2196F3)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0XFF2196F3))),
                          width: 164,
                          height: 43,
                          child: TextButton(
                            onPressed: () {
                              step1controller.onTapImage(true);
                              print("image : ${registrationController.newimage.value}");
                            },
                            child: Text(
                              translate('button.use_camera'),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  color: Color(0XFF2196F3)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: HintName(
            hedrtxt: translate('field.first_name').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: TxtFeild(
            readonly: false,
            changeValdt: (name) {
              registrationController.fname.value = name;
              step1controller.onNxtpg();
            },
            cntrlr: step1controller.fnamecontroller,
            pwdstr: false,
            hinttxt: translate('field.first_name'),
            wdt: 343,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.last_name').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: TxtFeild(
            readonly: false,
            cntrlr: step1controller.lnamecontroller,
            changeValdt: (lname) {
              registrationController.lname.value = lname;
              step1controller.onNxtpg();
            },
            pwdstr: false,
            hinttxt: translate('field.last_name'),
            wdt: 343,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.title').toUpperCase(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color: registrationController.title.value == translate('title1')
                                ? Color(0XFF2196F3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,
                    width: 82,
                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('title1'),
                                groupValue: registrationController.title.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.titleSelected(val);
                                  step1controller.onNxtpg();
                                }),

                        Expanded(
                          child: Text(
                            translate('title1'),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: registrationController.title.value == translate('title1')
                                        ? Colors.white
                                        : Color(0XFFBCC8D6)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9, top: 10),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color: registrationController.title.value == translate('title2')
                                ? Color(0XFF2196F3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,
                    width: 82,
                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('title2'),
                                groupValue: registrationController.title.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.titleSelected(val);
                                  step1controller.onNxtpg();
                                }),
                        // SizedBox(width:5,),
                        Expanded(
                          child: Text(
                            translate('title2'),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: registrationController.title.value == translate('title2')
                                        ? Colors.white
                                        : Color(0XFFBCC8D6)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9, top: 10),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color: registrationController.title.value == translate('title3')
                                ? Color(0XFF2196F3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,
                    width: 85,
                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('title3'),
                                groupValue: registrationController.title.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.titleSelected(val);
                                  step1controller.onNxtpg();
                                }),
                        // SizedBox(width:5,),
                        Expanded(
                          child: Text(
                            translate('title3'),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color:
                                        registrationController.title.value == translate('title3')
                                            ? Colors.white
                                            : Color(0XFFBCC8D6)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9, top: 10,right: 16),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color: registrationController.title.value == translate('title4')
                                ? Color(0XFF2196F3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,
                    width: 82,
                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('title4'),
                                groupValue: registrationController.title.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.titleSelected(val);
                                  step1controller.onNxtpg();
                                }),
                        // SizedBox(width:5,),
                        Expanded(
                          child: Text(
                            translate('title4'),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: registrationController.title.value == translate('title4')
                                        ? Colors.white
                                        : Color(0XFFBCC8D6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.gender').toUpperCase(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color:
                                registrationController.selectGender.value == translate('genderMale')
                                    ? Color(0XFF2196F3)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,

                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('genderMale'),
                                groupValue:
                                    registrationController.selectGender.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.selctGender(val);
                                  step1controller.onNxtpg();
                                }),
                        // SizedBox(width:5,),
                        Text(
                          translate('genderMale'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color:
                              registrationController.selectGender.value ==
                                              translate('genderMale')
                                          ? Colors.white
                                  : Color(0XFFBCC8D6)),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10,right: 16),
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                        color: registrationController.selectGender.value ==
                                    translate('genderFemale')
                                ? Color(0XFF2196F3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0XFFD3DEEA))),
                    height: 39,

                    child: Row(
                      children: [
                        Radio(
                            splashRadius: 7.0,
                                value: translate('genderFemale'),
                                groupValue:
                                    registrationController.selectGender.value,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  step1controller.selctGender(val);
                                  step1controller.onNxtpg();
                                }),
                        // SizedBox(width:5,),
                        Text(
                          translate('genderFemale'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color:
                              registrationController.selectGender.value ==
                                              translate('genderFemale')
                                          ? Colors.white
                                  : Color(0XFFBCC8D6)),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.birthday').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Obx(() => TxtFeild(
            readonly: false,
                keytype: TextInputType.datetime,
                changeValdt: (date) {
                  registrationController.selectedDate.value = date;
                  step1controller.onNxtpg();
                },
                cntrlr: step1controller.datecontroller
                  ..text = registrationController.selectedDate.value,
                pwdstr: false,
                hinttxt: "00/00/0000",
                wdt: 343,
                sfxicn: IconButton(
              icon: Icon(
                Icons.date_range_rounded,
                size: 25,
                color: Color(0XFF2196F3),
              ),
              onPressed: () => step1controller.selectDate(context),
            ),
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 16),
                      child: HintName(
                        hedrtxt: translate('field.weight').toUpperCase(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16),
                      child: TxtFeild(
                        readonly: false,
                        keytype: TextInputType.number,
                        cntrlr: step1controller.wightcontroller,
                        changeValdt: (weght) {
                          registrationController.wight.value = weght;
                          step1controller.onNxtpg();
                        },
                        pwdstr: false,
                        hinttxt: "00",

                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 16),
                      child: HintName(
                        hedrtxt: translate('field.height').toUpperCase(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16,right: 16),
                      child: TxtFeild(
                        readonly: false,
                        keytype: TextInputType.number,
                        cntrlr: step1controller.hetcontroller,
                        changeValdt: (heigt) {
                          registrationController.het.value = heigt;
                          step1controller.onNxtpg();
                        },
                        pwdstr: false,
                        hinttxt: "00",

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.email').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: TxtFeild(
            readonly: false,
            keytype: TextInputType.emailAddress,
            cntrlr: step1controller.emailcontroller,
            changeValdt: (mail) {
              registrationController.email.value = mail;
              step1controller.onNxtpg();
            },
            pwdstr: false,
            hinttxt: translate('field.email'),
            wdt: 343,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: HintName(
            hedrtxt: translate('field.phone').toUpperCase(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
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
                      controller: step1controller.numcontroller,
                      onChanged: (num) {
                        registrationController.phnmer.value = num;
                        step1controller.onNxtpg();
                      },
                      decoration: InputDecoration(
                          hintText: "00000 00000",
                          // prefixIcon: CountryCodePicker(
                          //   flagWidth: 33,
                          //   showDropDownButton: true,
                          //   hideMainText: true,
                          //   showFlagMain: true,
                          //   initialSelection: "IN",
                          // ),
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
          padding: const EdgeInsets.only(top: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 1,
                color: Color(0XFFD3DEEA),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 16,right: 16,bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0XFF2196F3))),
                        width: double.infinity,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            step1controller.onBack();
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
                              color: step1controller.isEnable.isTrue
                                  ? Color(0XFF2196F3)
                                  : Color(0XFFB8DFFF),
                            ),
                            width: double.infinity,
                            height: 43,
                            child: TextButton(
                              onPressed: () {
                                step1controller.onindexChang();
                                registrationController.scrollDown();
                              },
                              child: Text(
                                translate("Next"),
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
