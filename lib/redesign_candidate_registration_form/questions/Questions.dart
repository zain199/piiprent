import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/login_new_page.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/Ques_1.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_3.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_4.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_5.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_6.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_7.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_8.dart';
import 'package:piiprent/redesign_candidate_registration_form/questions/que_9.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/quecontainer.dart';

import 'que_2.dart';

class GeneralQues extends StatelessWidget {
  QuestionController qcontroller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        automaticallyImplyLeading: false,
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.only(top: 19, bottom: 19),
            child: Text(
              "General questions",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontSize: 22),
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                Get.back(result: LoginNewPage());
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: Container(
              height: 42,
              width: 86,
              child: Obx(() => RichText(
                    text: TextSpan(
                        text: qcontroller.index.value == 0
                            ? "01"
                            : qcontroller.index.value == 1
                                ? "02"
                                : qcontroller.index.value == 2
                                    ? "03"
                                    : qcontroller.index.value == 3
                                        ? "04"
                                        : qcontroller.index.value == 4
                                            ? "05"
                                            : qcontroller.index.value == 5
                                                ? "06"
                                                : qcontroller.index.value == 6
                                                    ? "07"
                                                    : qcontroller.index.value ==
                                                            7
                                                        ? "08"
                                                        : "09",
                        style: TextStyle(
                            fontSize: 36,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF2196F3)),
                        children: [
                          TextSpan(
                              text: "of09",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  color: Color(0XFFBCC8D6)))
                        ]),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Obx(() => LinearPercentIndicator(
                  lineHeight: 10,
                  percent: qcontroller.progressvalue.value,
                  progressColor: Color(0XFF2196F3),
                  backgroundColor: Color(0XFFEEF6FF),
                )),
          ),
          SizedBox(
            height: 45,
          ),
          Obx(() => QuestionContneir(
                text: qcontroller.Questionlist[qcontroller.index.value],
                fontsize: 24,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Obx(
                () => IndexedStack(index: qcontroller.index.value, children: [
                      Question1(),
                      Question2(),
                      Question3(),
                      Question4(),
                      Question5(),
                      Question6(),
                      Question7(),
                      Question8(),
                      Question9(),
                    ])),
          ),
        ],
      ),
      bottomSheet: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 1,
            color: Color(0XFFD3DEEA),
            width: 390,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 16, bottom: 30),
            child: Row(
              children: [
                Obx(() => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: qcontroller.index.value == 0
                                  ? Color(0XFFB8DFFF)
                                  : Color(0XFF2196F3))),
                      width: 164,
                      height: 43,
                      child: TextButton(
                        onPressed: qcontroller.index.value == 0
                            ? () {}
                            : () {
                                qcontroller.progressUpdate();
                                qcontroller.index.value =
                                    qcontroller.index.value - 1;
                              },
                        child: Text(
                          translate("Back"),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color: qcontroller.index.value == 0
                                  ? Color(0XFFB8DFFF)
                                  : Color(0XFF2196F3)),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Obx(() => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: qcontroller.index.value == 0
                              ? qcontroller.question1.value.isEmpty
                                  ? Color(0XFFB8DFFF)
                                  : Color(0XFF2196F3)
                              : qcontroller.index.value == 1
                                  ? qcontroller.question2.value.isEmpty
                                      ? Color(0XFFB8DFFF)
                                      : Color(0XFF2196F3)
                                  : qcontroller.index.value == 2
                                      ? qcontroller.question3.value.isEmpty
                                          ? Color(0XFFB8DFFF)
                                          : Color(0XFF2196F3)
                                      : qcontroller.index.value == 3
                                          ? qcontroller.question4.value.isEmpty
                                              ? Color(0XFFB8DFFF)
                                              : Color(0XFF2196F3)
                                          : qcontroller.index.value == 4
                                              ? qcontroller
                                                      .question5.value.isEmpty
                                                  ? Color(0XFFB8DFFF)
                                                  : Color(0XFF2196F3)
                                              : qcontroller.index.value == 5
                                                  ? qcontroller.question6.value
                                                          .isEmpty
                                                      ? Color(0XFFB8DFFF)
                                                      : Color(0XFF2196F3)
                                                  : qcontroller.index.value == 6
                                                      ? qcontroller.isLan
                                                                  .value ==
                                                              false
                                                          ? Color(0XFFB8DFFF)
                                                          : Color(0XFF2196F3)
                                                      : qcontroller.index
                                                                  .value ==
                                                              7
                                                          ? qcontroller
                                                                  .question8
                                                                  .value
                                                                  .isEmpty
                                                              ? Color(
                                                                  0XFFB8DFFF)
                                                              : Color(
                                                                  0XFF2196F3)
                                                          : qcontroller.isEnable
                                                                      .value ==
                                                                  false
                                                              ? Color(
                                                                  0XFFB8DFFF)
                                                              : Color(
                                                                  0XFF2196F3)),
                      width: 164,
                      height: 43,
                      child: TextButton(
                        onPressed: () => qcontroller.index.value == 0
                            ? qcontroller.question1.value.isEmpty
                                ? {}
                                : qcontroller.onpressed()
                            : qcontroller.index.value == 1
                                ? qcontroller.question2.value.isEmpty
                                    ? {}
                                    : qcontroller.onpressed()
                                : qcontroller.index.value == 2
                                    ? qcontroller.question3.value.isEmpty
                                        ? {}
                                        : qcontroller.onpressed()
                                    : qcontroller.index.value == 3
                                        ? qcontroller.question4.value.isEmpty
                                            ? {}
                                            : qcontroller.onpressed()
                                        : qcontroller.index.value == 4
                                            ? qcontroller
                                                    .question5.value.isEmpty
                                                ? {}
                                                : qcontroller.onpressed()
                                            : qcontroller.index.value == 5
                                                ? qcontroller
                                                        .question6.value.isEmpty
                                                    ? {}
                                                    : qcontroller.onpressed()
                                                : qcontroller.index.value == 6
                                                    ? qcontroller.isLan.value ==
                                                            false
                                                        ? {}
                                                        : qcontroller
                                                            .onpressed()
                                                    : qcontroller.index.value ==
                                                            7
                                                        ? qcontroller.question1
                                                                .value.isEmpty
                                                            ? {}
                                                            : qcontroller
                                                                .onpressed()
                                                        : qcontroller.isEnable
                                                                    .value ==
                                                                false
                                                            ? () {}
                                                            : qcontroller
                                                                .onpressed(),
                        child: qcontroller.index.value < 8
                            ? Text(
                                translate("Next"),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white),
                              )
                            : Text(
                                "Submit",
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
    );
  }
}
