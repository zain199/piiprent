import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller2.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/addres_select.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/hint_name.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/nationality.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/residency.dart';
import 'package:piiprent/services/country_service.dart';
import 'package:provider/provider.dart';

import 'controller/registration_controller.dart';

class Step2 extends StatelessWidget {
  Step2Controller step2controller = Get.put(Step2Controller());
  CountryService countryService =
      Provider.of<CountryService>(Get.context, listen: false);
  RegistrationController registrationController =
      Get.put(RegistrationController());
  StreamController<String> addressStreamController = StreamController();

  // CountryService countryService;
  // var radio = "";
  // String _nationality;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 1000,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('page.title.address').toUpperCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: AddressFind(
              setStream: addressStreamController.stream,
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.nationality').toUpperCase(),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0XFFD3DEEA))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: buildResidencyFieldN(context, true),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.residency').toUpperCase(),
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
                child: buildResidencyField(context, true),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16),
            child: HintName(
              hedrtxt: translate('field.transport').toUpperCase(),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                      color: registrationController.tranport.value == "1"
                          ? Color(0XFF2196F3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0XFFD3DEEA))),
                  height: 39,
                  width: 163,
                  child: Row(
                    children: [
                      Radio(
                          splashRadius: 7.0,
                          value: "1",
                          groupValue: registrationController.tranport.value,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            step2controller.transpotSelct(val);
                            step2controller.onNxtpg2();
                            // radio = val;
                          }),
                      // SizedBox(width:5,),
                      Text(
                        translate('transport1'),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color:
                            registrationController.tranport.value == "1"
                                ? Colors.white
                                : Color(0XFFBCC8D6)),
                      ),
                    ],
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 10),
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                      color: registrationController.tranport.value == "2"
                          ? Color(0XFF2196F3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0XFFD3DEEA))),
                  height: 39,
                  width: 181,
                  child: Row(
                    children: [
                      Radio(
                          splashRadius: 7.0,
                          value: "2",
                          groupValue: registrationController.tranport.value,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            print(val);
                            step2controller.transpotSelct(val);
                            step2controller.onNxtpg2();
                          }),
                      // SizedBox(width:5,),
                      Text(
                        translate('transport2'),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color:
                            registrationController.tranport.value == "2"
                                ? Colors.white
                                : Color(0XFFBCC8D6)),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
          SizedBox(
            height: 165,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
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
                            step2controller.onBack2();
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
                          color: step2controller.isEnable.isTrue
                              ? Color(0XFF2196F3)
                              : Color(0XFFB8DFFF),
                        ),
                        width: 164,
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            step2controller.onNextpage();
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
          )
        ],
      ),
    );
  }

// Widget _buildNationalityField(BuildContext context) {
//   return AsyncDropdown<Country>(
//     label: translate('field.nationality'),
//     future: this.countryService.getCountries,
//     renderFn: (Country item) => item.name,
//     compareFn: (Country item, Country selectedItem) =>
//     item.id == selectedItem.id,
//     onSaved: (Country item) {
//       _nationality = item?.id;
//     },
//   );
// }

}
