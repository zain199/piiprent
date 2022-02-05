import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/models/country_model.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/controller2.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/registration_controller.dart';
import 'package:piiprent/services/country_service.dart';
import 'package:provider/provider.dart';

import 'dropdown.dart';

Step2Controller step2controller = Get.put(Step2Controller());
RegistrationController registrationController =
    Get.put(RegistrationController());
CountryService countryService =
    Provider.of<CountryService>(Get.context, listen: false);

Widget buildResidencyFieldN(BuildContext context, bool isRequired) {
  return Dropdown<Country>(
    funchange: step2controller.onNxtpg2(),
    label: "",
    hint: translate('select.nationality'),
    future: countryService.getCountries,
    renderFn: (Country item) {
      // print(item.name);
      return item.name;
    },
    // compareFn: (Country item, Country selectedItem) {
    //   if (item.id == selectedItem.id) {
    //     registrationController.nationality.value = selectedItem.name;
    //   }
    //   return item.id == selectedItem.id;
    // },
    // onSaved: (Country item) {
    //   print(item.id);
    //   step2controller.nationality.value = item?.id;
    // },
    onChanged: (Country item) {
      print(item.id);
      registrationController.nationality.value = item?.id;
      print("name:${registrationController.nationality.value}");
    },
  );
}
