import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:piiprent/helpers/colors.dart';

class TimePickerBoxWidget extends StatelessWidget {
  TimePickerBoxWidget(
      {Key key, this.onTimeSelected, this.initialTime, this.initialDateTime})
      : super(key: key);
  final Function onTimeSelected;
  final TimeOfDay initialTime;
  final DateTime initialDateTime;
  final RxString selectedTimeStr = 'Time'.obs;

  @override
  Widget build(BuildContext context) {
    selectedTimeStr.value = initialDateTime != null
        ? TimeOfDay(hour: initialDateTime.hour, minute: initialDateTime.minute)
            .format(context)
        : 'Time';
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () async {
          var result = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
              hour: initialDateTime?.hour ?? 0,
              minute: initialDateTime?.minute ?? 0,
            ),
          );
          if (result != null) {
            selectedTimeStr.value = result.format(context);
            onTimeSelected?.call(
              DateTime(
                initialDateTime?.year ?? DateTime.now().year,
                initialDateTime?.month ?? DateTime.now().month,
                initialDateTime?.day ?? DateTime.now().day,
                result.hour,
                result.minute,
              ),
            );
          }
        },
        child: Ink(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            border: Border.all(
              width: 1,
              color: AppColors.blueBorder,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                    () => Text(
                  selectedTimeStr.value,
                  style: TextStyle(fontSize: 16, color: AppColors.lightBlack),
                ),
              ),
              SvgPicture.asset(
                "images/icons/ic_time.svg",
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
