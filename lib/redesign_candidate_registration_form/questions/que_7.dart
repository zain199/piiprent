import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';

class Question7 extends StatelessWidget {
  QuestionController qcontroller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: qcontroller.langauges.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Obx(() => Container(
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
                            border: qcontroller.langauges[index].isChecked.value
                                ? Border.all(width: 1, color: Color(0XFF2196F3))
                                : null),
                        height: 62,
                        width: 352,
                        child: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Checkbox(
                                  checkColor: Color(0XFF2196F3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0)),
                                  activeColor: Colors.white,
                                  side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 1.0,
                                          color: qcontroller.langauges[index]
                                                  .isChecked.value
                                              ? Color(0XFF2196F3)
                                              : Color(0XFFD3DEEA))),
                                  value: qcontroller
                                      .langauges[index].isChecked.value,
                                  onChanged: (bool value) {
                                    qcontroller.langauges[index].isChecked
                                        .value = value;
                                    qcontroller.onLang();
                                  },
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              qcontroller.langauges[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  color: qcontroller
                                          .langauges[index].isChecked.value
                                      ? Color(0XFF2196F3)
                                      : Color(0XFFBCC8D6)),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  )
                ],
              );
            })
      ],
    );
  }
}
