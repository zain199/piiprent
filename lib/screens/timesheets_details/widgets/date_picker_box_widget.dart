import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/helpers/colors.dart';

class DatePickerBoxWidget extends StatelessWidget {
  DatePickerBoxWidget({Key key, this.onDateSelected, this.initialDate})
      : super(key: key);
  final Function onDateSelected;
  final DateTime initialDate;
  final RxString dateStr = 'Date'.obs;

  @override
  Widget build(BuildContext context1) {
    dateStr.value = initialDate != null
        ? DateFormat('MMM dd, yyyy').format(initialDate)
        : 'Date';
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () async {
          var result = await showDatePicker(
            context: context1,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime(DateTime.now().year, DateTime.now().month - 2),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month + 2),
          );
          if (result != null) {
            dateStr.value = DateFormat('MMM dd, yyyy').format(result);
            onDateSelected?.call(result);
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
                  dateStr.value,
                  style: TextStyle(fontSize: 16, color: AppColors.lightBlack),
                ),
              ),
              SvgPicture.asset(
                "images/icons/ic_date.svg",
                height: 20,
                width: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
