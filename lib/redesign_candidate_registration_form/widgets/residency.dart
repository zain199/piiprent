import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/models/async_dropdown_option.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller2.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';

import 'dropdown.dart';

Step2Controller step2controller = Get.put(Step2Controller());
RegistrationController registrationController =
    Get.put(RegistrationController());

List<AsyncDropdownOption> residencyOptions = [
  const AsyncDropdownOption(
    id: '0',
    label: 'Unknown',
    translateKey: 'residency.unknown',
  ),
  const AsyncDropdownOption(
    id: '1',
    label: 'Citizen',
    translateKey: 'residency.citizen',
  ),
  const AsyncDropdownOption(
    id: '2',
    label: 'Permanent Resident',
    translateKey: 'residency.permanent_resident',
  ),
  const AsyncDropdownOption(
    id: '3',
    label: 'Temporary Resident',
    translateKey: 'residency.temporary_resident',
  ),
];

Widget buildResidencyField(BuildContext context, bool isRequired) {
  return Dropdown<AsyncDropdownOption>(
    funchange: step2controller.onNxtpg2(),
    // validator: isRequired == true ? requiredValidator : null,
    label: "",
    hint: translate('select.residency'),
    items: residencyOptions,
    renderFn: (AsyncDropdownOption item) => translate(item.translateKey),
    compareFn: (AsyncDropdownOption item, AsyncDropdownOption selectedItem) =>
        item.id == selectedItem.id,
    onSaved: (AsyncDropdownOption item) {
      registrationController.residency.value = item?.id;
      // step2controller.resdncycontroller..text=step2controller.residency.value;
    },
    onChanged: (AsyncDropdownOption item) {
      registrationController.residency.value = item?.id;
      print("Residency: ${registrationController.residency.value}");
    },
  );
}
