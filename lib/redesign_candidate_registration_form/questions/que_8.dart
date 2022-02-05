import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/question_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/radio_container.dart';

class Question8 extends StatelessWidget {
  QuestionController qcontroller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 500,
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
            child: Obx(() => RadioContainer(
                  colorcondition: qcontroller.question8.value == "Tomorrow",
                  value: "Tomorrow",
                  text: "Tomorrow",
                  groupvalue: qcontroller.question8.value,
                  onchanged: (val) {
                    qcontroller.question8.value = val;
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
            child: Obx(() => RadioContainer(
                  colorcondition: qcontroller.question8.value == "Select day",
                  value: "Select day",
                  text: "Select day",
                  groupvalue: qcontroller.question8.value,
                  onchanged: (val) {
                    qcontroller.question8.value = val;
                  },
                )),
          ),
          Obx(() => qcontroller.question8.value == "Select day"
              ? Padding(
                  padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        // boxShadow:  [BoxShadow(
                        //     color: Color(0x215d7cac),
                        //     offset: Offset(0,4),
                        //     blurRadius: 38,
                        //     spreadRadius: 0
                        // ) ],
                        border: Border.all(width: 1, color: Color(0XFFD3DEEA))),
                    height: 62,
                    width: 343,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: TextFormField(
                        controller: qcontroller.datecontroller
                          ..text = qcontroller.selectedDate.value,
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF2F363D)),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: "00/00/0000",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18,
                              color: Color(0XFFD3DEEA),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                qcontroller.selectDate(context);
                                print(
                                    "length of list :${qcontroller.langauges.length}");
                              },
                              icon: Icon(
                                Icons.date_range_rounded,
                                size: 25,
                                color: Color(0XFF2196F3),
                              ),
                            )),
                      ),
                    ),
                  ))
              : SizedBox())
        ],
      ),
    );
  }
}
