import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller2.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';

class AddressFind extends StatefulWidget {
  final Stream setStream;
  final dynamic initialValue;

  AddressFind({
    this.setStream,
    this.initialValue,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressFinder();
  }
}

class AddressFinder extends State<AddressFind> {
  @override
  void initState() {
    setValue(widget.initialValue);

    if (widget.setStream != null) {
      widget.setStream.listen((event) {
        setValue(event);
      });
    }

    super.initState();
  }

  setValue(dynamic value) {
    step2controller.adrescontroller.text = value;
  }

  StreamController<String> addressStreamController = StreamController();
  RegistrationController registrationController =
      Get.put(RegistrationController());
  Step2Controller step2controller = Get.put(Step2Controller());

  dynamic addess;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 49,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0XFFD3DEEA))),
      // InkWell(
      //   onTap: () {
      //     Navigator.pushNamed(context, '/address').then((value) {
      //       if (value != null) {
      //         // addressStreamController
      //         //     .add((value as Map<String, dynamic>)['streetAddress']);
      //         //
      //         if(value is String ){
      //           addess = value;
      //           registrationController.adres.value = addess;
      //         }
      //         else {
      //             addess = (value as Map<String, dynamic>)['streetAddress'];
      //             registrationController.adres.value = addess.toString();
      //           }
      //           print("address: ${registrationController.adres.value}");
      //       }
      //     });
      //   },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Obx(() => TextFormField(
            minLines: 1,
            controller: step2controller.adrescontroller
              ..text = registrationController.adres.value,
            readOnly: true,
            onTap: () {
              Navigator.pushNamed(context, '/address').then((value) {
                if (value != null) {
                  addressStreamController
                      .add((value as Map<String, dynamic>)['streetAddress']);

                  addess = (value as Map<String, dynamic>)['streetAddress'];
                  registrationController.adres.value = addess.toString();
                  registrationController.addessforapi =
                      (value as Map<String, dynamic>)['address'];
                  print(
                      "AddressforApi : ${registrationController.addessforapi}");
                }
              });
            },
            onSaved: (addess) {
              registrationController.adres.value = addess.toString();
            },
            onChanged: (addess) {
              registrationController.adres.value = addess.toString();
            },
            decoration: InputDecoration(
                hintText: translate('enter.location'),
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    color: Color(0XFFD3DEEA))),
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0XFF2F363D)))),
      ),
    );
  }
}
