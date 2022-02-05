import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/login_page_controller.dart';

class LagIcon extends StatelessWidget {
  var buttoncolor;

  LagIcon({this.buttoncolor});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.language,
        size: 19.97,
        color:buttoncolor,
      ),
      onPressed: () {
        showPopupMenu(context);
      },
    );
  }

  showPopupMenu(BuildContext context) {
    showMenu(
        context: context,
        items: [
          PopupMenuItem(
            height: 49,
            child: Obx(() => ListTile(
                title: Text(
                  translate('language.name.en'),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: loginController.selectedlan.value == "en_US"
                          ? Color(0XFF2196F3)
                          : Color(0XFFBCC8D6)),
                ),
                leading: Radio(
                    splashRadius: 7.0,
                    value: "en_US",
                    groupValue: loginController.selectedlan.value,
                    activeColor: Color(0XFF2196F3),
                    onChanged: (val) {
                        loginController.onChangelan(val);
                        // Navigator.pop(context, 'en_US');
                        Get.updateLocale(Locale('en', 'US'));

                    }))),
          ),
          PopupMenuItem(
            height: 49,
            child: Obx(() => ListTile(
                title: Text(
                  translate('language.name.ru'),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: loginController.selectedlan.value == "ru"
                          ? Color(0XFF2196F3)
                          : Color(0XFFBCC8D6)),
                ),
                leading: Radio(
                    splashRadius: 7.0,
                    value: "ru",
                    groupValue: loginController.selectedlan.value,
                    activeColor: Color(0XFF2196F3),
                    onChanged: (val) {

                        loginController.onChangelan(val);
                        // Navigator.pop(context, 'ru');
                        Get.updateLocale(Locale('ru', 'RU'));

                    }))),
          ),
          PopupMenuItem(
            height: 49,
            child: Obx(() => ListTile(
                title: Text(
                  translate('language.name.et'),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: loginController.selectedlan.value == "et"
                          ? Color(0XFF2196F3)
                          : Color(0XFFBCC8D6)),
                ),
                leading: Radio(
                    splashRadius: 7.0,
                    value: "et",
                    groupValue: loginController.selectedlan.value,
                    activeColor: Color(0XFF2196F3),
                    onChanged: (val) {

                        loginController.onChangelan(val);
                        // Navigator.pop(context, 'et');
                        Get.updateLocale(Locale('et', 'EE'));

                    }))),
          ),
          PopupMenuItem(
            height: 49,
            child: Obx(() => ListTile(
                title: Text(
                  translate('language.name.fi'),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: loginController.selectedlan.value == "fi"
                          ? Color(0XFF2196F3)
                          : Color(0XFFBCC8D6)),
                ),
                leading: Radio(
                    splashRadius: 7.0,
                    value: "fi",
                    groupValue: loginController.selectedlan.value,
                    activeColor: Color(0XFF2196F3),
                    onChanged: (val) {

                       loginController.onChangelan(val);
                       // Navigator.pop(context, 'fi');
                       Get.updateLocale(Locale('fi', 'FI'));
                    }))),
          ),
        ],
        position: RelativeRect.fromLTRB(192, 50, 16, 64));
  }
}